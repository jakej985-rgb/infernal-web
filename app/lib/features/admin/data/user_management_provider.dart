import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    final appName = 'SecondaryApp_${DateTime.now().millisecondsSinceEpoch}';
    final currentApp = Firebase.app();

    final secondaryApp = await Firebase.initializeApp(
      name: appName,
      options: currentApp.options,
    );

    try {
      final secondaryAuth = FirebaseAuth.instanceFor(app: secondaryApp);
      
      final resolvedEmail = username.contains('@')
          ? username
          : '$username@inkandsteel.xyz';

      // 1. Create account in Firebase Auth
      final credential = await secondaryAuth.createUserWithEmailAndPassword(
        email: resolvedEmail,
        password: password,
      );

      final newUid = credential.user?.uid;
      if (newUid == null) {
        throw Exception('Failed to retrieve UID for created user');
      }

      // 2. Delegate profile and global user mapping creation to UserService
      await _userService.createUserWithUid(
        uid: newUid,
        email: resolvedEmail,
        displayName: displayName,
        role: role,
        hourlyRate: hourlyRate ?? 150.0,
      );
    } finally {
      // 3. Clean up the secondary Firebase App instance locally
      await secondaryApp.delete();
    }
  }

  Future<void> updateUser(domain.User user, {String? newPassword}) async {
    await _userService.updateUser(user);

    if (newPassword != null && newPassword.isNotEmpty) {
      final resolvedEmail = user.username.contains('@')
          ? user.username
          : '${user.username}@inkandsteel.xyz';
      
      // Since client-side SDK cannot modify other users' passwords directly,
      // trigger a secure password reset email.
      await FirebaseAuth.instance.sendPasswordResetEmail(email: resolvedEmail);
    }
  }

  Future<void> deleteUser(int id) async {
    await _userService.deleteUser(id);
  }
}
