// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ShopSettings _$ShopSettingsFromJson(
  Map<String, dynamic> json,
) => _ShopSettings(
  id: (json['id'] as num?)?.toInt() ?? -1,
  shopName: json['shopName'] as String? ?? '',
  logoPath: json['logoPath'] as String? ?? '',
  accentColor: json['accentColor'] as String? ?? '',
  sidebarArtworkPath: json['sidebarArtworkPath'] as String? ?? '',
  specialMessageText: json['specialMessageText'] as String? ?? '',
  loginBackgroundPath: json['loginBackgroundPath'] as String? ?? '',
  loginHeadlineFontFamily: json['loginHeadlineFontFamily'] as String? ?? '',
  loginTaglineFontFamily: json['loginTaglineFontFamily'] as String? ?? '',
  loginTextColor: json['loginTextColor'] as String? ?? '',
  tattooPerHour: (json['tattooPerHour'] as num?)?.toDouble() ?? 150.0,
  piercingSingle: (json['piercingSingle'] as num?)?.toDouble() ?? 50.0,
  piercingMulti: (json['piercingMulti'] as num?)?.toDouble() ?? 40.0,
  shopMinimumRate: (json['shopMinimumRate'] as num?)?.toDouble() ?? 100.0,
  enableAutomaticHolidayThemes:
      json['enableAutomaticHolidayThemes'] as bool? ?? false,
  isSpecialMessageEnabled: json['isSpecialMessageEnabled'] as bool? ?? true,
  shopHoursJson: json['shopHoursJson'] as String? ?? '',
  taxRate: (json['taxRate'] as num?)?.toDouble() ?? 0.0,
  depositType:
      $enumDecodeNullable(_$DepositTypeEnumMap, json['depositType']) ??
      DepositType.percentage,
  depositAmount: (json['depositAmount'] as num?)?.toDouble() ?? 20.0,
  bookingBufferMinutes: (json['bookingBufferMinutes'] as num?)?.toInt() ?? 15,
  cancellationPolicy: json['cancellationPolicy'] as String? ?? '',
  appointmentDurationPresetsJson:
      json['appointmentDurationPresetsJson'] as String? ?? '',
  specialHoursJson: json['specialHoursJson'] as String? ?? '',
  notificationSettingsJson: json['notificationSettingsJson'] as String? ?? '',
  backupSettingsJson: json['backupSettingsJson'] as String? ?? '',
  linkedAccountsJson: json['linkedAccountsJson'] as String? ?? '',
  appFontSize: (json['appFontSize'] as num?)?.toDouble() ?? 14.0,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$ShopSettingsToJson(_ShopSettings instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shopName': instance.shopName,
      'logoPath': instance.logoPath,
      'accentColor': instance.accentColor,
      'sidebarArtworkPath': instance.sidebarArtworkPath,
      'specialMessageText': instance.specialMessageText,
      'loginBackgroundPath': instance.loginBackgroundPath,
      'loginHeadlineFontFamily': instance.loginHeadlineFontFamily,
      'loginTaglineFontFamily': instance.loginTaglineFontFamily,
      'loginTextColor': instance.loginTextColor,
      'tattooPerHour': instance.tattooPerHour,
      'piercingSingle': instance.piercingSingle,
      'piercingMulti': instance.piercingMulti,
      'shopMinimumRate': instance.shopMinimumRate,
      'enableAutomaticHolidayThemes': instance.enableAutomaticHolidayThemes,
      'isSpecialMessageEnabled': instance.isSpecialMessageEnabled,
      'shopHoursJson': instance.shopHoursJson,
      'taxRate': instance.taxRate,
      'depositType': _$DepositTypeEnumMap[instance.depositType]!,
      'depositAmount': instance.depositAmount,
      'bookingBufferMinutes': instance.bookingBufferMinutes,
      'cancellationPolicy': instance.cancellationPolicy,
      'appointmentDurationPresetsJson': instance.appointmentDurationPresetsJson,
      'specialHoursJson': instance.specialHoursJson,
      'notificationSettingsJson': instance.notificationSettingsJson,
      'backupSettingsJson': instance.backupSettingsJson,
      'linkedAccountsJson': instance.linkedAccountsJson,
      'appFontSize': instance.appFontSize,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$DepositTypeEnumMap = {
  DepositType.percentage: 'percentage',
  DepositType.fixed: 'fixed',
};

_ShopDaySetting _$ShopDaySettingFromJson(Map<String, dynamic> json) =>
    _ShopDaySetting(
      dayOfWeek: (json['dayOfWeek'] as num).toInt(),
      isOpen: json['isOpen'] as bool? ?? true,
      startTimeMinutes: (json['startTimeMinutes'] as num?)?.toInt() ?? 540,
      endTimeMinutes: (json['endTimeMinutes'] as num?)?.toInt() ?? 1080,
    );

Map<String, dynamic> _$ShopDaySettingToJson(_ShopDaySetting instance) =>
    <String, dynamic>{
      'dayOfWeek': instance.dayOfWeek,
      'isOpen': instance.isOpen,
      'startTimeMinutes': instance.startTimeMinutes,
      'endTimeMinutes': instance.endTimeMinutes,
    };
