import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart' as uuid;
import '../../cache/id_mapper.dart';
import '../../data/org_provider.dart';
import '../../domain/user.dart' as domain;
import '../../domain/enums.dart';

part 'user_service.g.dart';

@riverpod
UserService userService(Ref ref) {
  return UserService(ref);
}

class UserService {
  final Ref _ref;
  UserService(this._ref);

  IdMapper get _idMapper => _ref.read(idMapperProvider);
  String get _orgId => _ref.read(orgIdProvider);

  Stream<List<domain.User>> watchUsers() {
    final client = sb.Supabase.instance.client;
    return client
        .from('users')
        .stream(primaryKey: ['id'])
        .eq('org_id', _orgId)
        .asyncMap((data) async {
          final list = <domain.User>[];
          for (final row in data) {
            if (row['is_deleted'] == true) continue;
            list.add(await _mapRowToUser(row, _idMapper));
          }
          return list;
        });
  }

  Future<domain.User?> getUserById(String uid, [String? orgId]) async {
    final client = sb.Supabase.instance.client;
    final row = await client.from('users').select().eq('id', uid).maybeSingle();
    if (row == null) return null;
    return _mapRowToUserSync(row);
  }

  Future<void> createUser({
    required String email,
    required String username,
    required String displayName,
    required String role,
    double? hourlyRate,
  }) async {
    final client = sb.Supabase.instance.client;
    final uuidVal = const uuid.Uuid().v4();

    await client.from('users').insert({
      'id': uuidVal,
      'org_id': _orgId,
      'email': email,
      'username': username,
      'display_name': displayName,
      'role': role.toLowerCase(),
      'hourly_rate': hourlyRate ?? 150.0,
      'is_deleted': false,
      'created_at': DateTime.now().toUtc().toIso8601String(),
      'updated_at': DateTime.now().toUtc().toIso8601String(),
    });

    await _idMapper.registerUuid('user', uuidVal);
  }

  Future<void> createUserWithUid({
    required String uid,
    required String email,
    required String displayName,
    required String role,
    required double hourlyRate,
    String? orgId,
    String? username,
  }) async {
    final client = sb.Supabase.instance.client;
    final targetOrgId = orgId ?? _orgId;
    final resolvedUsername = username ?? (email.isNotEmpty ? email.split('@').first : '');
    
    await client.from('users').insert({
      'id': uid,
      'org_id': targetOrgId,
      'email': email,
      'username': resolvedUsername,
      'display_name': displayName,
      'role': role.toLowerCase(),
      'hourly_rate': hourlyRate,
      'is_deleted': false,
      'created_at': DateTime.now().toUtc().toIso8601String(),
      'updated_at': DateTime.now().toUtc().toIso8601String(),
    });
  }

  Future<void> updateUser(domain.User user) async {
    final uuidVal = _idMapper.getUuid('user', user.id);
    if (uuidVal == null) throw Exception('Cannot resolve ID for user.');

    final client = sb.Supabase.instance.client;
    await client.from('users').update({
      'display_name': user.displayName,
      'role': user.role.name.toLowerCase(),
      'hourly_rate': user.hourlyRate,
      'updated_at': DateTime.now().toUtc().toIso8601String(),
    }).eq('id', uuidVal);
  }

  Future<void> deleteUser(int id) async {
    final uuidVal = _idMapper.getUuid('user', id);
    if (uuidVal == null) throw Exception('Cannot resolve ID for user.');

    final client = sb.Supabase.instance.client;
    await client.from('users').update({
      'is_deleted': true,
      'updated_at': DateTime.now().toUtc().toIso8601String(),
    }).eq('id', uuidVal);
  }

  Future<domain.User> _mapRowToUser(
    Map<String, dynamic> row,
    IdMapper idMapper,
  ) async {
    final uuidVal = row['id'] as String;
    final id = await idMapper.registerUuid('user', uuidVal);

    final email = row['email'] as String? ?? '';
    final username = row['username'] as String? ?? '';
    final displayName = row['display_name'] as String? ?? '';
    final roleStr = row['role'] as String? ?? 'artist';
    final hourlyRate = (row['hourly_rate'] as num?)?.toDouble() ?? 150.0;
    final isDeleted = row['is_deleted'] as bool? ?? false;

    final createdAt = DateTime.parse(row['created_at'] as String).toLocal();
    final updatedAt = DateTime.parse(row['updated_at'] as String).toLocal();
    final resolvedOrgId = row['org_id'] as String? ?? 'default-org';

    return domain.User(
      id: id,
      username: username,
      email: email,
      displayName: displayName,
      orgId: resolvedOrgId,
      role: UserRole.values.firstWhere(
        (e) => e.name.toLowerCase() == roleStr.toLowerCase(),
        orElse: () => UserRole.artist,
      ),
      hourlyRate: hourlyRate,
      isDeleted: isDeleted,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  domain.User _mapRowToUserSync(Map<String, dynamic> row) {
    final uuidVal = row['id'] as String;
    final id = uuidVal.hashCode & 0x7FFFFFFF;

    final email = row['email'] as String? ?? '';
    final username = row['username'] as String? ?? '';
    final displayName = row['display_name'] as String? ?? '';
    final roleStr = row['role'] as String? ?? 'artist';
    final hourlyRate = (row['hourly_rate'] as num?)?.toDouble() ?? 150.0;
    final isDeleted = row['is_deleted'] as bool? ?? false;

    final createdAt = DateTime.parse(row['created_at'] as String).toLocal();
    final updatedAt = DateTime.parse(row['updated_at'] as String).toLocal();
    final resolvedOrgId = row['org_id'] as String? ?? 'default-org';

    return domain.User(
      id: id,
      username: username,
      email: email,
      displayName: displayName,
      orgId: resolvedOrgId,
      role: UserRole.values.firstWhere(
        (e) => e.name.toLowerCase() == roleStr.toLowerCase(),
        orElse: () => UserRole.artist,
      ),
      hourlyRate: hourlyRate,
      isDeleted: isDeleted,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
