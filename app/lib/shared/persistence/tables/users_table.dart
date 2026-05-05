import 'package:drift/drift.dart';

/// Users table for storing artist/admin records
/// Maps to: legacy Domain/User.cs
class Users extends Table {
  /// Primary key
  IntColumn get id => integer().autoIncrement()();

  /// Unique login username
  TextColumn get username => text().unique()();

  /// Display name for UI
  TextColumn get displayName => text().withDefault(const Constant(''))();

  /// Hashed password (BCrypt)
  TextColumn get passwordHash => text().withDefault(const Constant(''))();

  /// User role (admin/artist)
  TextColumn get role => text().withDefault(const Constant('artist'))();

  /// UI theme preference key
  TextColumn get themeKey =>
      text().withDefault(const Constant('InfernalNeon'))();

  /// Path to avatar image
  TextColumn get avatarPath => text().withDefault(const Constant(''))();

  /// Default hourly rate
  RealColumn get hourlyRate => real().withDefault(const Constant(150.0))();

  /// Work speed multiplier
  RealColumn get speedFactor => real().withDefault(const Constant(1.0))();

  /// Account creation timestamp
  DateTimeColumn get createdAt => dateTime()();

  /// Last update timestamp
  DateTimeColumn get updatedAt => dateTime()();

  /// Last login timestamp
  DateTimeColumn get lastLoginAt => dateTime().nullable()();

  /// Whether account is active
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  /// Soft delete flag
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();

  /// Deletion timestamp
  DateTimeColumn get deletedAt => dateTime().nullable()();

  /// Department assignment
  TextColumn get department => text().withDefault(const Constant(''))();

  /// Commission rate (0-1)
  RealColumn get commissionRate => real().withDefault(const Constant(0.0))();

  /// UI font size preference
  IntColumn get fontSize => integer().withDefault(const Constant(14))();

  /// JSON string for keyboard shortcuts
  TextColumn get keyboardShortcutsJson =>
      text().withDefault(const Constant(''))();

  /// JSON string for permissions
  TextColumn get permissionsJson => text().withDefault(const Constant(''))();
}
