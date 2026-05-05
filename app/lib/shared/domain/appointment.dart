import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'appointment.freezed.dart';
part 'appointment.g.dart';

/// Appointment entity matching legacy Domain/Appointment.cs
///
/// Represents a scheduled session (tattoo, piercing, etc.) in the shop.
@freezed
abstract class Appointment with _$Appointment {
  const factory Appointment({
    /// Primary key
    required int id,

    /// Sync identifier for multi-device sync
    required String syncId,

    /// Foreign key to Client
    required int clientId,

    /// Foreign key to User (Artist)
    required int userId,

    /// Denormalized client name for quick display
    @Default('') String clientName,

    /// Appointment start date/time
    required DateTime dateTime,

    /// Duration in minutes
    required int durationMinutes,

    /// Type of service (Tattoo, Piercing, etc.)
    @Default('Tattoo') String serviceType,

    /// Service category grouping
    @Default('General') String serviceCategory,

    /// Pricing method (Hourly, Flat, etc.)
    @Default('Hourly') String priceType,

    /// Amount charged
    @Default(0.0) double priceCharged,

    /// Original quoted price
    double? quotedPrice,

    /// Finalized price
    double? finalPrice,

    /// Free-form notes
    String? notes,

    /// Path to reference photo
    String? photoPath,

    /// Calendar display color (hex or named)
    @Default('') String color,

    /// Current status (Scheduled, Completed, etc.)
    @Default('Scheduled') String status,

    /// Whether this is a time block (not a real appointment)
    @Default(false) bool isBlockOff,

    /// Last modification timestamp (UTC)
    required DateTime lastModifiedUtc,

    /// User who last modified this record
    @Default('') String lastModifiedBy,

    /// Soft delete flag
    @Default(false) bool isDeleted,
  }) = _Appointment;

  /// Private constructor for custom getters
  const Appointment._();

  /// Computed end time based on dateTime + duration
  DateTime get endTime => dateTime.add(Duration(minutes: durationMinutes));

  /// Alias for userId (legacy compatibility)
  int get artistId => userId;

  /// Alias for dateTime (legacy compatibility)
  DateTime get startTime => dateTime;

  /// Parse status string to enum
  AppointmentStatus get statusEnum {
    switch (status.toLowerCase()) {
      case 'scheduled':
        return AppointmentStatus.scheduled;
      case 'inprogress':
      case 'in progress':
        return AppointmentStatus.inProgress;
      case 'completed':
        return AppointmentStatus.completed;
      case 'cancelled':
      case 'canceled':
        return AppointmentStatus.cancelled;
      case 'noshow':
      case 'no show':
        return AppointmentStatus.noShow;
      case 'waitlist':
      case 'purgatory':
        return AppointmentStatus.waitlist;
      default:
        return AppointmentStatus.scheduled;
    }
  }

  /// Create from JSON
  factory Appointment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentFromJson(json);
}
