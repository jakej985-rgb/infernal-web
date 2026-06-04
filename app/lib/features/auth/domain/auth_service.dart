import 'dart:async';
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
          // Read user profile from UserService (no direct Firestore calls, no self-healing writes here)
          final userProfile = await userService.getUserById(fbUser.uid);

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
  Future<void> initializeUserProfile(String uid, String email) async {
    final userService = ref.read(userServiceProvider);
    final existing = await userService.getUserById(uid);
    if (existing == null) {
      final isAdmin = email == 'admin@inkandsteel.xyz';
      await userService.createUserWithUid(
        uid: uid,
        email: email,
        displayName: email.split('@').first,
        role: isAdmin ? 'admin' : 'artist',
        hourlyRate: 150.0,
      );
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
        // Explicitly initialize profile to ensure it exists, with no side-effects in build()
        await initializeUserProfile(fbUser.uid, fbUser.email ?? resolvedEmail);
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
}
