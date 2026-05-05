import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../shared/domain/user.dart';
import '../../../shared/domain/enums.dart';
import '../../../shared/persistence/database.dart' as drift_db;
import '../../../shared/persistence/daos/users_dao.dart';

part 'user_repository.g.dart';

@Riverpod(keepAlive: true)
UserRepository userRepository(Ref ref) {
  final db = ref.watch(drift_db.databaseProvider);
  return UserRepository(db.usersDao);
}

class UserRepository {
  final UsersDao _usersDao;

  UserRepository(this._usersDao);

  Future<User?> getUserByUsername(String username) async {
    final user = await _usersDao.getUserByUsername(username);
    return user != null ? _mapToDomain(user) : null;
  }

  Future<User?> getUserById(int id) async {
    final user = await _usersDao.getUserById(id);
    return user != null ? _mapToDomain(user) : null;
  }

  Future<void> createUser(drift_db.UsersCompanion user) async {
    await _usersDao.insertUser(user);
  }

  User _mapToDomain(drift_db.User u) {
    return User(
      id: u.id,
      username: u.username,
      displayName: u.displayName,
      passwordHash: u.passwordHash,
      role: UserRole.values.firstWhere(
        (e) => e.name == u.role,
        orElse: () => UserRole.artist,
      ),
      themeKey: u.themeKey,
      avatarPath: u.avatarPath,
      hourlyRate: u.hourlyRate,
      speedFactor: u.speedFactor,
      createdAt: u.createdAt,
      updatedAt: u.updatedAt,
      lastLoginAt: u.lastLoginAt,
      isActive: u.isActive,
      isDeleted: u.isDeleted,
      deletedAt: u.deletedAt,
      department: u.department,
      commissionRate: u.commissionRate,
      fontSize: u.fontSize,
      keyboardShortcutsJson: u.keyboardShortcutsJson,
      permissionsJson: u.permissionsJson,
    );
  }
}
