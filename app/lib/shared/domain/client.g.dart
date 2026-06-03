// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Client _$ClientFromJson(Map<String, dynamic> json) => _Client(
  id: (json['id'] as num).toInt(),
  syncId: json['syncId'] as String,
  firstName: json['firstName'] as String,
  middleName: json['middleName'] as String? ?? '',
  lastName: json['lastName'] as String,
  phone: json['phone'] as String? ?? '',
  email: json['email'] as String? ?? '',
  notes: json['notes'] as String? ?? '',
  visits: (json['visits'] as num?)?.toInt() ?? 0,
  photoPath: json['photoPath'] as String? ?? '',
  status:
      $enumDecodeNullable(_$ClientStatusEnumMap, json['status']) ??
      ClientStatus.bound,
  createdAt: DateTime.parse(_readCreatedAt(json, 'createdAt') as String),
  lastModifiedUtc: DateTime.parse(json['lastModifiedUtc'] as String),
  lastModifiedBy: json['lastModifiedBy'] as String? ?? '',
  isDeleted: json['isDeleted'] as bool? ?? false,
);

Map<String, dynamic> _$ClientToJson(_Client instance) => <String, dynamic>{
  'id': instance.id,
  'syncId': instance.syncId,
  'firstName': instance.firstName,
  'middleName': instance.middleName,
  'lastName': instance.lastName,
  'phone': instance.phone,
  'email': instance.email,
  'notes': instance.notes,
  'visits': instance.visits,
  'photoPath': instance.photoPath,
  'status': _$ClientStatusEnumMap[instance.status]!,
  'createdAt': instance.createdAt.toIso8601String(),
  'lastModifiedUtc': instance.lastModifiedUtc.toIso8601String(),
  'lastModifiedBy': instance.lastModifiedBy,
  'isDeleted': instance.isDeleted,
};

const _$ClientStatusEnumMap = {
  ClientStatus.bound: 'bound',
  ClientStatus.freshSoul: 'freshSoul',
  ClientStatus.highValue: 'highValue',
  ClientStatus.void_: 'void_',
};
