import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// User entity matching legacy Domain/User.cs
///
/// Represents an artist or admin in the tattoo shop system.
@freezed
abstract class User with _$User {
  const factory User({
    /// Primary key
    required int id,

    /// Unique login username
    required String username,

    /// User email address
    @Default('') String email,

    /// Display name for UI
    @Default('') String displayName,

    /// Organization ID for multi-tenant isolation
    @Default('tester') String orgId,

    /// Hashed password (BCrypt)
    @Default('') String passwordHash,

    /// User role (Admin/Artist)
    @Default(UserRole.artist) UserRole role,

    /// UI theme preference key
    @Default('InfernalNeon') String themeKey,

    /// Path to avatar image
    @Default('') String avatarPath,

    /// Default hourly rate
    @Default(150.0) double hourlyRate,

    /// Work speed multiplier
    @Default(1.0) double speedFactor,

    /// Account creation timestamp
    required DateTime createdAt,

    /// Last update timestamp
    required DateTime updatedAt,

    /// Last login timestamp
    DateTime? lastLoginAt,

    /// Whether account is active
    @Default(true) bool isActive,

    /// Soft delete flag
    @Default(false) bool isDeleted,

    /// Deletion timestamp
    DateTime? deletedAt,

    /// Department assignment
    @Default('') String department,

    /// Commission rate (0-1, e.g., 0.1 = 10%)
    @Default(0.0) double commissionRate,

    /// UI font size preference
    @Default(14) int fontSize,

    /// JSON string for keyboard shortcuts
    @Default('') String keyboardShortcutsJson,

    /// JSON string for permissions
    @Default('') String permissionsJson,
  }) = _User;

  /// Private constructor for custom getters
  const User._();

  /// Check if user is an admin
  bool get isAdmin => role == UserRole.admin;

  /// Get effective display name (falls back to username)
  String get effectiveDisplayName =>
      displayName.isNotEmpty ? displayName : username;

  /// Create from JSON
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
