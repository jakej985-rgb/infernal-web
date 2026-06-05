import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../shared/cache/id_mapper.dart';
import '../../../shared/core/services/user_service.dart';
import '../../../shared/domain/user.dart';
import 'auth_state.dart';

part 'auth_service.g.dart';

@Riverpod(keepAlive: true)
class AuthService extends _$AuthService {
  @override
  FutureOr<AuthState> build() async {
    final completer = Completer<AuthState>();
    final userService = ref.watch(userServiceProvider);

    final subscription = fb.FirebaseAuth.instance.authStateChanges().listen((fbUser) async {
      if (fbUser == null) {
        if (!completer.isCompleted) {
          completer.complete(const AuthState.unauthenticated());
        } else {
          state = const AsyncValue.data(AuthState.unauthenticated());
        }
      } else {
        try {
          // 1. Resolve organization ID from global registry
          final userMapDoc = await FirebaseFirestore.instance.collection('users').doc(fbUser.uid).get();
          String resolvedOrgId = 'default-org';
          if (userMapDoc.exists) {
            resolvedOrgId = userMapDoc.data()?['orgId'] as String? ?? 'default-org';
          }

          // 2. Read user profile from UserService using the resolved organization ID
          final userProfile = await userService.getUserById(fbUser.uid, resolvedOrgId);

          if (userProfile == null) {
            // Profile not initialized yet, wait for initializeUserProfile to be called explicitly
            if (!completer.isCompleted) {
              completer.complete(const AuthState.unauthenticated());
            } else {
              state = const AsyncValue.data(AuthState.unauthenticated());
            }
            return;
          }

          if (userProfile.isDeleted) {
            // User doc is marked deleted -> FORCE LOGOUT
            await fb.FirebaseAuth.instance.signOut();
            if (!completer.isCompleted) {
              completer.complete(const AuthState.unauthenticated());
            } else {
              state = const AsyncValue.data(AuthState.unauthenticated());
            }
            return;
          }

          // Register UID in mapper
          ref.read(idMapperProvider).registerUuid('user', fbUser.uid);

          final user = User(
            id: userProfile.id,
            username: userProfile.username,
            displayName: userProfile.displayName,
            orgId: resolvedOrgId,
            passwordHash: '',
            role: userProfile.role,
            hourlyRate: userProfile.hourlyRate,
            createdAt: userProfile.createdAt,
            updatedAt: userProfile.updatedAt,
          );

          if (!completer.isCompleted) {
            completer.complete(AuthState.authenticated(user));
          } else {
            state = AsyncValue.data(AuthState.authenticated(user));
          }
        } catch (e) {
          if (!completer.isCompleted) {
            completer.complete(const AuthState.unauthenticated());
          } else {
            state = const AsyncValue.data(AuthState.unauthenticated());
          }
        }
      }
    });

    ref.onDispose(() {
      subscription.cancel();
    });

    return completer.future;
  }

  /// Explicitly initialize user profile document in Firestore after sign-up/login if missing.
  Future<void> initializeUserProfile(String uid, String email, [String? orgId]) async {
    final resolvedOrgId = orgId ?? 'default-org';
    final userService = ref.read(userServiceProvider);
    var existing = await userService.getUserById(uid, resolvedOrgId);
    if (existing == null) {
      final isAdmin = email == 'admin@inkandsteel.xyz';
      await userService.createUserWithUid(
        uid: uid,
        email: email,
        displayName: email.split('@').first,
        role: isAdmin ? 'admin' : 'artist',
        hourlyRate: 150.0,
        orgId: resolvedOrgId,
      );
      existing = await userService.getUserById(uid, resolvedOrgId);
    }

    if (existing != null && !existing.isDeleted) {
      ref.read(idMapperProvider).registerUuid('user', uid);
      final user = User(
        id: existing.id,
        username: existing.username,
        displayName: existing.displayName,
        orgId: resolvedOrgId,
        passwordHash: '',
        role: existing.role,
        hourlyRate: existing.hourlyRate,
        createdAt: existing.createdAt,
        updatedAt: existing.updatedAt,
      );
      state = AsyncValue.data(AuthState.authenticated(user));
    }
  }

  Future<void> login(String username, String password) async {
    state = const AsyncValue.data(AuthState.loading());

    try {
      final resolvedEmail = username.contains('@')
          ? username
          : '$username@inkandsteel.xyz';

      final credential = await fb.FirebaseAuth.instance.signInWithEmailAndPassword(
        email: resolvedEmail,
        password: password,
      );

      final fbUser = credential.user;
      if (fbUser != null) {
        // Resolve orgId first to initialize profile in correct workspace
        final userMapDoc = await FirebaseFirestore.instance.collection('users').doc(fbUser.uid).get();
        final resolvedOrgId = userMapDoc.exists ? (userMapDoc.data()?['orgId'] as String? ?? 'default-org') : 'default-org';

        // Explicitly initialize profile to ensure it exists, with no side-effects in build()
        await initializeUserProfile(fbUser.uid, fbUser.email ?? resolvedEmail, resolvedOrgId);
      }
    } on fb.FirebaseException catch (e) {
      state = AsyncValue.data(
        AuthState.error(e.message ?? 'Authentication failed'),
      );
    } catch (e) {
      state = AsyncValue.data(AuthState.error(e.toString()));
    }
  }

