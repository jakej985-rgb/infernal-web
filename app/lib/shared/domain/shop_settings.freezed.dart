// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shop_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ShopSettings {

/// Primary key (typically -1 for singleton)
 int get id;/// Shop name for display
 String get shopName;/// Path to logo image
 String get logoPath;/// Primary accent color (hex or named)
 String get accentColor;/// Path to sidebar artwork
 String get sidebarArtworkPath;/// Special message text for announcements
 String get specialMessageText;/// Path to login background image
 String get loginBackgroundPath;/// Login headline font family
 String get loginHeadlineFontFamily;/// Login tagline font family
 String get loginTaglineFontFamily;/// Login text color
 String get loginTextColor;/// Tattoo hourly rate
 double get tattooPerHour;/// Single piercing price
 double get piercingSingle;/// Multiple piercing discount price
 double get piercingMulti;/// Shop minimum charge
 double get shopMinimumRate;/// Whether to enable automatic holiday themes
 bool get enableAutomaticHolidayThemes;/// Whether special message is enabled
 bool get isSpecialMessageEnabled;/// JSON string for shop hours by day
 String get shopHoursJson;/// Sales tax rate (0-1, e.g., 0.08 = 8%)
 double get taxRate;/// Deposit type (Percentage or Fixed)
 DepositType get depositType;/// Deposit amount (percentage or fixed value)
 double get depositAmount;/// Buffer minutes between bookings
 int get bookingBufferMinutes;/// Cancellation policy text
 String get cancellationPolicy;/// JSON string for appointment duration presets
 String get appointmentDurationPresetsJson;/// JSON string for special hours/closures
 String get specialHoursJson;/// JSON string for notification settings
 String get notificationSettingsJson;/// JSON string for backup settings
 String get backupSettingsJson;/// JSON string for linked accounts
 String get linkedAccountsJson;/// Default app font size
 double get appFontSize;/// Record creation timestamp
 DateTime get createdAt;/// Last update timestamp
 DateTime get updatedAt;
/// Create a copy of ShopSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShopSettingsCopyWith<ShopSettings> get copyWith => _$ShopSettingsCopyWithImpl<ShopSettings>(this as ShopSettings, _$identity);

  /// Serializes this ShopSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShopSettings&&(identical(other.id, id) || other.id == id)&&(identical(other.shopName, shopName) || other.shopName == shopName)&&(identical(other.logoPath, logoPath) || other.logoPath == logoPath)&&(identical(other.accentColor, accentColor) || other.accentColor == accentColor)&&(identical(other.sidebarArtworkPath, sidebarArtworkPath) || other.sidebarArtworkPath == sidebarArtworkPath)&&(identical(other.specialMessageText, specialMessageText) || other.specialMessageText == specialMessageText)&&(identical(other.loginBackgroundPath, loginBackgroundPath) || other.loginBackgroundPath == loginBackgroundPath)&&(identical(other.loginHeadlineFontFamily, loginHeadlineFontFamily) || other.loginHeadlineFontFamily == loginHeadlineFontFamily)&&(identical(other.loginTaglineFontFamily, loginTaglineFontFamily) || other.loginTaglineFontFamily == loginTaglineFontFamily)&&(identical(other.loginTextColor, loginTextColor) || other.loginTextColor == loginTextColor)&&(identical(other.tattooPerHour, tattooPerHour) || other.tattooPerHour == tattooPerHour)&&(identical(other.piercingSingle, piercingSingle) || other.piercingSingle == piercingSingle)&&(identical(other.piercingMulti, piercingMulti) || other.piercingMulti == piercingMulti)&&(identical(other.shopMinimumRate, shopMinimumRate) || other.shopMinimumRate == shopMinimumRate)&&(identical(other.enableAutomaticHolidayThemes, enableAutomaticHolidayThemes) || other.enableAutomaticHolidayThemes == enableAutomaticHolidayThemes)&&(identical(other.isSpecialMessageEnabled, isSpecialMessageEnabled) || other.isSpecialMessageEnabled == isSpecialMessageEnabled)&&(identical(other.shopHoursJson, shopHoursJson) || other.shopHoursJson == shopHoursJson)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.depositType, depositType) || other.depositType == depositType)&&(identical(other.depositAmount, depositAmount) || other.depositAmount == depositAmount)&&(identical(other.bookingBufferMinutes, bookingBufferMinutes) || other.bookingBufferMinutes == bookingBufferMinutes)&&(identical(other.cancellationPolicy, cancellationPolicy) || other.cancellationPolicy == cancellationPolicy)&&(identical(other.appointmentDurationPresetsJson, appointmentDurationPresetsJson) || other.appointmentDurationPresetsJson == appointmentDurationPresetsJson)&&(identical(other.specialHoursJson, specialHoursJson) || other.specialHoursJson == specialHoursJson)&&(identical(other.notificationSettingsJson, notificationSettingsJson) || other.notificationSettingsJson == notificationSettingsJson)&&(identical(other.backupSettingsJson, backupSettingsJson) || other.backupSettingsJson == backupSettingsJson)&&(identical(other.linkedAccountsJson, linkedAccountsJson) || other.linkedAccountsJson == linkedAccountsJson)&&(identical(other.appFontSize, appFontSize) || other.appFontSize == appFontSize)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,shopName,logoPath,accentColor,sidebarArtworkPath,specialMessageText,loginBackgroundPath,loginHeadlineFontFamily,loginTaglineFontFamily,loginTextColor,tattooPerHour,piercingSingle,piercingMulti,shopMinimumRate,enableAutomaticHolidayThemes,isSpecialMessageEnabled,shopHoursJson,taxRate,depositType,depositAmount,bookingBufferMinutes,cancellationPolicy,appointmentDurationPresetsJson,specialHoursJson,notificationSettingsJson,backupSettingsJson,linkedAccountsJson,appFontSize,createdAt,updatedAt]);

