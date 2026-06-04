import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../shared/core/services/user_service.dart';
import '../../../shared/domain/user.dart' as domain;

part 'user_management_provider.g.dart';

@riverpod
Stream<List<domain.User>> allUsers(Ref ref) {
  final userService = ref.watch(userServiceProvider);
  return userService.watchUsers();
}

@riverpod
UserManagementService userManagementService(Ref ref) {
  return UserManagementService(ref);
}

class UserManagementService {
  final Ref _ref;
  UserManagementService(this._ref);

  UserService get _userService => _ref.read(userServiceProvider);

  Future<void> createUser({
    required String username,
    required String password,
    required String displayName,
    required String role,
    double? hourlyRate,
  }) async {
    // Note: Password hashing/creation is handled on backend/auth system, here we seed the Firestore profile document
    await _userService.createUser(
      username: username,
      displayName: displayName,
      role: role,
      hourlyRate: hourlyRate,
    );
  }

  Future<void> updateUser(domain.User user, {String? newPassword}) async {
    await _userService.updateUser(user);
  }

  Future<void> deleteUser(int id) async {
    await _userService.deleteUser(id);
  }
}
