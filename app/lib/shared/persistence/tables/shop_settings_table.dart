import 'package:drift/drift.dart';

/// Shop settings table for global configuration
/// Maps to: legacy Domain/ShopSettings.cs
/// Note: This is a singleton table (typically one row with id=-1 or id=1)
class ShopSettingsTable extends Table {
  @override
  String get tableName => 'shop_settings';

  /// Primary key (typically -1 or 1 for singleton)
  IntColumn get id => integer().withDefault(const Constant(1))();

  /// Shop name for display
  TextColumn get shopName => text().withDefault(const Constant(''))();

  /// Path to logo image
  TextColumn get logoPath => text().withDefault(const Constant(''))();

  /// Primary accent color (hex or named)
  TextColumn get accentColor => text().withDefault(const Constant(''))();

  /// Path to sidebar artwork
  TextColumn get sidebarArtworkPath => text().withDefault(const Constant(''))();

  /// Special message text for announcements
  TextColumn get specialMessageText => text().withDefault(const Constant(''))();

  /// Path to login background image
  TextColumn get loginBackgroundPath =>
      text().withDefault(const Constant(''))();

  /// Login headline font family
  TextColumn get loginHeadlineFontFamily =>
      text().withDefault(const Constant(''))();

  /// Login tagline font family
  TextColumn get loginTaglineFontFamily =>
      text().withDefault(const Constant(''))();

  /// Login text color
  TextColumn get loginTextColor => text().withDefault(const Constant(''))();

  /// Tattoo hourly rate
  RealColumn get tattooPerHour => real().withDefault(const Constant(150.0))();

  /// Single piercing price
  RealColumn get piercingSingle => real().withDefault(const Constant(50.0))();

  /// Multiple piercing discount price
  RealColumn get piercingMulti => real().withDefault(const Constant(40.0))();

  /// Shop minimum charge
  RealColumn get shopMinimumRate => real().withDefault(const Constant(100.0))();

  /// Whether to enable automatic holiday themes
  BoolColumn get enableAutomaticHolidayThemes =>
      boolean().withDefault(const Constant(false))();

  /// Whether special message is enabled
  BoolColumn get isSpecialMessageEnabled =>
      boolean().withDefault(const Constant(true))();

  /// JSON string for shop hours by day
  TextColumn get shopHoursJson => text().withDefault(const Constant(''))();

  /// Sales tax rate (0-1)
  RealColumn get taxRate => real().withDefault(const Constant(0.0))();

  /// Deposit type (percentage/fixed)
  TextColumn get depositType =>
      text().withDefault(const Constant('percentage'))();

  /// Deposit amount (percentage or fixed value)
  RealColumn get depositAmount => real().withDefault(const Constant(20.0))();

  /// Buffer minutes between bookings
  IntColumn get bookingBufferMinutes =>
      integer().withDefault(const Constant(15))();

  /// Cancellation policy text
  TextColumn get cancellationPolicy => text().withDefault(const Constant(''))();

  /// JSON string for appointment duration presets
  TextColumn get appointmentDurationPresetsJson =>
      text().withDefault(const Constant(''))();

  /// JSON string for special hours/closures
  TextColumn get specialHoursJson => text().withDefault(const Constant(''))();

  /// JSON string for notification settings
  TextColumn get notificationSettingsJson =>
      text().withDefault(const Constant(''))();

  /// JSON string for backup settings
  TextColumn get backupSettingsJson => text().withDefault(const Constant(''))();

  /// JSON string for linked accounts
  TextColumn get linkedAccountsJson => text().withDefault(const Constant(''))();

  /// Default app font size
  RealColumn get appFontSize => real().withDefault(const Constant(14.0))();

  /// Record creation timestamp
  DateTimeColumn get createdAt => dateTime()();

  /// Last update timestamp
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
