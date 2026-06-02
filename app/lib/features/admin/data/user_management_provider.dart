import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../shared/domain/user.dart' as domain;
import '../../../../shared/domain/enums.dart';

part 'user_management_provider.g.dart';

final _usersList = <domain.User>[
  domain.User(
    id: 1,
    username: 'admin@inkandsteel.xyz',
    displayName: 'Admin User',
    passwordHash: '',
    role: UserRole.admin,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
];
final _usersStreamController = StreamController<List<domain.User>>.broadcast();

final allUsersProvider = StreamProvider<List<domain.User>>((ref) {
  if (!_usersStreamController.isClosed) {
    _usersStreamController.add(_usersList);
  }
  return _usersStreamController.stream;
});

@riverpod
UserManagementService userManagementService(Ref ref) {
  return UserManagementService();
}

class UserManagementService {
  UserManagementService();

  Future<void> createUser({
    required String username,
    required String password,
    required String displayName,
    required String role,
    double? hourlyRate,
  }) async {
    final newUser = domain.User(
      id: _usersList.length + 1,
      username: username,
      displayName: displayName,
      role: UserRole.values.firstWhere((e) => e.name.toLowerCase() == role.toLowerCase(), orElse: () => UserRole.artist),
      hourlyRate: hourlyRate ?? 150.0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    _usersList.add(newUser);
    _usersStreamController.add(_usersList);
  }

  Future<void> updateUser(domain.User user, {String? newPassword}) async {
    final idx = _usersList.indexWhere((u) => u.id == user.id);
    if (idx != -1) {
      _usersList[idx] = user.copyWith(updatedAt: DateTime.now());
      _usersStreamController.add(_usersList);
    }
  }

  Future<void> deleteUser(int id) async {
    _usersList.removeWhere((u) => u.id == id);
    _usersStreamController.add(_usersList);
  }
}
