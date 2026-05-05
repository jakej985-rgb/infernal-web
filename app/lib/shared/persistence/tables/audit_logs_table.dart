import 'package:drift/drift.dart';

/// Table for tracking user actions and system events
class AuditLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  
  /// Type of action (CREATE, UPDATE, DELETE, LOGIN, etc.)
  TextColumn get action => text()();
  
  /// Entity affected (Client, Appointment, etc.)
  TextColumn get entityType => text().nullable()();
  
  /// ID of the affected entity
  TextColumn get entityId => text().nullable()();
  
  /// User who performed the action
  IntColumn get userId => integer().nullable()();
  
  /// When it happened
  DateTimeColumn get timestamp => dateTime()();
  
  /// Additional JSON details
  TextColumn get details => text().withDefault(const Constant(''))();
}
