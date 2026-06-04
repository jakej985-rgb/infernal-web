import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../cache/id_mapper.dart';
import '../../data/org_provider.dart';
import '../../domain/user.dart' as domain;
import '../../domain/enums.dart';
import 'firestore_helpers.dart';

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

  CollectionReference<Map<String, dynamic>> get _usersRef =>
      orgDoc(_orgId).collection('users');

  Stream<List<domain.User>> watchUsers() {
    return _usersRef
        .where('isDeleted', isEqualTo: false)
        .snapshots()
        .asyncMap((snapshot) async {
          final list = <domain.User>[];
          for (final doc in snapshot.docs) {
            list.add(await _mapDocToUser(doc, _idMapper));
          }
          return list;
        });
  }

  Future<domain.User?> getUserById(String uid) async {
    final doc = await _usersRef.doc(uid).get();
    if (!doc.exists) return null;
    return _mapDocToUserSync(doc);
  }

  Future<void> createUser({
    required String username,
    required String displayName,
    required String role,
    double? hourlyRate,
  }) async {
    final docRef = _usersRef.doc();
    final uuid = docRef.id;

    await docRef.set({
      'email': username,
      'displayName': displayName,
      'role': role.toLowerCase(),
      'hourlyRate': hourlyRate ?? 150.0,
      'isDeleted': false,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    await _idMapper.registerUuid('user', uuid);
  }

  Future<void> createUserWithUid({
    required String uid,
    required String email,
    required String displayName,
    required String role,
    required double hourlyRate,
  }) async {
    await _usersRef.doc(uid).set({
      'email': email,
      'displayName': displayName,
      'role': role.toLowerCase(),
      'hourlyRate': hourlyRate,
      'isDeleted': false,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateUser(domain.User user) async {
    final uuid = _idMapper.getUuid('user', user.id);
    if (uuid == null) throw Exception('Cannot resolve ID for user.');

    await _usersRef.doc(uuid).update({
      'displayName': user.displayName,
      'role': user.role.name.toLowerCase(),
      'hourlyRate': user.hourlyRate,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteUser(int id) async {
    final uuid = _idMapper.getUuid('user', id);
    if (uuid == null) throw Exception('Cannot resolve ID for user.');

    await _usersRef.doc(uuid).update({
      'isDeleted': true,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<domain.User> _mapDocToUser(
    DocumentSnapshot<Map<String, dynamic>> doc,
    IdMapper idMapper,
  ) async {
    final uuid = doc.id;
    final id = await idMapper.registerUuid('user', uuid);

    final data = doc.data() ?? {};
    final email = data['email'] as String? ?? '';
    final displayName = data['displayName'] as String? ?? '';
    final roleStr = data['role'] as String? ?? 'artist';
    final hourlyRate = (data['hourlyRate'] as num?)?.toDouble() ?? 150.0;
    final isDeleted = data['isDeleted'] as bool? ?? false;

    final createdAtTimestamp = data['createdAt'] as Timestamp?;
    final updatedAtTimestamp = data['updatedAt'] as Timestamp?;

    final createdAt = createdAtTimestamp?.toDate() ?? DateTime.now();
    final updatedAt = updatedAtTimestamp?.toDate() ?? DateTime.now();

    return domain.User(
      id: id,
      username: email,
      displayName: displayName,
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

  domain.User _mapDocToUserSync(DocumentSnapshot<Map<String, dynamic>> doc) {
    final uuid = doc.id;
    final id = uuid.hashCode & 0x7FFFFFFF;

    final data = doc.data() ?? {};
    final email = data['email'] as String? ?? '';
    final displayName = data['displayName'] as String? ?? '';
    final roleStr = data['role'] as String? ?? 'artist';
    final hourlyRate = (data['hourlyRate'] as num?)?.toDouble() ?? 150.0;
    final isDeleted = data['isDeleted'] as bool? ?? false;

    final createdAtTimestamp = data['createdAt'] as Timestamp?;
    final updatedAtTimestamp = data['updatedAt'] as Timestamp?;

    final createdAt = createdAtTimestamp?.toDate() ?? DateTime.now();
    final updatedAt = updatedAtTimestamp?.toDate() ?? DateTime.now();

    return domain.User(
      id: id,
      username: email,
      displayName: displayName,
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
