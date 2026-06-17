import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
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
    required String email,
    required String username,
    required String password,
    required String displayName,
    required String role,
    double? hourlyRate,
  }) async {
    // Instantiate a separate SupabaseClient to sign up the new user without affecting current admin session
    final secondaryClient = SupabaseClient(
      'https://nmrnbwnyivxktbjukspu.supabase.co',
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5tcm5id255aXZ4a3RianVrc3B1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODE0OTkyOTgsImV4cCI6MjA5NzA3NTI5OH0.v1rtUEOKUMs38TgXBEg03WQeWLE9DjDVyNgpLlLm2fU',
    );

    try {
      final response = await secondaryClient.auth.signUp(
        email: email,
        password: password,
      );

      final newUid = response.user?.id;
      if (newUid == null) {
        throw Exception('Failed to retrieve UID for created user');
      }

      await _userService.createUserWithUid(
        uid: newUid,
        email: email,
        username: username,
        displayName: displayName,
        role: role,
        hourlyRate: hourlyRate ?? 150.0,
      );
    } finally {
      // SupabaseClient doesn't require explicit disposal on standard HTTP clients
    }
  }

  Future<void> updateUser(domain.User user, {String? newPassword}) async {
    await _userService.updateUser(user);

    if (newPassword != null && newPassword.isNotEmpty) {
      final resolvedEmail = user.email.isNotEmpty ? user.email : user.username;
      
      // Trigger a password reset email via Supabase Auth
      await Supabase.instance.client.auth.resetPasswordForEmail(resolvedEmail);
    }
  }

  Future<void> deleteUser(int id) async {
    await _userService.deleteUser(id);
  }
}
