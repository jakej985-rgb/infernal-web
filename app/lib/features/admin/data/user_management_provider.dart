import 'package:bcrypt/bcrypt.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../shared/persistence/database.dart';
import 'package:drift/drift.dart' show Value;

part 'user_management_provider.g.dart';

/// Provider for all users - using raw StreamProvider to avoid generator issues with Drift types
final allUsersProvider = StreamProvider<List<User>>((ref) {
  final dao = ref.watch(databaseProvider).usersDao;
  return dao.watchAllUsers();
});

@riverpod
UserManagementService userManagementService(Ref ref) {
  return UserManagementService(ref);
}

class UserManagementService {
  final Ref _ref;
  UserManagementService(this._ref);

  Future<void> createUser({
    required String username,
    required String password,
    required String displayName,
    required String role,
    double? hourlyRate,
  }) async {
    final dao = _ref.read(databaseProvider).usersDao;
    
    // Hash password
    final hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
    
    await dao.insertUser(
      UsersCompanion.insert(
        username: username,
        passwordHash: Value(hashedPassword),
        displayName: Value(displayName),
        role: Value(role),
        hourlyRate: Value(hourlyRate ?? 150.0),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
  }

  Future<void> updateUser(User user, {String? newPassword}) async {
    final dao = _ref.read(databaseProvider).usersDao;
    
    User updatedUser = user.copyWith(updatedAt: DateTime.now());
    if (newPassword != null && newPassword.isNotEmpty) {
      final hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());
      updatedUser = updatedUser.copyWith(passwordHash: hashedPassword);
    }
    
    await dao.updateUser(updatedUser);
  }

  Future<void> deleteUser(int id) async {
    final dao = _ref.read(databaseProvider).usersDao;
    await dao.softDeleteUser(id);
  }
}

