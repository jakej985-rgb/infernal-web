// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  id: (json['id'] as num).toInt(),
  username: json['username'] as String,
  displayName: json['displayName'] as String? ?? '',
  passwordHash: json['passwordHash'] as String? ?? '',
  role: $enumDecodeNullable(_$UserRoleEnumMap, json['role']) ?? UserRole.artist,
  themeKey: json['themeKey'] as String? ?? 'InfernalNeon',
  avatarPath: json['avatarPath'] as String? ?? '',
  hourlyRate: (json['hourlyRate'] as num?)?.toDouble() ?? 150.0,
  speedFactor: (json['speedFactor'] as num?)?.toDouble() ?? 1.0,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  lastLoginAt: json['lastLoginAt'] == null
      ? null
      : DateTime.parse(json['lastLoginAt'] as String),
  isActive: json['isActive'] as bool? ?? true,
  isDeleted: json['isDeleted'] as bool? ?? false,
  deletedAt: json['deletedAt'] == null
      ? null
      : DateTime.parse(json['deletedAt'] as String),
  department: json['department'] as String? ?? '',
  commissionRate: (json['commissionRate'] as num?)?.toDouble() ?? 0.0,
  fontSize: (json['fontSize'] as num?)?.toInt() ?? 14,
  keyboardShortcutsJson: json['keyboardShortcutsJson'] as String? ?? '',
  permissionsJson: json['permissionsJson'] as String? ?? '',
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'displayName': instance.displayName,
  'passwordHash': instance.passwordHash,
  'role': _$UserRoleEnumMap[instance.role]!,
  'themeKey': instance.themeKey,
  'avatarPath': instance.avatarPath,
  'hourlyRate': instance.hourlyRate,
  'speedFactor': instance.speedFactor,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'lastLoginAt': instance.lastLoginAt?.toIso8601String(),
  'isActive': instance.isActive,
  'isDeleted': instance.isDeleted,
  'deletedAt': instance.deletedAt?.toIso8601String(),
  'department': instance.department,
  'commissionRate': instance.commissionRate,
  'fontSize': instance.fontSize,
  'keyboardShortcutsJson': instance.keyboardShortcutsJson,
  'permissionsJson': instance.permissionsJson,
};

const _$UserRoleEnumMap = {UserRole.admin: 'admin', UserRole.artist: 'artist'};
