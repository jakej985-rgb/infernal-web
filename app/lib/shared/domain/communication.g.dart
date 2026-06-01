// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'communication.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CommunicationRitual _$CommunicationRitualFromJson(Map<String, dynamic> json) =>
    _CommunicationRitual(
      id: (json['id'] as num).toInt(),
      syncId: json['syncId'] as String? ?? '',
      clientId: (json['clientId'] as num?)?.toInt(),
      clientName: json['clientName'] as String,
      type: json['type'] as String,
      direction: json['direction'] as String,
      content: json['content'] as String,
      sentAt: DateTime.parse(json['sentAt'] as String),
      status: json['status'] as String? ?? 'SENT',
      lastModifiedUtc: json['lastModifiedUtc'] == null
          ? null
          : DateTime.parse(json['lastModifiedUtc'] as String),
      lastModifiedBy: json['lastModifiedBy'] as String? ?? '',
      isDeleted: json['isDeleted'] as bool? ?? false,
    );

Map<String, dynamic> _$CommunicationRitualToJson(
  _CommunicationRitual instance,
) => <String, dynamic>{
  'id': instance.id,
  'syncId': instance.syncId,
  'clientId': instance.clientId,
  'clientName': instance.clientName,
  'type': instance.type,
  'direction': instance.direction,
  'content': instance.content,
  'sentAt': instance.sentAt.toIso8601String(),
  'status': instance.status,
  'lastModifiedUtc': instance.lastModifiedUtc?.toIso8601String(),
  'lastModifiedBy': instance.lastModifiedBy,
  'isDeleted': instance.isDeleted,
};
