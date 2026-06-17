import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart' as uuid;
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
    final client = sb.Supabase.instance.client;

    // Listen to Supabase auth state changes
    final subscription = client.auth.onAuthStateChange.listen((data) async {
      final sbUser = data.session?.user;
      if (sbUser == null) {
        if (!completer.isCompleted) {
          completer.complete(const AuthState.unauthenticated());
        } else {
          state = const AsyncValue.data(AuthState.unauthenticated());
        }
      } else {
        try {
          // 1. Read user profile from UserService using the Supabase user ID
          final userProfile = await userService.getUserById(sbUser.id);

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
            await client.auth.signOut();
            if (!completer.isCompleted) {
              completer.complete(const AuthState.unauthenticated());
            } else {
              state = const AsyncValue.data(AuthState.unauthenticated());
            }
            return;
          }

          // Register UID in mapper
          ref.read(idMapperProvider).registerUuid('user', sbUser.id);

          final user = User(
            id: userProfile.id,
            username: userProfile.username,
            email: userProfile.email,
            displayName: userProfile.displayName,
            orgId: userProfile.orgId,
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

  /// Explicitly initialize user profile document in Supabase after sign-up/login if missing.
  Future<void> initializeUserProfile(String uid, String email, [String? orgId]) async {
    final resolvedOrgId = orgId ?? 'default-org';
    final userService = ref.read(userServiceProvider);
    var existing = await userService.getUserById(uid);
    if (existing == null) {
      final isAdmin = email == 'admin.ink.steel@gmail.com' || email == 'admin@inkandsteel.xyz';
      await userService.createUserWithUid(
        uid: uid,
        email: email,
        displayName: email.split('@').first,
        role: isAdmin ? 'admin' : 'artist',
        hourlyRate: 150.0,
        orgId: resolvedOrgId,
      );
      existing = await userService.getUserById(uid);
    }

    if (existing != null && !existing.isDeleted) {
      ref.read(idMapperProvider).registerUuid('user', uid);
      final user = User(
        id: existing.id,
        username: existing.username,
        email: existing.email,
        displayName: existing.displayName,
        orgId: resolvedOrgId,
        passwordHash: '',
        role: existing.role,
        hourlyRate: existing.hourlyRate,
        createdAt: existing.createdAt,
        updatedAt: existing.updatedAt,
      );
      state = AsyncValue.data(AuthState.authenticated(user));
    }
  }

  Future<void> login(String username, String password) async {
    state = const AsyncValue.data(AuthState.loading());

    try {
      String resolvedEmail = username;
      final client = sb.Supabase.instance.client;
      if (!username.contains('@')) {
        // Query users table to find user by username
        final userQuery = await client
            .from('users')
            .select('email')
            .eq('username', username)
            .maybeSingle();
        if (userQuery == null) {
          throw Exception('No user found with username: $username');
        }
        resolvedEmail = userQuery['email'] as String? ?? '';
        if (resolvedEmail.isEmpty) {
          throw Exception('No email address associated with username: $username');
        }
      }

      final response = await client.auth.signInWithPassword(
        email: resolvedEmail,
        password: password,
      );

      final sbUser = response.user;
      if (sbUser != null) {
        // Resolve profile profile from users table
        final userMap = await client
            .from('users')
            .select('org_id')
            .eq('id', sbUser.id)
            .maybeSingle();
        final resolvedOrgId = userMap != null ? (userMap['org_id'] as String? ?? 'default-org') : 'default-org';

        // Explicitly initialize profile to ensure it exists
        await initializeUserProfile(sbUser.id, sbUser.email ?? resolvedEmail, resolvedOrgId);
      }
    } catch (e) {
      state = AsyncValue.data(AuthState.error(e.toString()));
    }
  }

  Future<void> logout() async {
    state = const AsyncValue.data(AuthState.loading());
    try {
      await sb.Supabase.instance.client.auth.signOut();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> seedAdmin() async {
    try {
      final client = sb.Supabase.instance.client;
      try {
        await client.auth.signInWithPassword(
          email: 'admin.ink.steel@gmail.com',
          password: 'adminadmin',
        );
      } catch (_) {
        // Sign in failed, try to sign up
        final response = await client.auth.signUp(
          email: 'admin.ink.steel@gmail.com',
          password: 'adminadmin',
        );
        final sbUser = response.user;
        if (sbUser != null) {
          final userService = ref.read(userServiceProvider);
          await userService.createUserWithUid(
            uid: sbUser.id,
            email: 'admin.ink.steel@gmail.com',
            displayName: 'admin',
            role: 'admin',
            hourlyRate: 150.0,
            orgId: 'default-org',
          );
        }
      }
    } catch (e) {
      debugPrint('seedAdmin failed: $e');
    }
  }

  Future<void> submitShopRequest({
    required String email,
    required String shopName,
    required String shopId,
    required String displayName,
  }) async {
    state = const AsyncValue.data(AuthState.loading());
    try {
      final client = sb.Supabase.instance.client;
      final newId = const uuid.Uuid().v4();
      await client.from('requests').insert({
        'id': newId,
        'email': email,
        'shop_name': shopName,
        'shop_id': shopId,
        'display_name': displayName,
        'status': 'pending',
        'requested_at': DateTime.now().toUtc().toIso8601String(),
      });
      state = const AsyncValue.data(AuthState.unauthenticated());
    } catch (e) {
      state = AsyncValue.data(AuthState.error(e.toString()));
      rethrow;
    }
  }

  Future<void> approveShopRequest(String requestId, String inviteToken) async {
    try {
      final client = sb.Supabase.instance.client;
      await client.from('requests').update({
        'status': 'approved',
        'invite_token': inviteToken,
        'approved_at': DateTime.now().toUtc().toIso8601String(),
      }).eq('id', requestId);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> rejectShopRequest(String requestId) async {
    try {
      final client = sb.Supabase.instance.client;
      await client.from('requests').update({
        'status': 'rejected',
        'rejected_at': DateTime.now().toUtc().toIso8601String(),
      }).eq('id', requestId);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> claimShopRequest({
    required String requestId,
    required String inviteToken,
    required String password,
  }) async {
    state = const AsyncValue.data(AuthState.loading());
    try {
      final client = sb.Supabase.instance.client;
      // 1. Fetch and validate the request
      final data = await client.from('requests').select().eq('id', requestId).maybeSingle();
      if (data == null) {
        throw Exception('Sanctum request not found.');
      }
      if (data['status'] != 'approved') {
        throw Exception('This request has not been approved yet.');
      }
      if (data['invite_token'] != inviteToken) {
        throw Exception('Invalid invitation token.');
      }

      final email = data['email'] as String;
      final orgId = data['shop_id'] as String;
      final orgName = data['shop_name'] as String;
      final displayName = data['display_name'] as String;

      // 2. Create account in Supabase Auth
      final response = await client.auth.signUp(
        email: email,
        password: password,
      );

      final sbUser = response.user;
      if (sbUser == null) {
        throw Exception('User registration failed - Auth credential not created.');
      }

      // 3. Create the organization row
      await client.from('organizations').insert({
        'id': orgId,
        'name': orgName,
      });

      // 4. Create default settings
      await client.from('settings').insert({
        'org_id': orgId,
        'shop_name': orgName,
        'logo_path': '',
        'accent_color': '#FF0000',
        'deposit_type': 'percentage',
        'deposit_amount': 20.0,
        'tattoo_per_hour': 150.0,
        'piercing_single': 50.0,
        'piercing_multi': 80.0,
        'shop_minimum_rate': 80.0,
        'tax_rate': 0.08,
      });

      // 5. Create the profile
      final userService = ref.read(userServiceProvider);
      await userService.createUserWithUid(
        uid: sbUser.id,
        email: email,
        displayName: displayName,
        role: 'owner',
        hourlyRate: 150.0,
        orgId: orgId,
      );

      // 6. Mark request as claimed in Supabase
      await client.from('requests').update({
        'status': 'claimed',
        'claimed_at': DateTime.now().toUtc().toIso8601String(),
      }).eq('id', requestId);

      // 7. Initialize profile mapping to bind user session state
      await initializeUserProfile(sbUser.id, email, orgId);

    } catch (e) {
      state = AsyncValue.data(AuthState.error(e.toString()));
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> getShopRequest(String requestId) async {
    final client = sb.Supabase.instance.client;
    final data = await client.from('requests').select().eq('id', requestId).maybeSingle();
    if (data == null) return null;
    return {
      'status': data['status'],
      'inviteToken': data['invite_token'],
      'email': data['email'],
      'shopName': data['shop_name'],
      'shopId': data['shop_id'],
      'displayName': data['display_name'],
    };
  }

  Stream<List<Map<String, dynamic>>> watchRequests() {
    final client = sb.Supabase.instance.client;
    return client
        .from('requests')
        .stream(primaryKey: ['id'])
        .order('requested_at', ascending: false)
        .map((list) => list.map((data) => {
              'id': data['id'],
              'status': data['status'],
              'inviteToken': data['invite_token'],
              'email': data['email'],
              'shopName': data['shop_name'],
              'shopId': data['shop_id'],
              'displayName': data['display_name'],
            }).toList());
  }
}
