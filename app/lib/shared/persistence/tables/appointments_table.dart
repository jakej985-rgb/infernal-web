import 'package:drift/drift.dart';

/// Appointments table for storing scheduled sessions
/// Maps to: legacy Domain/Appointment.cs
class Appointments extends Table {
  /// Primary key
  IntColumn get id => integer().autoIncrement()();

  /// Sync identifier for multi-device sync
  TextColumn get syncId => text()();

  /// Foreign key to Client
  IntColumn get clientId => integer()();

  /// Foreign key to User (Artist)
  IntColumn get userId => integer()();

  /// Denormalized client name for quick display
  TextColumn get clientName => text().withDefault(const Constant(''))();

  /// Appointment start date/time (renamed from dateTime to avoid Table conflict)
  DateTimeColumn get startTime => dateTime()();

  /// Duration in minutes
  IntColumn get durationMinutes => integer()();

  /// Type of service (Tattoo, Piercing, etc.)
  TextColumn get serviceType => text().withDefault(const Constant('Tattoo'))();

  /// Service category grouping
  TextColumn get serviceCategory =>
      text().withDefault(const Constant('General'))();

  /// Pricing method (Hourly, Flat, etc.)
  TextColumn get priceType => text().withDefault(const Constant('Hourly'))();

  /// Amount charged
  RealColumn get priceCharged => real().withDefault(const Constant(0.0))();

  /// Original quoted price
  RealColumn get quotedPrice => real().nullable()();

  /// Finalized price
  RealColumn get finalPrice => real().nullable()();

  /// Free-form notes
  TextColumn get notes => text().nullable()();

  /// Path to reference photo
  TextColumn get photoPath => text().nullable()();

  /// Calendar display color (hex or named)
  TextColumn get color => text().withDefault(const Constant(''))();

  /// Current status (Scheduled, Completed, etc.)
  TextColumn get status => text().withDefault(const Constant('Scheduled'))();

  /// Whether this is a time block (not a real appointment)
  BoolColumn get isBlockOff => boolean().withDefault(const Constant(false))();

  /// Last modification timestamp (UTC)
  DateTimeColumn get modifiedAt => dateTime()();

  /// User who last modified this record
  TextColumn get lastModifiedBy => text().withDefault(const Constant(''))();

  /// Soft delete flag
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
}
