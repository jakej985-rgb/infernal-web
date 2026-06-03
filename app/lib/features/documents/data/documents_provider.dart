import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as fb_storage;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared/cache/id_mapper.dart';
import '../../../shared/data/org_provider.dart';
import '../../../../shared/domain/document.dart' as domain;

part 'documents_provider.g.dart';

@riverpod
class DocumentSearchQuery extends _$DocumentSearchQuery {
  @override
  String build() => '';
  void set(String query) => state = query;
}

CollectionReference<Map<String, dynamic>> _documentsRef(String orgId) => FirebaseFirestore
    .instance
    .collection('organizations')
    .doc(orgId)
    .collection('documents');

@riverpod
Stream<List<domain.Document>> filteredDocuments(Ref ref) {
  final query = ref.watch(documentSearchQueryProvider);
  final idMapper = ref.watch(idMapperProvider);
  final orgIdVal = ref.watch(orgIdProvider);

  return _documentsRef(orgIdVal)
      .where('isDeleted', isEqualTo: false)
      .snapshots()
      .asyncMap((snapshot) async {
        final list = <domain.Document>[];
        for (final doc in snapshot.docs) {
          list.add(await _mapDocToDomain(doc, idMapper));
        }
        return list;
      })
      .map((docs) {
        if (query.isEmpty) return docs;
        final lowerQ = query.toLowerCase();
        return docs.where((doc) {
          return doc.title.toLowerCase().contains(lowerQ) ||
              doc.filePath.toLowerCase().contains(lowerQ);
        }).toList();
      });
}

@riverpod
Stream<domain.Document?> documentDetail(Ref ref, int id) {
  final idMapper = ref.watch(idMapperProvider);
  final orgIdVal = ref.watch(orgIdProvider);
  final uuid = idMapper.getUuid('document', id);
  if (uuid == null) {
    return Stream.value(null);
  }

  return _documentsRef(orgIdVal).doc(uuid).snapshots().asyncMap((doc) async {
    if (!doc.exists) return null;
    return await _mapDocToDomain(doc, idMapper);
  });
}

@riverpod
DocumentsService documentsService(Ref ref) {
  return DocumentsService(ref);
}

class DocumentsService {
  final Ref _ref;
  DocumentsService(this._ref);

  IdMapper get _idMapper => _ref.read(idMapperProvider);
  String get _orgId => _ref.read(orgIdProvider);

  Future<void> createDocument(domain.Document doc) async {
    final clientUuid = _idMapper.getUuid('client', doc.clientId);
    if (clientUuid == null) {
      throw Exception('Could not resolve client UUID.');
    }

    final docRef = _documentsRef(_orgId).doc();
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

    await _documentsRef(_orgId).doc(uuid).update({
      'client_id': clientUuid,
      'title': doc.title,
      'filePath': doc.filePath,
    });
  }

  Future<void> deleteDocument(int id) async {
    final uuid = _idMapper.getUuid('document', id);
    if (uuid == null) throw Exception('Could not resolve document UUID.');

    await _documentsRef(_orgId).doc(uuid).update({'isDeleted': true});
  }
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