@override
String toString() {
  return 'ShopSettings(id: $id, shopName: $shopName, logoPath: $logoPath, accentColor: $accentColor, sidebarArtworkPath: $sidebarArtworkPath, specialMessageText: $specialMessageText, loginBackgroundPath: $loginBackgroundPath, loginHeadlineFontFamily: $loginHeadlineFontFamily, loginTaglineFontFamily: $loginTaglineFontFamily, loginTextColor: $loginTextColor, tattooPerHour: $tattooPerHour, piercingSingle: $piercingSingle, piercingMulti: $piercingMulti, shopMinimumRate: $shopMinimumRate, enableAutomaticHolidayThemes: $enableAutomaticHolidayThemes, isSpecialMessageEnabled: $isSpecialMessageEnabled, shopHoursJson: $shopHoursJson, taxRate: $taxRate, depositType: $depositType, depositAmount: $depositAmount, bookingBufferMinutes: $bookingBufferMinutes, cancellationPolicy: $cancellationPolicy, appointmentDurationPresetsJson: $appointmentDurationPresetsJson, specialHoursJson: $specialHoursJson, notificationSettingsJson: $notificationSettingsJson, backupSettingsJson: $backupSettingsJson, linkedAccountsJson: $linkedAccountsJson, appFontSize: $appFontSize, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ShopSettingsCopyWith<$Res>  {
  factory $ShopSettingsCopyWith(ShopSettings value, $Res Function(ShopSettings) _then) = _$ShopSettingsCopyWithImpl;
@useResult
$Res call({
 int id, String shopName, String logoPath, String accentColor, String sidebarArtworkPath, String specialMessageText, String loginBackgroundPath, String loginHeadlineFontFamily, String loginTaglineFontFamily, String loginTextColor, double tattooPerHour, double piercingSingle, double piercingMulti, double shopMinimumRate, bool enableAutomaticHolidayThemes, bool isSpecialMessageEnabled, String shopHoursJson, double taxRate, DepositType depositType, double depositAmount, int bookingBufferMinutes, String cancellationPolicy, String appointmentDurationPresetsJson, String specialHoursJson, String notificationSettingsJson, String backupSettingsJson, String linkedAccountsJson, double appFontSize, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$ShopSettingsCopyWithImpl<$Res>
    implements $ShopSettingsCopyWith<$Res> {
  _$ShopSettingsCopyWithImpl(this._self, this._then);

  final ShopSettings _self;
  final $Res Function(ShopSettings) _then;

/// Create a copy of ShopSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? shopName = null,Object? logoPath = null,Object? accentColor = null,Object? sidebarArtworkPath = null,Object? specialMessageText = null,Object? loginBackgroundPath = null,Object? loginHeadlineFontFamily = null,Object? loginTaglineFontFamily = null,Object? loginTextColor = null,Object? tattooPerHour = null,Object? piercingSingle = null,Object? piercingMulti = null,Object? shopMinimumRate = null,Object? enableAutomaticHolidayThemes = null,Object? isSpecialMessageEnabled = null,Object? shopHoursJson = null,Object? taxRate = null,Object? depositType = null,Object? depositAmount = null,Object? bookingBufferMinutes = null,Object? cancellationPolicy = null,Object? appointmentDurationPresetsJson = null,Object? specialHoursJson = null,Object? notificationSettingsJson = null,Object? backupSettingsJson = null,Object? linkedAccountsJson = null,Object? appFontSize = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,shopName: null == shopName ? _self.shopName : shopName // ignore: cast_nullable_to_non_nullable
as String,logoPath: null == logoPath ? _self.logoPath : logoPath // ignore: cast_nullable_to_non_nullable
as String,accentColor: null == accentColor ? _self.accentColor : accentColor // ignore: cast_nullable_to_non_nullable
as String,sidebarArtworkPath: null == sidebarArtworkPath ? _self.sidebarArtworkPath : sidebarArtworkPath // ignore: cast_nullable_to_non_nullable
as String,specialMessageText: null == specialMessageText ? _self.specialMessageText : specialMessageText // ignore: cast_nullable_to_non_nullable
as String,loginBackgroundPath: null == loginBackgroundPath ? _self.loginBackgroundPath : loginBackgroundPath // ignore: cast_nullable_to_non_nullable
as String,loginHeadlineFontFamily: null == loginHeadlineFontFamily ? _self.loginHeadlineFontFamily : loginHeadlineFontFamily // ignore: cast_nullable_to_non_nullable
as String,loginTaglineFontFamily: null == loginTaglineFontFamily ? _self.loginTaglineFontFamily : loginTaglineFontFamily // ignore: cast_nullable_to_non_nullable
as String,loginTextColor: null == loginTextColor ? _self.loginTextColor : loginTextColor // ignore: cast_nullable_to_non_nullable
as String,tattooPerHour: null == tattooPerHour ? _self.tattooPerHour : tattooPerHour // ignore: cast_nullable_to_non_nullable
as double,piercingSingle: null == piercingSingle ? _self.piercingSingle : piercingSingle // ignore: cast_nullable_to_non_nullable
as double,piercingMulti: null == piercingMulti ? _self.piercingMulti : piercingMulti // ignore: cast_nullable_to_non_nullable
as double,shopMinimumRate: null == shopMinimumRate ? _self.shopMinimumRate : shopMinimumRate // ignore: cast_nullable_to_non_nullable
as double,enableAutomaticHolidayThemes: null == enableAutomaticHolidayThemes ? _self.enableAutomaticHolidayThemes : enableAutomaticHolidayThemes // ignore: cast_nullable_to_non_nullable
as bool,isSpecialMessageEnabled: null == isSpecialMessageEnabled ? _self.isSpecialMessageEnabled : isSpecialMessageEnabled // ignore: cast_nullable_to_non_nullable
as bool,shopHoursJson: null == shopHoursJson ? _self.shopHoursJson : shopHoursJson // ignore: cast_nullable_to_non_nullable
as String,taxRate: null == taxRate ? _self.taxRate : taxRate // ignore: cast_nullable_to_non_nullable
as double,depositType: null == depositType ? _self.depositType : depositType // ignore: cast_nullable_to_non_nullable
as DepositType,depositAmount: null == depositAmount ? _self.depositAmount : depositAmount // ignore: cast_nullable_to_non_nullable
as double,bookingBufferMinutes: null == bookingBufferMinutes ? _self.bookingBufferMinutes : bookingBufferMinutes // ignore: cast_nullable_to_non_nullable
as int,cancellationPolicy: null == cancellationPolicy ? _self.cancellationPolicy : cancellationPolicy // ignore: cast_nullable_to_non_nullable
as String,appointmentDurationPresetsJson: null == appointmentDurationPresetsJson ? _self.appointmentDurationPresetsJson : appointmentDurationPresetsJson // ignore: cast_nullable_to_non_nullable
as String,specialHoursJson: null == specialHoursJson ? _self.specialHoursJson : specialHoursJson // ignore: cast_nullable_to_non_nullable
as String,notificationSettingsJson: null == notificationSettingsJson ? _self.notificationSettingsJson : notificationSettingsJson // ignore: cast_nullable_to_non_nullable
as String,backupSettingsJson: null == backupSettingsJson ? _self.backupSettingsJson : backupSettingsJson // ignore: cast_nullable_to_non_nullable
as String,linkedAccountsJson: null == linkedAccountsJson ? _self.linkedAccountsJson : linkedAccountsJson // ignore: cast_nullable_to_non_nullable
as String,appFontSize: null == appFontSize ? _self.appFontSize : appFontSize // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ShopSettings].
extension ShopSettingsPatterns on ShopSettings {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShopSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShopSettings() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShopSettings value)  $default,){
final _that = this;
switch (_that) {
case _ShopSettings():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShopSettings value)?  $default,){
final _that = this;
switch (_that) {
case _ShopSettings() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String shopName,  String logoPath,  String accentColor,  String sidebarArtworkPath,  String specialMessageText,  String loginBackgroundPath,  String loginHeadlineFontFamily,  String loginTaglineFontFamily,  String loginTextColor,  double tattooPerHour,  double piercingSingle,  double piercingMulti,  double shopMinimumRate,  bool enableAutomaticHolidayThemes,  bool isSpecialMessageEnabled,  String shopHoursJson,  double taxRate,  DepositType depositType,  double depositAmount,  int bookingBufferMinutes,  String cancellationPolicy,  String appointmentDurationPresetsJson,  String specialHoursJson,  String notificationSettingsJson,  String backupSettingsJson,  String linkedAccountsJson,  double appFontSize,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShopSettings() when $default != null:
return $default(_that.id,_that.shopName,_that.logoPath,_that.accentColor,_that.sidebarArtworkPath,_that.specialMessageText,_that.loginBackgroundPath,_that.loginHeadlineFontFamily,_that.loginTaglineFontFamily,_that.loginTextColor,_that.tattooPerHour,_that.piercingSingle,_that.piercingMulti,_that.shopMinimumRate,_that.enableAutomaticHolidayThemes,_that.isSpecialMessageEnabled,_that.shopHoursJson,_that.taxRate,_that.depositType,_that.depositAmount,_that.bookingBufferMinutes,_that.cancellationPolicy,_that.appointmentDurationPresetsJson,_that.specialHoursJson,_that.notificationSettingsJson,_that.backupSettingsJson,_that.linkedAccountsJson,_that.appFontSize,_that.createdAt,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String shopName,  String logoPath,  String accentColor,  String sidebarArtworkPath,  String specialMessageText,  String loginBackgroundPath,  String loginHeadlineFontFamily,  String loginTaglineFontFamily,  String loginTextColor,  double tattooPerHour,  double piercingSingle,  double piercingMulti,  double shopMinimumRate,  bool enableAutomaticHolidayThemes,  bool isSpecialMessageEnabled,  String shopHoursJson,  double taxRate,  DepositType depositType,  double depositAmount,  int bookingBufferMinutes,  String cancellationPolicy,  String appointmentDurationPresetsJson,  String specialHoursJson,  String notificationSettingsJson,  String backupSettingsJson,  String linkedAccountsJson,  double appFontSize,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _ShopSettings():
return $default(_that.id,_that.shopName,_that.logoPath,_that.accentColor,_that.sidebarArtworkPath,_that.specialMessageText,_that.loginBackgroundPath,_that.loginHeadlineFontFamily,_that.loginTaglineFontFamily,_that.loginTextColor,_that.tattooPerHour,_that.piercingSingle,_that.piercingMulti,_that.shopMinimumRate,_that.enableAutomaticHolidayThemes,_that.isSpecialMessageEnabled,_that.shopHoursJson,_that.taxRate,_that.depositType,_that.depositAmount,_that.bookingBufferMinutes,_that.cancellationPolicy,_that.appointmentDurationPresetsJson,_that.specialHoursJson,_that.notificationSettingsJson,_that.backupSettingsJson,_that.linkedAccountsJson,_that.appFontSize,_that.createdAt,_that.updatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String shopName,  String logoPath,  String accentColor,  String sidebarArtworkPath,  String specialMessageText,  String loginBackgroundPath,  String loginHeadlineFontFamily,  String loginTaglineFontFamily,  String loginTextColor,  double tattooPerHour,  double piercingSingle,  double piercingMulti,  double shopMinimumRate,  bool enableAutomaticHolidayThemes,  bool isSpecialMessageEnabled,  String shopHoursJson,  double taxRate,  DepositType depositType,  double depositAmount,  int bookingBufferMinutes,  String cancellationPolicy,  String appointmentDurationPresetsJson,  String specialHoursJson,  String notificationSettingsJson,  String backupSettingsJson,  String linkedAccountsJson,  double appFontSize,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _ShopSettings() when $default != null:
return $default(_that.id,_that.shopName,_that.logoPath,_that.accentColor,_that.sidebarArtworkPath,_that.specialMessageText,_that.loginBackgroundPath,_that.loginHeadlineFontFamily,_that.loginTaglineFontFamily,_that.loginTextColor,_that.tattooPerHour,_that.piercingSingle,_that.piercingMulti,_that.shopMinimumRate,_that.enableAutomaticHolidayThemes,_that.isSpecialMessageEnabled,_that.shopHoursJson,_that.taxRate,_that.depositType,_that.depositAmount,_that.bookingBufferMinutes,_that.cancellationPolicy,_that.appointmentDurationPresetsJson,_that.specialHoursJson,_that.notificationSettingsJson,_that.backupSettingsJson,_that.linkedAccountsJson,_that.appFontSize,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShopSettings extends ShopSettings {
  const _ShopSettings({this.id = -1, this.shopName = '', this.logoPath = '', this.accentColor = '', this.sidebarArtworkPath = '', this.specialMessageText = '', this.loginBackgroundPath = '', this.loginHeadlineFontFamily = '', this.loginTaglineFontFamily = '', this.loginTextColor = '', this.tattooPerHour = 150.0, this.piercingSingle = 50.0, this.piercingMulti = 40.0, this.shopMinimumRate = 100.0, this.enableAutomaticHolidayThemes = false, this.isSpecialMessageEnabled = true, this.shopHoursJson = '', this.taxRate = 0.0, this.depositType = DepositType.percentage, this.depositAmount = 20.0, this.bookingBufferMinutes = 15, this.cancellationPolicy = '', this.appointmentDurationPresetsJson = '', this.specialHoursJson = '', this.notificationSettingsJson = '', this.backupSettingsJson = '', this.linkedAccountsJson = '', this.appFontSize = 14.0, required this.createdAt, required this.updatedAt}): super._();
  factory _ShopSettings.fromJson(Map<String, dynamic> json) => _$ShopSettingsFromJson(json);

/// Primary key (typically -1 for singleton)
@override@JsonKey() final  int id;
/// Shop name for display
@override@JsonKey() final  String shopName;
/// Path to logo image
@override@JsonKey() final  String logoPath;
/// Primary accent color (hex or named)
@override@JsonKey() final  String accentColor;
/// Path to sidebar artwork
@override@JsonKey() final  String sidebarArtworkPath;
/// Special message text for announcements
@override@JsonKey() final  String specialMessageText;
/// Path to login background image
@override@JsonKey() final  String loginBackgroundPath;
/// Login headline font family
@override@JsonKey() final  String loginHeadlineFontFamily;
/// Login tagline font family
@override@JsonKey() final  String loginTaglineFontFamily;
/// Login text color
@override@JsonKey() final  String loginTextColor;
/// Tattoo hourly rate
@override@JsonKey() final  double tattooPerHour;
/// Single piercing price
@override@JsonKey() final  double piercingSingle;
/// Multiple piercing discount price
@override@JsonKey() final  double piercingMulti;
/// Shop minimum charge
@override@JsonKey() final  double shopMinimumRate;
/// Whether to enable automatic holiday themes
@override@JsonKey() final  bool enableAutomaticHolidayThemes;
/// Whether special message is enabled
@override@JsonKey() final  bool isSpecialMessageEnabled;
/// JSON string for shop hours by day
@override@JsonKey() final  String shopHoursJson;
/// Sales tax rate (0-1, e.g., 0.08 = 8%)
@override@JsonKey() final  double taxRate;
/// Deposit type (Percentage or Fixed)
@override@JsonKey() final  DepositType depositType;
/// Deposit amount (percentage or fixed value)
@override@JsonKey() final  double depositAmount;
/// Buffer minutes between bookings
@override@JsonKey() final  int bookingBufferMinutes;
/// Cancellation policy text
@override@JsonKey() final  String cancellationPolicy;
/// JSON string for appointment duration presets
@override@JsonKey() final  String appointmentDurationPresetsJson;
/// JSON string for special hours/closures
@override@JsonKey() final  String specialHoursJson;
/// JSON string for notification settings
@override@JsonKey() final  String notificationSettingsJson;
/// JSON string for backup settings
@override@JsonKey() final  String backupSettingsJson;
/// JSON string for linked accounts
@override@JsonKey() final  String linkedAccountsJson;
/// Default app font size
@override@JsonKey() final  double appFontSize;
/// Record creation timestamp
@override final  DateTime createdAt;
/// Last update timestamp
@override final  DateTime updatedAt;

/// Create a copy of ShopSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShopSettingsCopyWith<_ShopSettings> get copyWith => __$ShopSettingsCopyWithImpl<_ShopSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShopSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShopSettings&&(identical(other.id, id) || other.id == id)&&(identical(other.shopName, shopName) || other.shopName == shopName)&&(identical(other.logoPath, logoPath) || other.logoPath == logoPath)&&(identical(other.accentColor, accentColor) || other.accentColor == accentColor)&&(identical(other.sidebarArtworkPath, sidebarArtworkPath) || other.sidebarArtworkPath == sidebarArtworkPath)&&(identical(other.specialMessageText, specialMessageText) || other.specialMessageText == specialMessageText)&&(identical(other.loginBackgroundPath, loginBackgroundPath) || other.loginBackgroundPath == loginBackgroundPath)&&(identical(other.loginHeadlineFontFamily, loginHeadlineFontFamily) || other.loginHeadlineFontFamily == loginHeadlineFontFamily)&&(identical(other.loginTaglineFontFamily, loginTaglineFontFamily) || other.loginTaglineFontFamily == loginTaglineFontFamily)&&(identical(other.loginTextColor, loginTextColor) || other.loginTextColor == loginTextColor)&&(identical(other.tattooPerHour, tattooPerHour) || other.tattooPerHour == tattooPerHour)&&(identical(other.piercingSingle, piercingSingle) || other.piercingSingle == piercingSingle)&&(identical(other.piercingMulti, piercingMulti) || other.piercingMulti == piercingMulti)&&(identical(other.shopMinimumRate, shopMinimumRate) || other.shopMinimumRate == shopMinimumRate)&&(identical(other.enableAutomaticHolidayThemes, enableAutomaticHolidayThemes) || other.enableAutomaticHolidayThemes == enableAutomaticHolidayThemes)&&(identical(other.isSpecialMessageEnabled, isSpecialMessageEnabled) || other.isSpecialMessageEnabled == isSpecialMessageEnabled)&&(identical(other.shopHoursJson, shopHoursJson) || other.shopHoursJson == shopHoursJson)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.depositType, depositType) || other.depositType == depositType)&&(identical(other.depositAmount, depositAmount) || other.depositAmount == depositAmount)&&(identical(other.bookingBufferMinutes, bookingBufferMinutes) || other.bookingBufferMinutes == bookingBufferMinutes)&&(identical(other.cancellationPolicy, cancellationPolicy) || other.cancellationPolicy == cancellationPolicy)&&(identical(other.appointmentDurationPresetsJson, appointmentDurationPresetsJson) || other.appointmentDurationPresetsJson == appointmentDurationPresetsJson)&&(identical(other.specialHoursJson, specialHoursJson) || other.specialHoursJson == specialHoursJson)&&(identical(other.notificationSettingsJson, notificationSettingsJson) || other.notificationSettingsJson == notificationSettingsJson)&&(identical(other.backupSettingsJson, backupSettingsJson) || other.backupSettingsJson == backupSettingsJson)&&(identical(other.linkedAccountsJson, linkedAccountsJson) || other.linkedAccountsJson == linkedAccountsJson)&&(identical(other.appFontSize, appFontSize) || other.appFontSize == appFontSize)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,shopName,logoPath,accentColor,sidebarArtworkPath,specialMessageText,loginBackgroundPath,loginHeadlineFontFamily,loginTaglineFontFamily,loginTextColor,tattooPerHour,piercingSingle,piercingMulti,shopMinimumRate,enableAutomaticHolidayThemes,isSpecialMessageEnabled,shopHoursJson,taxRate,depositType,depositAmount,bookingBufferMinutes,cancellationPolicy,appointmentDurationPresetsJson,specialHoursJson,notificationSettingsJson,backupSettingsJson,linkedAccountsJson,appFontSize,createdAt,updatedAt]);

@override
String toString() {
  return 'ShopSettings(id: $id, shopName: $shopName, logoPath: $logoPath, accentColor: $accentColor, sidebarArtworkPath: $sidebarArtworkPath, specialMessageText: $specialMessageText, loginBackgroundPath: $loginBackgroundPath, loginHeadlineFontFamily: $loginHeadlineFontFamily, loginTaglineFontFamily: $loginTaglineFontFamily, loginTextColor: $loginTextColor, tattooPerHour: $tattooPerHour, piercingSingle: $piercingSingle, piercingMulti: $piercingMulti, shopMinimumRate: $shopMinimumRate, enableAutomaticHolidayThemes: $enableAutomaticHolidayThemes, isSpecialMessageEnabled: $isSpecialMessageEnabled, shopHoursJson: $shopHoursJson, taxRate: $taxRate, depositType: $depositType, depositAmount: $depositAmount, bookingBufferMinutes: $bookingBufferMinutes, cancellationPolicy: $cancellationPolicy, appointmentDurationPresetsJson: $appointmentDurationPresetsJson, specialHoursJson: $specialHoursJson, notificationSettingsJson: $notificationSettingsJson, backupSettingsJson: $backupSettingsJson, linkedAccountsJson: $linkedAccountsJson, appFontSize: $appFontSize, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ShopSettingsCopyWith<$Res> implements $ShopSettingsCopyWith<$Res> {
  factory _$ShopSettingsCopyWith(_ShopSettings value, $Res Function(_ShopSettings) _then) = __$ShopSettingsCopyWithImpl;
@override @useResult
$Res call({
 int id, String shopName, String logoPath, String accentColor, String sidebarArtworkPath, String specialMessageText, String loginBackgroundPath, String loginHeadlineFontFamily, String loginTaglineFontFamily, String loginTextColor, double tattooPerHour, double piercingSingle, double piercingMulti, double shopMinimumRate, bool enableAutomaticHolidayThemes, bool isSpecialMessageEnabled, String shopHoursJson, double taxRate, DepositType depositType, double depositAmount, int bookingBufferMinutes, String cancellationPolicy, String appointmentDurationPresetsJson, String specialHoursJson, String notificationSettingsJson, String backupSettingsJson, String linkedAccountsJson, double appFontSize, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$ShopSettingsCopyWithImpl<$Res>
    implements _$ShopSettingsCopyWith<$Res> {
  __$ShopSettingsCopyWithImpl(this._self, this._then);

  final _ShopSettings _self;
  final $Res Function(_ShopSettings) _then;

/// Create a copy of ShopSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? shopName = null,Object? logoPath = null,Object? accentColor = null,Object? sidebarArtworkPath = null,Object? specialMessageText = null,Object? loginBackgroundPath = null,Object? loginHeadlineFontFamily = null,Object? loginTaglineFontFamily = null,Object? loginTextColor = null,Object? tattooPerHour = null,Object? piercingSingle = null,Object? piercingMulti = null,Object? shopMinimumRate = null,Object? enableAutomaticHolidayThemes = null,Object? isSpecialMessageEnabled = null,Object? shopHoursJson = null,Object? taxRate = null,Object? depositType = null,Object? depositAmount = null,Object? bookingBufferMinutes = null,Object? cancellationPolicy = null,Object? appointmentDurationPresetsJson = null,Object? specialHoursJson = null,Object? notificationSettingsJson = null,Object? backupSettingsJson = null,Object? linkedAccountsJson = null,Object? appFontSize = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_ShopSettings(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,shopName: null == shopName ? _self.shopName : shopName // ignore: cast_nullable_to_non_nullable
as String,logoPath: null == logoPath ? _self.logoPath : logoPath // ignore: cast_nullable_to_non_nullable
as String,accentColor: null == accentColor ? _self.accentColor : accentColor // ignore: cast_nullable_to_non_nullable
as String,sidebarArtworkPath: null == sidebarArtworkPath ? _self.sidebarArtworkPath : sidebarArtworkPath // ignore: cast_nullable_to_non_nullable
as String,specialMessageText: null == specialMessageText ? _self.specialMessageText : specialMessageText // ignore: cast_nullable_to_non_nullable
as String,loginBackgroundPath: null == loginBackgroundPath ? _self.loginBackgroundPath : loginBackgroundPath // ignore: cast_nullable_to_non_nullable
as String,loginHeadlineFontFamily: null == loginHeadlineFontFamily ? _self.loginHeadlineFontFamily : loginHeadlineFontFamily // ignore: cast_nullable_to_non_nullable
as String,loginTaglineFontFamily: null == loginTaglineFontFamily ? _self.loginTaglineFontFamily : loginTaglineFontFamily // ignore: cast_nullable_to_non_nullable
as String,loginTextColor: null == loginTextColor ? _self.loginTextColor : loginTextColor // ignore: cast_nullable_to_non_nullable
as String,tattooPerHour: null == tattooPerHour ? _self.tattooPerHour : tattooPerHour // ignore: cast_nullable_to_non_nullable
as double,piercingSingle: null == piercingSingle ? _self.piercingSingle : piercingSingle // ignore: cast_nullable_to_non_nullable
as double,piercingMulti: null == piercingMulti ? _self.piercingMulti : piercingMulti // ignore: cast_nullable_to_non_nullable
as double,shopMinimumRate: null == shopMinimumRate ? _self.shopMinimumRate : shopMinimumRate // ignore: cast_nullable_to_non_nullable
as double,enableAutomaticHolidayThemes: null == enableAutomaticHolidayThemes ? _self.enableAutomaticHolidayThemes : enableAutomaticHolidayThemes // ignore: cast_nullable_to_non_nullable
as bool,isSpecialMessageEnabled: null == isSpecialMessageEnabled ? _self.isSpecialMessageEnabled : isSpecialMessageEnabled // ignore: cast_nullable_to_non_nullable
as bool,shopHoursJson: null == shopHoursJson ? _self.shopHoursJson : shopHoursJson // ignore: cast_nullable_to_non_nullable
as String,taxRate: null == taxRate ? _self.taxRate : taxRate // ignore: cast_nullable_to_non_nullable
as double,depositType: null == depositType ? _self.depositType : depositType // ignore: cast_nullable_to_non_nullable
as DepositType,depositAmount: null == depositAmount ? _self.depositAmount : depositAmount // ignore: cast_nullable_to_non_nullable
as double,bookingBufferMinutes: null == bookingBufferMinutes ? _self.bookingBufferMinutes : bookingBufferMinutes // ignore: cast_nullable_to_non_nullable
as int,cancellationPolicy: null == cancellationPolicy ? _self.cancellationPolicy : cancellationPolicy // ignore: cast_nullable_to_non_nullable
as String,appointmentDurationPresetsJson: null == appointmentDurationPresetsJson ? _self.appointmentDurationPresetsJson : appointmentDurationPresetsJson // ignore: cast_nullable_to_non_nullable
as String,specialHoursJson: null == specialHoursJson ? _self.specialHoursJson : specialHoursJson // ignore: cast_nullable_to_non_nullable
as String,notificationSettingsJson: null == notificationSettingsJson ? _self.notificationSettingsJson : notificationSettingsJson // ignore: cast_nullable_to_non_nullable
as String,backupSettingsJson: null == backupSettingsJson ? _self.backupSettingsJson : backupSettingsJson // ignore: cast_nullable_to_non_nullable
as String,linkedAccountsJson: null == linkedAccountsJson ? _self.linkedAccountsJson : linkedAccountsJson // ignore: cast_nullable_to_non_nullable
as String,appFontSize: null == appFontSize ? _self.appFontSize : appFontSize // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$ShopDaySetting {

/// Day of week (1=Monday, 7=Sunday for DateTime convention)
 int get dayOfWeek;/// Whether shop is open this day
 bool get isOpen;/// Opening time (minutes from midnight)
 int get startTimeMinutes;/// Closing time (minutes from midnight)
 int get endTimeMinutes;
/// Create a copy of ShopDaySetting
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShopDaySettingCopyWith<ShopDaySetting> get copyWith => _$ShopDaySettingCopyWithImpl<ShopDaySetting>(this as ShopDaySetting, _$identity);

  /// Serializes this ShopDaySetting to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShopDaySetting&&(identical(other.dayOfWeek, dayOfWeek) || other.dayOfWeek == dayOfWeek)&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&(identical(other.startTimeMinutes, startTimeMinutes) || other.startTimeMinutes == startTimeMinutes)&&(identical(other.endTimeMinutes, endTimeMinutes) || other.endTimeMinutes == endTimeMinutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dayOfWeek,isOpen,startTimeMinutes,endTimeMinutes);

@override
String toString() {
  return 'ShopDaySetting(dayOfWeek: $dayOfWeek, isOpen: $isOpen, startTimeMinutes: $startTimeMinutes, endTimeMinutes: $endTimeMinutes)';
}


}

/// @nodoc
abstract mixin class $ShopDaySettingCopyWith<$Res>  {
  factory $ShopDaySettingCopyWith(ShopDaySetting value, $Res Function(ShopDaySetting) _then) = _$ShopDaySettingCopyWithImpl;
@useResult
$Res call({
 int dayOfWeek, bool isOpen, int startTimeMinutes, int endTimeMinutes
});




}
/// @nodoc
class _$ShopDaySettingCopyWithImpl<$Res>
    implements $ShopDaySettingCopyWith<$Res> {
  _$ShopDaySettingCopyWithImpl(this._self, this._then);

  final ShopDaySetting _self;
  final $Res Function(ShopDaySetting) _then;

/// Create a copy of ShopDaySetting
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dayOfWeek = null,Object? isOpen = null,Object? startTimeMinutes = null,Object? endTimeMinutes = null,}) {
  return _then(_self.copyWith(
dayOfWeek: null == dayOfWeek ? _self.dayOfWeek : dayOfWeek // ignore: cast_nullable_to_non_nullable
as int,isOpen: null == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool,startTimeMinutes: null == startTimeMinutes ? _self.startTimeMinutes : startTimeMinutes // ignore: cast_nullable_to_non_nullable
as int,endTimeMinutes: null == endTimeMinutes ? _self.endTimeMinutes : endTimeMinutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ShopDaySetting].
extension ShopDaySettingPatterns on ShopDaySetting {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShopDaySetting value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShopDaySetting() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShopDaySetting value)  $default,){
final _that = this;
switch (_that) {
case _ShopDaySetting():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShopDaySetting value)?  $default,){
final _that = this;
switch (_that) {
case _ShopDaySetting() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int dayOfWeek,  bool isOpen,  int startTimeMinutes,  int endTimeMinutes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShopDaySetting() when $default != null:
return $default(_that.dayOfWeek,_that.isOpen,_that.startTimeMinutes,_that.endTimeMinutes);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int dayOfWeek,  bool isOpen,  int startTimeMinutes,  int endTimeMinutes)  $default,) {final _that = this;
switch (_that) {
case _ShopDaySetting():
return $default(_that.dayOfWeek,_that.isOpen,_that.startTimeMinutes,_that.endTimeMinutes);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int dayOfWeek,  bool isOpen,  int startTimeMinutes,  int endTimeMinutes)?  $default,) {final _that = this;
switch (_that) {
case _ShopDaySetting() when $default != null:
return $default(_that.dayOfWeek,_that.isOpen,_that.startTimeMinutes,_that.endTimeMinutes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShopDaySetting extends ShopDaySetting {
  const _ShopDaySetting({required this.dayOfWeek, this.isOpen = true, this.startTimeMinutes = 540, this.endTimeMinutes = 1080}): super._();
  factory _ShopDaySetting.fromJson(Map<String, dynamic> json) => _$ShopDaySettingFromJson(json);

/// Day of week (1=Monday, 7=Sunday for DateTime convention)
@override final  int dayOfWeek;
/// Whether shop is open this day
@override@JsonKey() final  bool isOpen;
/// Opening time (minutes from midnight)
@override@JsonKey() final  int startTimeMinutes;
/// Closing time (minutes from midnight)
@override@JsonKey() final  int endTimeMinutes;

/// Create a copy of ShopDaySetting
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShopDaySettingCopyWith<_ShopDaySetting> get copyWith => __$ShopDaySettingCopyWithImpl<_ShopDaySetting>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShopDaySettingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShopDaySetting&&(identical(other.dayOfWeek, dayOfWeek) || other.dayOfWeek == dayOfWeek)&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&(identical(other.startTimeMinutes, startTimeMinutes) || other.startTimeMinutes == startTimeMinutes)&&(identical(other.endTimeMinutes, endTimeMinutes) || other.endTimeMinutes == endTimeMinutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dayOfWeek,isOpen,startTimeMinutes,endTimeMinutes);

@override
String toString() {
  return 'ShopDaySetting(dayOfWeek: $dayOfWeek, isOpen: $isOpen, startTimeMinutes: $startTimeMinutes, endTimeMinutes: $endTimeMinutes)';
}


}

/// @nodoc
abstract mixin class _$ShopDaySettingCopyWith<$Res> implements $ShopDaySettingCopyWith<$Res> {
  factory _$ShopDaySettingCopyWith(_ShopDaySetting value, $Res Function(_ShopDaySetting) _then) = __$ShopDaySettingCopyWithImpl;
@override @useResult
$Res call({
 int dayOfWeek, bool isOpen, int startTimeMinutes, int endTimeMinutes
});




}
/// @nodoc
class __$ShopDaySettingCopyWithImpl<$Res>
    implements _$ShopDaySettingCopyWith<$Res> {
  __$ShopDaySettingCopyWithImpl(this._self, this._then);

  final _ShopDaySetting _self;
  final $Res Function(_ShopDaySetting) _then;

/// Create a copy of ShopDaySetting
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dayOfWeek = null,Object? isOpen = null,Object? startTimeMinutes = null,Object? endTimeMinutes = null,}) {
  return _then(_ShopDaySetting(
dayOfWeek: null == dayOfWeek ? _self.dayOfWeek : dayOfWeek // ignore: cast_nullable_to_non_nullable
as int,isOpen: null == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool,startTimeMinutes: null == startTimeMinutes ? _self.startTimeMinutes : startTimeMinutes // ignore: cast_nullable_to_non_nullable
as int,endTimeMinutes: null == endTimeMinutes ? _self.endTimeMinutes : endTimeMinutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
