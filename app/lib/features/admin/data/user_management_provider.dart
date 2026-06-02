import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../shared/cache/id_mapper.dart';
import '../../../../shared/domain/user.dart' as domain;
import '../../../../shared/domain/enums.dart';

part 'user_management_provider.g.dart';

@riverpod
Stream<List<domain.User>> allUsers(Ref ref) {
  final idMapper = ref.watch(idMapperProvider);
  return FirebaseFirestore.instance
      .collection('organizations')
      .doc('default-org')
      .collection('users')
      .where('isDeleted', isEqualTo: false)
      .snapshots()
      .asyncMap((snapshot) async {
    final list = <domain.User>[];
    for (final doc in snapshot.docs) {
      list.add(await _mapDocToUser(doc, idMapper));
    }
    return list;
  });
}

@riverpod
UserManagementService userManagementService(Ref ref) {
  return UserManagementService(ref);
}

class UserManagementService {
  final Ref _ref;
  UserManagementService(this._ref);

  IdMapper get _idMapper => _ref.read(idMapperProvider);

  CollectionReference<Map<String, dynamic>> get _usersRef =>
      FirebaseFirestore.instance.collection('organizations').doc('default-org').collection('users');

  Future<void> createUser({
    required String username,
    required String password,
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

  Future<void> updateUser(domain.User user, {String? newPassword}) async {
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
}

Future<domain.User> _mapDocToUser(DocumentSnapshot<Map<String, dynamic>> doc, IdMapper idMapper) async {
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
