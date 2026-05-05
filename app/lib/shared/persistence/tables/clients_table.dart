import 'package:drift/drift.dart';

/// Clients table for storing client/customer records
/// Maps to: legacy Domain/Client.cs
class Clients extends Table {
  /// Primary key
  IntColumn get id => integer().autoIncrement()();

  /// Sync identifier for multi-device sync
  TextColumn get syncId => text()();

  /// First name
  TextColumn get firstName => text()();

  /// Middle name (optional)
  TextColumn get middleName => text().withDefault(const Constant(''))();

  /// Last name
  TextColumn get lastName => text()();

  /// Phone number
  TextColumn get phone => text().withDefault(const Constant(''))();

  /// Email address
  TextColumn get email => text().withDefault(const Constant(''))();

  /// Free-form notes
  TextColumn get notes => text().withDefault(const Constant(''))();

  /// Number of visits
  IntColumn get visits => integer().withDefault(const Constant(0))();

  /// Path to profile photo
  TextColumn get photoPath => text().withDefault(const Constant(''))();

  /// Client status (bound/freshSoul/highValue/void_)
  TextColumn get status => text().withDefault(const Constant('bound'))();

  /// Last modification timestamp (UTC)
  DateTimeColumn get lastModifiedUtc => dateTime()();

  /// User who last modified this record
  TextColumn get lastModifiedBy => text().withDefault(const Constant(''))();

  /// Soft delete flag
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
}
