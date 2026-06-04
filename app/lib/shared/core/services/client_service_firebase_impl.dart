import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../cache/id_mapper.dart';
import '../../domain/client.dart' as domain;
import '../../data/interfaces/client_service.dart';
import '../../data/org_provider.dart';
import 'firestore_helpers.dart';

class ClientServiceFirebaseImpl implements ClientService {
  final Ref _ref;
  ClientServiceFirebaseImpl(this._ref);

  IdMapper get _idMapper => _ref.read(idMapperProvider);
  String get _orgId => _ref.read(orgIdProvider);

  CollectionReference<Map<String, dynamic>> get _clientsRef =>
      orgDoc(_orgId).collection('clients');

  @override
  Future<List<domain.Client>> getClients() async {
    try {
      final snapshot = await _clientsRef
          .where('isDeleted', isEqualTo: false)
          .get();
      final clients = <domain.Client>[];
      for (final doc in snapshot.docs) {
        clients.add(await _mapDocToDomain(doc));
      }
      return clients;
    } catch (e) {
      throw Exception('Failed to get clients: $e');
    }
  }

  @override
  Future<domain.Client?> getClientById(int id) async {
    try {
      final uuid = _idMapper.getUuid('client', id);
      if (uuid == null) return null;

      final doc = await _clientsRef.doc(uuid).get();
      if (!doc.exists) return null;
      return await _mapDocToDomain(doc);
    } catch (e) {
      throw Exception('Failed to get client: $e');
    }
  }

  @override
  Future<void> createClient(domain.Client client) async {
    try {
      final docRef = _clientsRef.doc();
      final uuid = docRef.id;

      await docRef.set({
        'name': client.fullName,
        'first_name': client.firstName,
        'middle_name': client.middleName,
        'last_name': client.lastName,
        'email': client.email,
        'phone': client.phone,
        'notes': client.notes,
        'photoPath': client.photoPath,
        'isDeleted': false,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      await _idMapper.registerUuid('client', uuid);
    } catch (e) {
      throw Exception('Failed to create client: $e');
    }
  }

  @override
  Future<void> updateClient(domain.Client client) async {
    try {
      final uuid = _idMapper.getUuid('client', client.id);
      if (uuid == null) throw Exception('Cannot resolve ID for client.');

      await _clientsRef.doc(uuid).update({
        'name': client.fullName,
        'first_name': client.firstName,
        'middle_name': client.middleName,
        'last_name': client.lastName,
        'email': client.email,
        'phone': client.phone,
        'notes': client.notes,
        'photoPath': client.photoPath,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to update client: $e');
    }
  }

  @override
  Future<void> deleteClient(int id) async {
    try {
      final uuid = _idMapper.getUuid('client', id);
      if (uuid == null) throw Exception('Cannot resolve ID for client.');

      await _clientsRef.doc(uuid).update({
        'isDeleted': true,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to delete client: $e');
    }
  }

  @override
  Stream<List<domain.Client>> watchClients() {
    return _clientsRef
        .where('isDeleted', isEqualTo: false)
        .snapshots()
        .asyncMap((snapshot) async {
          final clients = <domain.Client>[];
          for (final doc in snapshot.docs) {
            clients.add(await _mapDocToDomain(doc));
          }
          return clients;
        });
  }

  @override
  Stream<domain.Client?> watchClientById(int id) {
    final uuid = _idMapper.getUuid('client', id);
    if (uuid == null) {
      return Stream.value(null);
    }
    return _clientsRef.doc(uuid).snapshots().asyncMap((doc) async {
      if (!doc.exists || doc.data()?['isDeleted'] == true) return null;
      return await _mapDocToDomain(doc);
    });
  }

  @override
  Future<String> saveAvatar(XFile file) async {
    return file.path;
  }

  Future<domain.Client> _mapDocToDomain(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) async {
    final uuid = doc.id;
    final id = await _idMapper.registerUuid('client', uuid);

    final data = doc.data() ?? {};
    
    String firstName = data['first_name'] as String? ?? '';
    String middleName = data['middle_name'] as String? ?? '';
    String lastName = data['last_name'] as String? ?? '';

    // Fallback parsing if fields are absent
    if (firstName.isEmpty && lastName.isEmpty) {
      final fullName = data['name'] as String? ?? '';
      final parts = fullName.trim().split(' ');
      firstName = parts.isNotEmpty ? parts.first : '';
      if (parts.length > 2) {
        middleName = parts[1];
        lastName = parts.sublist(2).join(' ');
      } else if (parts.length > 1) {
        lastName = parts[1];
      }
    }

    final email = data['email'] as String? ?? '';
    final phone = data['phone'] as String? ?? '';
    final notes = data['notes'] as String? ?? '';
    final photoPath = data['photoPath'] as String? ?? '';

    final updatedAtTimestamp = data['updatedAt'] as Timestamp?;
    final updatedAt = updatedAtTimestamp?.toDate() ?? DateTime.now();
    final createdAtTimestamp = data['createdAt'] as Timestamp?;
    final createdAt = createdAtTimestamp?.toDate() ?? updatedAt;

    return domain.Client(
      id: id,
      syncId: uuid,
      firstName: firstName,
      middleName: middleName,
      lastName: lastName,
      email: email,
      phone: phone,
      notes: notes,
      photoPath: photoPath,
      createdAt: createdAt.toUtc(),
      lastModifiedUtc: updatedAt.toUtc(),
    );
  }
}
