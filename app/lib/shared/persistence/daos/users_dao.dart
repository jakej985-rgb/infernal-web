import 'package:drift/drift.dart';

import '../database.dart';
import '../tables/users_table.dart';

part 'users_dao.g.dart';

/// Data Access Object for Users table
@DriftAccessor(tables: [Users])
class UsersDao extends DatabaseAccessor<AppDatabase> with _$UsersDaoMixin {
  UsersDao(super.db);

  /// Get all active users
  Future<List<User>> getAllUsers() {
    return (select(
      users,
    )..where((u) => u.isDeleted.equals(false) & u.isActive.equals(true))).get();
  }

  /// Watch all active users
  Stream<List<User>> watchAllUsers() {
    return (select(users)
          ..where((u) => u.isDeleted.equals(false) & u.isActive.equals(true)))
        .watch();
  }

  /// Get user by ID
  Future<User?> getUserById(int id) {
    return (select(users)..where((u) => u.id.equals(id))).getSingleOrNull();
  }

  /// Get user by username
  Future<User?> getUserByUsername(String username) {
    return (select(
      users,
    )..where((u) => u.username.equals(username))).getSingleOrNull();
  }

  /// Get users by role
  Future<List<User>> getUsersByRole(String role) {
    return (select(users)..where(
          (u) =>
              u.isDeleted.equals(false) &
              u.isActive.equals(true) &
              u.role.equals(role),
        ))
        .get();
  }

  /// Get admin users
  Future<List<User>> getAdminUsers() => getUsersByRole('admin');

  /// Get artist users
  Future<List<User>> getArtistUsers() => getUsersByRole('artist');

  /// Insert a new user
  Future<int> insertUser(UsersCompanion user) {
    return into(users).insert(user);
  }

  /// Update an existing user
  Future<bool> updateUser(User user) {
    return update(users).replace(user);
  }

  /// Update password hash
  Future<int> updatePassword(int id, String passwordHash) {
    return (update(users)..where((u) => u.id.equals(id))).write(
      UsersCompanion(
        passwordHash: Value(passwordHash),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Update last login timestamp
  Future<int> updateLastLogin(int id) {
    return (update(users)..where((u) => u.id.equals(id))).write(
      UsersCompanion(
        lastLoginAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Deactivate a user
  Future<int> deactivateUser(int id) {
    return (update(users)..where((u) => u.id.equals(id))).write(
      UsersCompanion(
        isActive: const Value(false),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Soft delete a user
  Future<int> softDeleteUser(int id) {
    return (update(users)..where((u) => u.id.equals(id))).write(
      UsersCompanion(
        isDeleted: const Value(true),
        deletedAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Hard delete a user
  Future<int> deleteUser(int id) {
    return (delete(users)..where((u) => u.id.equals(id))).go();
  }
}
