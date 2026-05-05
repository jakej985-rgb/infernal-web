// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Document _$DocumentFromJson(Map<String, dynamic> json) => _Document(
  id: (json['id'] as num).toInt(),
  syncId: json['syncId'] as String,
  uploadedByUserId: (json['uploadedByUserId'] as num).toInt(),
  clientId: (json['clientId'] as num).toInt(),
  title: json['title'] as String,
  filePath: json['filePath'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  lastModifiedUtc: DateTime.parse(json['lastModifiedUtc'] as String),
  lastModifiedBy: json['lastModifiedBy'] as String? ?? '',
  isDeleted: json['isDeleted'] as bool? ?? false,
);

Map<String, dynamic> _$DocumentToJson(_Document instance) => <String, dynamic>{
  'id': instance.id,
  'syncId': instance.syncId,
  'uploadedByUserId': instance.uploadedByUserId,
  'clientId': instance.clientId,
  'title': instance.title,
  'filePath': instance.filePath,
  'createdAt': instance.createdAt.toIso8601String(),
  'lastModifiedUtc': instance.lastModifiedUtc.toIso8601String(),
  'lastModifiedBy': instance.lastModifiedBy,
  'isDeleted': instance.isDeleted,
};
