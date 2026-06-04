import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../shared/core/services/document_service.dart' as srv;
import '../../../../shared/domain/document.dart' as domain;

part 'documents_provider.g.dart';

@riverpod
class DocumentSearchQuery extends _$DocumentSearchQuery {
  @override
  String build() => '';
  void set(String query) => state = query;
}

@riverpod
Stream<List<domain.Document>> filteredDocuments(Ref ref) {
  final query = ref.watch(documentSearchQueryProvider);
  final docService = ref.watch(srv.documentServiceProvider);

  return docService.watchDocuments().map((docs) {
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
  final docService = ref.watch(srv.documentServiceProvider);
  return docService.watchDocumentById(id);
}

@riverpod
DocumentsService documentsService(Ref ref) {
  return DocumentsService(ref);
}

class DocumentsService {
  final Ref _ref;
  DocumentsService(this._ref);

  srv.DocumentService get _service => _ref.read(srv.documentServiceProvider);

  Future<void> createDocument(domain.Document doc) async {
    await _service.createDocument(doc);
  }

  Future<void> updateDocument(domain.Document doc) async {
    await _service.updateDocument(doc);
  }

  Future<void> deleteDocument(int id) async {
    await _service.deleteDocument(id);
  }
}
