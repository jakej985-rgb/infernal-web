import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../shared/cache/id_mapper.dart';
import '../../../shared/domain/enums.dart';
import '../../../shared/domain/user.dart';
import 'auth_state.dart';

part 'auth_service.g.dart';

@Riverpod(keepAlive: true)
class AuthService extends _$AuthService {
  @override
  FutureOr<AuthState> build() async {
    final fbUser = fb.FirebaseAuth.instance.currentUser;
    if (fbUser != null) {
      try {
        final doc = await FirebaseFirestore.instance
            .collection('organizations')
            .doc('default-org')
            .collection('users')
            .doc(fbUser.uid)
            .get();

        if (doc.exists) {
          final user = _mapDocToUser(fbUser.uid, fbUser.email ?? '', doc.data() ?? {});
          return AuthState.authenticated(user);
        }
      } catch (e) {
        return const AuthState.unauthenticated();
      }
    }
    return const AuthState.unauthenticated();
  }

  Future<void> login(String username, String password) async {
    state = const AsyncValue.data(AuthState.loading());

    try {
      final credential = await fb.FirebaseAuth.instance.signInWithEmailAndPassword(
        email: username,
        password: password,
      );
      final fbUser = credential.user;
      if (fbUser == null) {
        state = const AsyncValue.data(AuthState.error('Authentication failed'));
        return;
      }

      // Fetch or seed user record in Firestore
      final docRef = FirebaseFirestore.instance
          .collection('organizations')
          .doc('default-org')
          .collection('users')
          .doc(fbUser.uid);

      var doc = await docRef.get();
      if (!doc.exists) {
        final initialRole = username == 'admin@inkandsteel.xyz' ? 'admin' : 'artist';
        await docRef.set({
          'email': username,
          'displayName': username.split('@').first,
          'role': initialRole,
          'hourlyRate': 150.0,
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        });
        doc = await docRef.get();
      }

      final user = _mapDocToUser(fbUser.uid, fbUser.email ?? '', doc.data() ?? {});
      state = AsyncValue.data(AuthState.authenticated(user));
    } on fb.FirebaseException catch (e) {
      state = AsyncValue.data(AuthState.error(e.message ?? 'Authentication failed'));
    } catch (e) {
      state = AsyncValue.data(AuthState.error(e.toString()));
    }
  }

  Future<void> logout() async {
    state = const AsyncValue.data(AuthState.loading());
    try {
      await fb.FirebaseAuth.instance.signOut();
      state = const AsyncValue.data(AuthState.unauthenticated());
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> seedAdmin() async {
    return;
  }

  User _mapDocToUser(String uid, String email, Map<String, dynamic> data) {
    final roleStr = data['role'] as String? ?? 'artist';
    final displayName = data['displayName'] as String? ?? email.split('@').first;
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
