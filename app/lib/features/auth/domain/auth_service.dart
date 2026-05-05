import 'package:bcrypt/bcrypt.dart';
import 'package:drift/drift.dart' show Value;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../shared/persistence/database.dart';
import '../../../shared/util/shared_prefs_provider.dart';
import '../data/user_repository.dart';
import 'auth_state.dart';

part 'auth_service.g.dart';

@Riverpod(keepAlive: true)
class AuthService extends _$AuthService {
  static const _userSessionKey = 'user_session_id';

  @override
  FutureOr<AuthState> build() async {
    // Attempt to restore session
    final prefs = ref.watch(sharedPreferencesProvider);
    final userId = prefs.getInt(_userSessionKey);

    if (userId != null) {
      final repo = ref.watch(userRepositoryProvider);
      final user = await repo.getUserById(userId);
      if (user != null) {
        return AuthState.authenticated(user);
      }
    }

    return const AuthState.unauthenticated();
  }

  Future<void> login(String username, String password) async {
    state = const AsyncValue.data(AuthState.loading());

    try {
      final repo = ref.read(userRepositoryProvider);
      final user = await repo.getUserByUsername(username);

      if (user == null) {
        state = const AsyncValue.data(AuthState.error('User not found'));
        return;
      }

      // Check password using BCrypt
      final isValid = BCrypt.checkpw(password, user.passwordHash);
      
      if (!isValid) {
        state = const AsyncValue.data(AuthState.error('Invalid credentials'));
        return;
      }

      // Login successful
      final prefs = ref.read(sharedPreferencesProvider);
      await prefs.setInt(_userSessionKey, user.id);

      state = AsyncValue.data(AuthState.authenticated(user));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> logout() async {
    state = const AsyncValue.data(AuthState.loading());
    try {
      final prefs = ref.read(sharedPreferencesProvider);
      await prefs.remove(_userSessionKey);
      state = const AsyncValue.data(AuthState.unauthenticated());
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> seedAdmin() async {
    final repo = ref.read(userRepositoryProvider);
    // double check if admin exists
    final admin = await repo.getUserByUsername('admin');
    if (admin != null) return;

    // Hash the password 'admin'
    final hashedPassword = BCrypt.hashpw('admin', BCrypt.gensalt());

    // Create admin user
    await repo.createUser(
      UsersCompanion.insert(
        username: 'admin',
        passwordHash: Value(hashedPassword),
        displayName: const Value('Admin User'),
        role: const Value('admin'),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        hourlyRate: const Value(150.0),
        isActive: const Value(true),
      ),
    );
  }
}
