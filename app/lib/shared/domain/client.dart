import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'client.freezed.dart';
part 'client.g.dart';

/// Client entity matching legacy Domain/Client.cs
///
/// Represents a customer in the tattoo shop system.
@freezed
abstract class Client with _$Client {
  const factory Client({
    /// Primary key
    required int id,

    /// Sync identifier for multi-device sync
    required String syncId,

    /// First name
    required String firstName,

    /// Middle name (optional)
    @Default('') String middleName,

    /// Last name
    required String lastName,

    /// Phone number
    @Default('') String phone,

    /// Email address
    @Default('') String email,

    /// Free-form notes about the client
    @Default('') String notes,

    /// Number of visits
    @Default(0) int visits,

    /// Path to profile photo
    @Default('') String photoPath,

    /// Client status (Bound/FreshSoul/HighValue/Void)
    @Default(ClientStatus.bound) ClientStatus status,

    /// Creation timestamp (UTC)
    @JsonKey(readValue: _readCreatedAt) required DateTime createdAt,

    /// Last modification timestamp (UTC)
    required DateTime lastModifiedUtc,

    /// User who last modified this record
    @Default('') String lastModifiedBy,

    /// Soft delete flag
    @Default(false) bool isDeleted,
  }) = _Client;

  /// Private constructor for custom getters
  const Client._();

  /// Computed full name from parts
  String get fullName {
    final parts = <String>[];
    if (firstName.trim().isNotEmpty) parts.add(firstName.trim());
    if (middleName.trim().isNotEmpty) parts.add(middleName.trim());
    if (lastName.trim().isNotEmpty) parts.add(lastName.trim());
    return parts.join(' ');
  }

  /// Create from JSON
  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);
}

Object? _readCreatedAt(Map<dynamic, dynamic> json, String key) {
  return json[key] ?? json['lastModifiedUtc'];
}
