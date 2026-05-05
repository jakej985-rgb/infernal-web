import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'shop_settings.freezed.dart';
part 'shop_settings.g.dart';

/// ShopSettings entity matching legacy Domain/ShopSettings.cs
///
/// Global shop configuration settings (singleton row in database).
@freezed
abstract class ShopSettings with _$ShopSettings {
  const factory ShopSettings({
    /// Primary key (typically -1 for singleton)
    @Default(-1) int id,

    /// Shop name for display
    @Default('') String shopName,

    /// Path to logo image
    @Default('') String logoPath,

    /// Primary accent color (hex or named)
    @Default('') String accentColor,

    /// Path to sidebar artwork
    @Default('') String sidebarArtworkPath,

    /// Special message text for announcements
    @Default('') String specialMessageText,

    /// Path to login background image
    @Default('') String loginBackgroundPath,

    /// Login headline font family
    @Default('') String loginHeadlineFontFamily,

    /// Login tagline font family
    @Default('') String loginTaglineFontFamily,

    /// Login text color
    @Default('') String loginTextColor,

    /// Tattoo hourly rate
    @Default(150.0) double tattooPerHour,

    /// Single piercing price
    @Default(50.0) double piercingSingle,

    /// Multiple piercing discount price
    @Default(40.0) double piercingMulti,

    /// Shop minimum charge
    @Default(100.0) double shopMinimumRate,

    /// Whether to enable automatic holiday themes
    @Default(false) bool enableAutomaticHolidayThemes,

    /// Whether special message is enabled
    @Default(true) bool isSpecialMessageEnabled,

    /// JSON string for shop hours by day
    @Default('') String shopHoursJson,

    /// Sales tax rate (0-1, e.g., 0.08 = 8%)
    @Default(0.0) double taxRate,

    /// Deposit type (Percentage or Fixed)
    @Default(DepositType.percentage) DepositType depositType,

    /// Deposit amount (percentage or fixed value)
    @Default(20.0) double depositAmount,

    /// Buffer minutes between bookings
    @Default(15) int bookingBufferMinutes,

    /// Cancellation policy text
    @Default('') String cancellationPolicy,

    /// JSON string for appointment duration presets
    @Default('') String appointmentDurationPresetsJson,

    /// JSON string for special hours/closures
    @Default('') String specialHoursJson,

    /// JSON string for notification settings
    @Default('') String notificationSettingsJson,

    /// JSON string for backup settings
    @Default('') String backupSettingsJson,

    /// JSON string for linked accounts
    @Default('') String linkedAccountsJson,

    /// Default app font size
    @Default(14.0) double appFontSize,

    /// Record creation timestamp
    required DateTime createdAt,

    /// Last update timestamp
    required DateTime updatedAt,
  }) = _ShopSettings;

  /// Private constructor for custom getters
  const ShopSettings._();

  /// Calculate deposit for a given price
  double calculateDeposit(double price) {
    return switch (depositType) {
      DepositType.percentage => price * (depositAmount / 100),
      DepositType.fixed => depositAmount,
    };
  }

  /// Calculate price with tax
  double calculateWithTax(double price) {
    return price * (1 + taxRate);
  }

  /// Create from JSON
  factory ShopSettings.fromJson(Map<String, dynamic> json) =>
      _$ShopSettingsFromJson(json);
}

/// Day-specific shop hours configuration
/// Matching legacy ShopDaySetting
@freezed
abstract class ShopDaySetting with _$ShopDaySetting {
  const factory ShopDaySetting({
    /// Day of week (1=Monday, 7=Sunday for DateTime convention)
    required int dayOfWeek,

    /// Whether shop is open this day
    @Default(true) bool isOpen,

    /// Opening time (minutes from midnight)
    @Default(540) int startTimeMinutes, // 9:00 AM
    /// Closing time (minutes from midnight)
    @Default(1080) int endTimeMinutes, // 6:00 PM
  }) = _ShopDaySetting;

  /// Private constructor for custom getters
  const ShopDaySetting._();

  /// Get start time as Duration
  Duration get startTime => Duration(minutes: startTimeMinutes);

  /// Get end time as Duration
  Duration get endTime => Duration(minutes: endTimeMinutes);

  /// Formatted start time string (HH:MM)
  String get startTimeFormatted {
    final hours = startTimeMinutes ~/ 60;
    final minutes = startTimeMinutes % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  }

  /// Formatted end time string (HH:MM)
  String get endTimeFormatted {
    final hours = endTimeMinutes ~/ 60;
    final minutes = endTimeMinutes % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  }

  /// Create from JSON
  factory ShopDaySetting.fromJson(Map<String, dynamic> json) =>
      _$ShopDaySettingFromJson(json);
}
