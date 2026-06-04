import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as fb_storage;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../cache/id_mapper.dart';
import '../../data/org_provider.dart';
import '../../domain/document.dart' as domain;
import 'firestore_helpers.dart';

part 'document_service.g.dart';

@riverpod
DocumentService documentService(Ref ref) {
  return DocumentService(ref);
}

class DocumentService {
  final Ref _ref;
  DocumentService(this._ref);

  IdMapper get _idMapper => _ref.read(idMapperProvider);
  String get _orgId => _ref.read(orgIdProvider);

  CollectionReference<Map<String, dynamic>> get _documentsRef =>
      orgDoc(_orgId).collection('documents');

  Stream<List<domain.Document>> watchDocuments() {
    return _documentsRef
        .where('isDeleted', isEqualTo: false)
        .snapshots()
        .asyncMap((snapshot) async {
          final list = <domain.Document>[];
          for (final doc in snapshot.docs) {
            list.add(await _mapDocToDomain(doc, _idMapper));
          }
          return list;
        });
  }

  Stream<domain.Document?> watchDocumentById(int id) {
    final uuid = _idMapper.getUuid('document', id);
    if (uuid == null) {
      return Stream.value(null);
    }

    return _documentsRef.doc(uuid).snapshots().asyncMap((doc) async {
      if (!doc.exists || doc.data()?['isDeleted'] == true) return null;
      return await _mapDocToDomain(doc, _idMapper);
    });
  }

  Future<void> createDocument(domain.Document doc) async {
    final clientUuid = _idMapper.getUuid('client', doc.clientId);
    if (clientUuid == null) {
      throw Exception('Could not resolve client UUID.');
    }

    final docRef = _documentsRef.doc();
    final uuid = docRef.id;

    // 1. Upload file bytes to Firebase Storage
    final storageRef = fb_storage.FirebaseStorage.instance
        .ref()
        .child('organizations')
        .child(_orgId)
        .child('clients')
        .child(clientUuid)
        .child('documents')
        .child('${uuid}_${doc.title}');

    final uploadTask = storageRef.putData(
      Uint8List.fromList('dummy file contents'.codeUnits),
    );
    final snapshot = await uploadTask;
    final downloadUrl = await snapshot.ref.getDownloadURL();

    // 2. Save metadata to Firestore
    await docRef.set({
      'client_id': clientUuid,
      'title': doc.title,
      'filePath': downloadUrl,
      'uploadedByUserId': 'default-admin-uuid',
      'isDeleted': false,
      'createdAt': FieldValue.serverTimestamp(),
    });

    await _idMapper.registerUuid('document', uuid);
  }

  Future<void> updateDocument(domain.Document doc) async {
    final uuid = _idMapper.getUuid('document', doc.id);
    if (uuid == null) throw Exception('Could not resolve document UUID.');

    final clientUuid = _idMapper.getUuid('client', doc.clientId);
    if (clientUuid == null) throw Exception('Could not resolve client UUID.');

    await _documentsRef.doc(uuid).update({
      'client_id': clientUuid,
      'title': doc.title,
      'filePath': doc.filePath,
    });
  }

  Future<void> deleteDocument(int id) async {
    final uuid = _idMapper.getUuid('document', id);
    if (uuid == null) throw Exception('Could not resolve document UUID.');

    await _documentsRef.doc(uuid).update({'isDeleted': true});
  }

  Future<domain.Document> _mapDocToDomain(
    DocumentSnapshot<Map<String, dynamic>> doc,
    IdMapper idMapper,
  ) async {
    final uuid = doc.id;
    final id = await idMapper.registerUuid('document', uuid);

    final data = doc.data() ?? {};
    final clientUuid = data['client_id'] as String? ?? '';
    int clientId = 0;
    if (clientUuid.isNotEmpty) {
      clientId = await idMapper.registerUuid('client', clientUuid);
    }

    final title = data['title'] as String? ?? '';
    final filePath = data['filePath'] as String? ?? '';

    final createdAtTimestamp = data['createdAt'] as Timestamp?;
    final createdAt = createdAtTimestamp?.toDate() ?? DateTime.now();

    return domain.Document(
      id: id,
      syncId: uuid,
      uploadedByUserId: 1, // Default local user ID
      clientId: clientId,
      title: title,
      filePath: filePath,
      createdAt: createdAt,
      lastModifiedUtc: createdAt.toUtc(),
      lastModifiedBy: 'App',
    );
  }
}