  Future<void> logout() async {
    state = const AsyncValue.data(AuthState.loading());
    try {
      await fb.FirebaseAuth.instance.signOut();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> seedAdmin() async {
    try {
      // 1. Create the user in Firebase Auth with 'adminadmin' password
      final credential = await fb.FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: 'admin@inkandsteel.xyz',
            password: 'adminadmin',
          );
      final fbUser = credential.user;
      if (fbUser != null) {
        // 2. Delegate profile creation to UserService
        final userService = ref.read(userServiceProvider);
        await userService.createUserWithUid(
          uid: fbUser.uid,
          email: 'admin@inkandsteel.xyz',
          displayName: 'admin',
          role: 'admin',
          hourlyRate: 150.0,
          orgId: 'default-org',
        );
      }
    } on fb.FirebaseException catch (e) {
      if (e.code == 'email-already-in-use') {
        try {
          final credential = await fb.FirebaseAuth.instance
              .signInWithEmailAndPassword(
                email: 'admin@inkandsteel.xyz',
                password: 'adminadmin',
              );
          final fbUser = credential.user;
          if (fbUser != null) {
            final userService = ref.read(userServiceProvider);
            await userService.createUserWithUid(
              uid: fbUser.uid,
              email: 'admin@inkandsteel.xyz',
              displayName: 'admin',
              role: 'admin',
              hourlyRate: 150.0,
              orgId: 'default-org',
            );
          }
        } catch (_) {
          // If sign-in fails or some other issue occurs, ignore it
        }
      } else {
        rethrow;
      }
    }
  }

  Future<void> submitShopRequest({
    required String email,
    required String shopName,
    required String shopId,
    required String displayName,
  }) async {
    state = const AsyncValue.data(AuthState.loading());
    try {
      final docRef = FirebaseFirestore.instance.collection('requests').doc();
      final docId = docRef.id;
      await docRef.set({
        'id': docId,
        'email': email,
        'shopName': shopName,
        'shopId': shopId,
        'displayName': displayName,
        'status': 'pending',
        'requestedAt': FieldValue.serverTimestamp(),
      });
      state = const AsyncValue.data(AuthState.unauthenticated());
    } catch (e) {
      state = AsyncValue.data(AuthState.error(e.toString()));
      rethrow;
    }
  }

  Future<void> approveShopRequest(String requestId, String inviteToken) async {
    try {
      await FirebaseFirestore.instance.collection('requests').doc(requestId).update({
        'status': 'approved',
        'inviteToken': inviteToken,
        'approvedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> rejectShopRequest(String requestId) async {
    try {
      await FirebaseFirestore.instance.collection('requests').doc(requestId).update({
        'status': 'rejected',
        'rejectedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> claimShopRequest({
    required String requestId,
    required String inviteToken,
    required String password,
  }) async {
    state = const AsyncValue.data(AuthState.loading());
    try {
      // 1. Fetch and validate the request
      final doc = await FirebaseFirestore.instance.collection('requests').doc(requestId).get();
      if (!doc.exists) {
        throw Exception('Sanctum request not found.');
      }
      final data = doc.data()!;
      if (data['status'] != 'approved') {
        throw Exception('This request has not been approved yet.');
      }
      if (data['inviteToken'] != inviteToken) {
        throw Exception('Invalid invitation token.');
      }

      final email = data['email'] as String;
      final orgId = data['shopId'] as String;
      final orgName = data['shopName'] as String;
      final displayName = data['displayName'] as String;

      // 2. Create account in Firebase Auth
      final credential = await fb.FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final fbUser = credential.user;
      if (fbUser == null) {
        throw Exception('User registration failed - Auth credential not created.');
      }

      // 3. Create the Organization document
      await FirebaseFirestore.instance.collection('organizations').doc(orgId).set({
        'name': orgName,
      });

      // 4. Create the profile and global mapping
      final userService = ref.read(userServiceProvider);
      await userService.createUserWithUid(
        uid: fbUser.uid,
        email: email,
        displayName: displayName,
        role: 'owner',
        hourlyRate: 150.0,
        orgId: orgId,
      );

      // 5. Create default settings
      await FirebaseFirestore.instance
          .collection('organizations')
          .doc(orgId)
          .collection('settings')
          .doc('main')
          .set({
        'settings': {
          'shopName': orgName,
          'logoPath': '',
          'accentColor': '#FF0000',
          'depositType': 'percentage',
          'depositAmount': 20.0,
          'tattooPerHour': 150.0,
          'piercingSingle': 50.0,
          'piercingMulti': 80.0,
          'shopMinimumRate': 80.0,
          'taxRate': 0.08,
        }
      });

      // 6. Mark request as claimed in Firestore
      await FirebaseFirestore.instance.collection('requests').doc(requestId).update({
        'status': 'claimed',
        'claimedAt': FieldValue.serverTimestamp(),
      });

      // 7. Initialize profile mapping to bind user session state
      await initializeUserProfile(fbUser.uid, email, orgId);

    } on fb.FirebaseException catch (e) {
      state = AsyncValue.data(
        AuthState.error(e.message ?? 'Registration failed'),
      );
      rethrow;
    } catch (e) {
      state = AsyncValue.data(AuthState.error(e.toString()));
      rethrow;
    }
  }
}
