import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../database.dart';
import '../tables/documents_table.dart';

part 'documents_dao.g.dart';

/// Data Access Object for Documents table
@DriftAccessor(tables: [Documents])
class DocumentsDao extends DatabaseAccessor<AppDatabase>
    with _$DocumentsDaoMixin {
  DocumentsDao(super.db);

  static const _uuid = Uuid();

  /// Get all non-deleted documents
  Future<List<Document>> getAllDocuments() {
    return (select(documents)
          ..where((d) => d.isDeleted.equals(false))
          ..orderBy([(d) => OrderingTerm.desc(d.createdAt)]))
        .get();
  }

  /// Watch all non-deleted documents
  Stream<List<Document>> watchAllDocuments() {
    return (select(documents)
          ..where((d) => d.isDeleted.equals(false))
          ..orderBy([(d) => OrderingTerm.desc(d.createdAt)]))
        .watch();
  }

  /// Get document by ID
  Future<Document?> getDocumentById(int id) {
    return (select(documents)..where((d) => d.id.equals(id))).getSingleOrNull();
  }

  /// Watch document by ID
  Stream<Document?> watchDocumentById(int id) {
    return (select(documents)..where((d) => d.id.equals(id))).watchSingleOrNull();
  }

  /// Get documents by client
  Future<List<Document>> getDocumentsByClient(int clientId) {
    return (select(documents)
          ..where(
            (d) => d.isDeleted.equals(false) & d.clientId.equals(clientId),
          )
          ..orderBy([(d) => OrderingTerm.desc(d.createdAt)]))
        .get();
  }

  /// Watch documents for a client
  Stream<List<Document>> watchDocumentsByClient(int clientId) {
    return (select(documents)
          ..where(
            (d) => d.isDeleted.equals(false) & d.clientId.equals(clientId),
          )
          ..orderBy([(d) => OrderingTerm.desc(d.createdAt)]))
        .watch();
  }

  /// Get documents uploaded by a specific user
  Future<List<Document>> getDocumentsByUploader(int userId) {
    return (select(documents)
          ..where(
            (d) =>
                d.isDeleted.equals(false) & d.uploadedByUserId.equals(userId),
          )
          ..orderBy([(d) => OrderingTerm.desc(d.createdAt)]))
        .get();
  }

  /// Insert a new document
  Future<int> insertDocument(DocumentsCompanion document) {
    final withSyncId = document.syncId.present
        ? document
        : document.copyWith(syncId: Value(_uuid.v4()));
    return into(documents).insert(withSyncId);
  }

  /// Update an existing document
  Future<bool> updateDocument(Document document) {
    return update(documents).replace(document);
  }

  /// Soft delete a document
  Future<int> softDeleteDocument(int id) {
    return (update(documents)..where((d) => d.id.equals(id))).write(
      DocumentsCompanion(
        isDeleted: const Value(true),
        lastModifiedUtc: Value(DateTime.now()),
      ),
    );
  }

  /// Hard delete a document
  Future<int> deleteDocument(int id) {
    return (delete(documents)..where((d) => d.id.equals(id))).go();
  }
}
