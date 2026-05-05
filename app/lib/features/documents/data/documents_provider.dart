import 'package:drift/drift.dart' show Value;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../../../../shared/domain/document.dart' as domain;
import '../../../../shared/persistence/database.dart';

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
  final dao = ref.watch(databaseProvider).documentsDao;

  return dao.watchAllDocuments().map((rows) {
     final docs = rows.map((row) => _mapToDomain(row)).toList();
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
  final dao = ref.watch(databaseProvider).documentsDao;
  return dao.watchDocumentById(id).map((row) => row == null ? null : _mapToDomain(row));
}

@riverpod
DocumentsService documentsService(Ref ref) {
  return DocumentsService(ref);
}

class DocumentsService {
  final Ref _ref;
  DocumentsService(this._ref);

  Future<void> createDocument(domain.Document doc) async {
    final dao = _ref.read(databaseProvider).documentsDao;
    await dao.insertDocument(
       DocumentsCompanion(
          uploadedByUserId: Value(doc.uploadedByUserId),
          clientId: Value(doc.clientId),
          title: Value(doc.title),
          filePath: Value(doc.filePath),
          syncId: Value(doc.syncId.isEmpty ? const Uuid().v4() : doc.syncId),
          createdAt: Value(DateTime.now()),
          lastModifiedUtc: Value(DateTime.now()),
          lastModifiedBy: const Value('App'),
          isDeleted: const Value(false),
       ),
    );
  }

  Future<void> updateDocument(domain.Document doc) async {
    final dao = _ref.read(databaseProvider).documentsDao;
    final row = Document(
       id: doc.id,
       syncId: doc.syncId,
       uploadedByUserId: doc.uploadedByUserId,
       clientId: doc.clientId,
       title: doc.title,
       filePath: doc.filePath,
       createdAt: doc.createdAt,
       lastModifiedUtc: DateTime.now(),
       lastModifiedBy: 'App',
       isDeleted: false,
    );
    await dao.updateDocument(row);
  }

  Future<void> deleteDocument(int id) async {
    final dao = _ref.read(databaseProvider).documentsDao;
    await dao.softDeleteDocument(id);
  }
}

domain.Document _mapToDomain(Document row) {
  return domain.Document(
    id: row.id,
    syncId: row.syncId,
    uploadedByUserId: row.uploadedByUserId,
    clientId: row.clientId,
    title: row.title,
    filePath: row.filePath,
    createdAt: row.createdAt,
    lastModifiedUtc: row.lastModifiedUtc,
    lastModifiedBy: row.lastModifiedBy,
  );
}
