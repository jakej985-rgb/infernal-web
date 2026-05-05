import 'package:drift/drift.dart';

/// Documents table for storing file uploads
/// Maps to: legacy Domain/Document.cs
class Documents extends Table {
  /// Primary key
  IntColumn get id => integer().autoIncrement()();

  /// Sync identifier for multi-device sync
  TextColumn get syncId => text()();

  /// Foreign key to User who uploaded
  IntColumn get uploadedByUserId => integer()();

  /// Foreign key to Client
  IntColumn get clientId => integer()();

  /// Document title/name
  TextColumn get title => text()();

  /// File storage path
  TextColumn get filePath => text()();

  /// Upload timestamp
  DateTimeColumn get createdAt => dateTime()();

  /// Last modification timestamp (UTC)
  DateTimeColumn get lastModifiedUtc => dateTime()();

  /// User who last modified this record
  TextColumn get lastModifiedBy => text().withDefault(const Constant(''))();

  /// Soft delete flag
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
}
