import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../shared/cache/id_mapper.dart';
import '../../../shared/data/org_provider.dart';
import '../../../shared/domain/enums.dart';
import '../../../shared/domain/user.dart';
import 'auth_state.dart';

part 'auth_service.g.dart';

@Riverpod(keepAlive: true)
class AuthService extends _$AuthService {
  @override
  FutureOr<AuthState> build() async {
    final completer = Completer<AuthState>();

    final subscription = fb.FirebaseAuth.instance.authStateChanges().listen((fbUser) async {
      if (fbUser == null) {
        if (!completer.isCompleted) {
          completer.complete(const AuthState.unauthenticated());
        } else {
          state = const AsyncValue.data(AuthState.unauthenticated());
        }
      } else {
        try {
          final orgIdVal = ref.watch(orgIdProvider);
          final docRef = FirebaseFirestore.instance
              .collection('organizations')
              .doc(orgIdVal)
              .collection('users')
              .doc(fbUser.uid);

          var doc = await docRef.get();
          if (!doc.exists) {
            // Self-heal: Create default user document in Firestore if missing
            final email = fbUser.email ?? '';
            final isAdmin = email == 'admin@inkandsteel.xyz';
            await docRef.set({
              'email': email,
              'displayName': email.split('@').first,
              'role': isAdmin ? 'admin' : 'artist',
              'hourlyRate': 150.0,
              'createdAt': FieldValue.serverTimestamp(),
              'updatedAt': FieldValue.serverTimestamp(),
            });
            doc = await docRef.get();
          }

          if (doc.data()?['isDeleted'] == true) {
            // User Firestore doc is marked deleted -> FORCE LOGOUT
            await fb.FirebaseAuth.instance.signOut();
            if (!completer.isCompleted) {
              completer.complete(const AuthState.unauthenticated());
            } else {
              state = const AsyncValue.data(AuthState.unauthenticated());
            }
            return;
          }

          final user = _mapDocToUser(
            fbUser.uid,
            fbUser.email ?? '',
            doc.data() ?? {},
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

  Future<void> login(String username, String password) async {
    state = const AsyncValue.data(AuthState.loading());

    try {
      final resolvedEmail = username.contains('@')
          ? username
          : '$username@inkandsteel.xyz';

      await fb.FirebaseAuth.instance.signInWithEmailAndPassword(
        email: resolvedEmail,
        password: password,
      );
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
        final orgIdVal = ref.read(orgIdProvider);
        // 2. Create the Firestore document inside 'organizations/default-org/users'
        final docRef = FirebaseFirestore.instance
            .collection('organizations')
            .doc(orgIdVal)
            .collection('users')
            .doc(fbUser.uid);

        await docRef.set({
          'email': 'admin@inkandsteel.xyz',
          'displayName': 'admin',
          'role': 'admin',
          'hourlyRate': 150.0,
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }
    } on fb.FirebaseException catch (e) {
      if (e.code == 'email-already-in-use') {
        // If the Firebase Auth user already exists, let's make sure the Firestore document is set up properly.
        try {
          final credential = await fb.FirebaseAuth.instance
              .signInWithEmailAndPassword(
                email: 'admin@inkandsteel.xyz',
                password: 'adminadmin',
              );
          final fbUser = credential.user;
          if (fbUser != null) {
            final orgIdVal = ref.read(orgIdProvider);
            final docRef = FirebaseFirestore.instance
                .collection('organizations')
                .doc(orgIdVal)
                .collection('users')
                .doc(fbUser.uid);

            await docRef.set({
              'email': 'admin@inkandsteel.xyz',
              'displayName': 'admin',
              'role': 'admin',
              'hourlyRate': 150.0,
              'createdAt': FieldValue.serverTimestamp(),
              'updatedAt': FieldValue.serverTimestamp(),
            }, SetOptions(merge: true));
          }
        } catch (_) {
          // If sign-in fails or some other issue occurs, ignore it
        }
      } else {
        rethrow;
      }
    }
  }

  User _mapDocToUser(String uid, String email, Map<String, dynamic> data) {
    final roleStr = data['role'] as String? ?? 'artist';
    final displayName =
        data['displayName'] as String? ?? email.split('@').first;
    final hourlyRate = (data['hourlyRate'] as num?)?.toDouble() ?? 150.0;

    var id = uid.hashCode & 0x7FFFFFFF;
    if (id == 0) id = 1;

    ref.read(idMapperProvider).registerUuid('user', uid);

    return User(
      id: id,
      username: email,
      displayName: displayName,
      passwordHash: '',
      role: UserRole.values.firstWhere(
        (e) => e.name.toLowerCase() == roleStr.toLowerCase(),
        orElse: () => UserRole.artist,
      ),
      hourlyRate: hourlyRate,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}
