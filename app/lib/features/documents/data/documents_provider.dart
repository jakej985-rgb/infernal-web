import 'dart:async';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared/cache/id_mapper.dart';
import '../../../shared/util/api_client.dart';
import '../../../../shared/domain/document.dart' as domain;

part 'documents_provider.g.dart';

@riverpod
class DocumentSearchQuery extends _$DocumentSearchQuery {
  @override
  String build() => '';
  void set(String query) => state = query;
}

final _documentsController = StreamController<List<domain.Document>>.broadcast();
Future<List<domain.Document>>? _pendingDocsFetch;

Future<List<domain.Document>> _fetchDocuments(Ref ref) async {
  final dio = ref.read(apiClientProvider);
  final idMapper = ref.read(idMapperProvider);
  try {
    final response = await dio.get('/documents');
    final rawList = response.data as List;
    final docs = <domain.Document>[];
    for (final item in rawList) {
      final map = item as Map<String, dynamic>;
      final uuid = map['id'] as String;
      final id = await idMapper.registerUuid('document', uuid);
      
      final clientUuid = map['client_id'] as String? ?? '';
      int clientId = 0;
      if (clientUuid.isNotEmpty) {
        clientId = await idMapper.registerUuid('client', clientUuid);
      }

      final name = map['name'] as String? ?? '';
      final filePath = map['file_path'] as String? ?? '';
      final createdAtStr = map['created_at'] as String?;
      final createdAt = createdAtStr != null ? DateTime.parse(createdAtStr).toLocal() : DateTime.now();

      docs.add(domain.Document(
        id: id,
        syncId: uuid,
        uploadedByUserId: 1, // Default local user ID
        clientId: clientId,
        title: name,
        filePath: filePath,
        createdAt: createdAt,
        lastModifiedUtc: createdAt,
        lastModifiedBy: 'App',
      ));
    }
    return docs;
  } on DioException catch (e) {
    throw ApiClientException.fromDioError(e);
  } catch (e) {
    throw ApiClientException('An unexpected error occurred: $e');
  }
}

void _triggerDocsUpdate(Ref ref) async {
  if (_pendingDocsFetch != null) return;
  _pendingDocsFetch = _fetchDocuments(ref);
  try {
    final list = await _pendingDocsFetch!;
    if (!_documentsController.isClosed) {
      _documentsController.add(list);
    }
  } catch (e) {
    if (!_documentsController.isClosed) {
      _documentsController.addError(e);
    }
  } finally {
    _pendingDocsFetch = null;
  }
}

@riverpod
Stream<List<domain.Document>> filteredDocuments(Ref ref) {
  final query = ref.watch(documentSearchQueryProvider);
  _triggerDocsUpdate(ref);

  return _documentsController.stream.map((docs) {
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
  _triggerDocsUpdate(ref);
  return _documentsController.stream.map((docs) {
    final match = docs.where((d) => d.id == id);
    return match.isEmpty ? null : match.first;
  });
}

@riverpod
DocumentsService documentsService(Ref ref) {
  return DocumentsService(ref);
}

class DocumentsService {
  final Ref _ref;
  DocumentsService(this._ref);

  Dio get _dio => _ref.read(apiClientProvider);
  IdMapper get _idMapper => _ref.read(idMapperProvider);

  Future<void> createDocument(domain.Document doc) async {
    try {
      final clientUuid = _idMapper.getUuid('client', doc.clientId);
      if (clientUuid == null) {
        throw ApiClientException('Could not resolve client UUID.');
      }

      // We upload a dummy file via multipart form data to satisfy the Go backend
      final formData = FormData.fromMap({
        'file': MultipartFile.fromString('dummy file contents', filename: doc.title),
        'client_id': clientUuid,
      });

      final response = await _dio.post('/documents/upload', data: formData);
      final uuid = (response.data as Map<String, dynamic>)['id'] as String;
      await _idMapper.registerUuid('document', uuid);
      _triggerDocsUpdate(_ref);
    } on DioException catch (e) {
      throw ApiClientException.fromDioError(e);
    }
  }

  Future<void> updateDocument(domain.Document doc) async {
    // The backend does not have an update route for documents, so we simulate it or re-create
    await createDocument(doc);
  }

  Future<void> deleteDocument(int id) async {
    try {
      var uuid = _idMapper.getUuid('document', id);
      if (uuid == null) {
        await _fetchDocuments(_ref);
        uuid = _idMapper.getUuid('document', id);
      }
      if (uuid == null) {
        throw ApiClientException('Could not resolve document UUID.');
      }
      await _dio.delete('/documents/$uuid');
      _triggerDocsUpdate(_ref);
    } on DioException catch (e) {
      throw ApiClientException.fromDioError(e);
    }
  }
}
