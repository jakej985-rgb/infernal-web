import 'dart:async';
import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart' as uuid;
import '../../cache/id_mapper.dart';
import '../../data/org_provider.dart';
import '../../domain/document.dart' as domain;

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

  Stream<List<domain.Document>> watchDocuments() {
    final client = sb.Supabase.instance.client;
    return client
        .from('documents')
        .stream(primaryKey: ['id'])
        .eq('org_id', _orgId)
        .asyncMap((data) async {
          final list = <domain.Document>[];
          for (final row in data) {
            if (row['is_deleted'] == true) continue;
            list.add(await _mapRowToDomain(row, _idMapper));
          }
          return list;
        });
  }

  Stream<domain.Document?> watchDocumentById(int id) {
    final uuidVal = _idMapper.getUuid('document', id);
    if (uuidVal == null) {
      return Stream.value(null);
    }
    final client = sb.Supabase.instance.client;
    return client
        .from('documents')
        .stream(primaryKey: ['id'])
        .eq('id', uuidVal)
        .asyncMap((data) async {
          if (data.isEmpty || data.first['is_deleted'] == true) return null;
          return await _mapRowToDomain(data.first, _idMapper);
        });
  }

  Future<void> createDocument(
    domain.Document doc, {
    Uint8List? bytes,
    String? fileName,
    String? contentType,
  }) async {
    final clientUuid = _idMapper.getUuid('client', doc.clientId);
    if (clientUuid == null) {
      throw Exception('Could not resolve client UUID.');
    }

    final uuidVal = const uuid.Uuid().v4();
    final supabaseClient = sb.Supabase.instance.client;

    String downloadUrl = doc.filePath;

    if (bytes != null && bytes.isNotEmpty) {
      final safeFileName = fileName ?? '${doc.title}_${DateTime.now().millisecondsSinceEpoch}';
      final storagePath = 'organizations/$_orgId/clients/$clientUuid/documents/${uuidVal}_$safeFileName';

      await supabaseClient.storage.from('documents').uploadBinary(
        storagePath,
        bytes,
        fileOptions: sb.FileOptions(contentType: contentType ?? 'application/octet-stream', upsert: true),
      );
      downloadUrl = supabaseClient.storage.from('documents').getPublicUrl(storagePath);
    }

    await supabaseClient.from('documents').insert({
      'id': uuidVal,
      'org_id': _orgId,
      'client_id': clientUuid,
      'title': doc.title,
      'file_path': downloadUrl,
      'uploaded_by_user_id': 'default-admin-uuid',
      'is_deleted': false,
      'created_at': DateTime.now().toUtc().toIso8601String(),
    });

    await _idMapper.registerUuid('document', uuidVal);
  }

  Future<void> updateDocument(
    domain.Document doc, {
    Uint8List? bytes,
    String? fileName,
    String? contentType,
  }) async {
    final uuidVal = _idMapper.getUuid('document', doc.id);
    if (uuidVal == null) throw Exception('Could not resolve document UUID.');

    final clientUuid = _idMapper.getUuid('client', doc.clientId);
    if (clientUuid == null) throw Exception('Could not resolve client UUID.');

    String filePath = doc.filePath;
    final supabaseClient = sb.Supabase.instance.client;

    if (bytes != null && bytes.isNotEmpty) {
      final safeFileName = fileName ?? '${doc.title}_${DateTime.now().millisecondsSinceEpoch}';
      final storagePath = 'organizations/$_orgId/clients/$clientUuid/documents/${uuidVal}_$safeFileName';

      await supabaseClient.storage.from('documents').uploadBinary(
        storagePath,
        bytes,
        fileOptions: sb.FileOptions(contentType: contentType ?? 'application/octet-stream', upsert: true),
      );
      filePath = supabaseClient.storage.from('documents').getPublicUrl(storagePath);
    }

    await supabaseClient.from('documents').update({
      'client_id': clientUuid,
      'title': doc.title,
      'file_path': filePath,
    }).eq('id', uuidVal);
  }

  Future<void> deleteDocument(int id) async {
    final uuidVal = _idMapper.getUuid('document', id);
    if (uuidVal == null) throw Exception('Could not resolve document UUID.');

    final supabaseClient = sb.Supabase.instance.client;
    await supabaseClient.from('documents').update({'is_deleted': true}).eq('id', uuidVal);
  }

  Future<domain.Document> _mapRowToDomain(
    Map<String, dynamic> row,
    IdMapper idMapper,
  ) async {
    final uuidVal = row['id'] as String;
    final id = await idMapper.registerUuid('document', uuidVal);

    final clientUuid = row['client_id'] as String? ?? '';
    int clientId = 0;
    if (clientUuid.isNotEmpty) {
      clientId = await idMapper.registerUuid('client', clientUuid);
    }

    final title = row['title'] as String? ?? '';
    final filePath = row['file_path'] as String? ?? '';

    final createdAtStr = row['created_at'] as String;
    final createdAt = DateTime.parse(createdAtStr).toLocal();

    return domain.Document(
      id: id,
      syncId: uuidVal,
      uploadedByUserId: 1,
      clientId: clientId,
      title: title,
      filePath: filePath,
      createdAt: createdAt,
      lastModifiedUtc: createdAt.toUtc(),
      lastModifiedBy: 'App',
    );
  }
}
