// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'communication.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CommunicationRitual _$CommunicationRitualFromJson(Map<String, dynamic> json) =>
    _CommunicationRitual(
      id: (json['id'] as num).toInt(),
      clientId: (json['clientId'] as num?)?.toInt(),
      clientName: json['clientName'] as String,
      type: json['type'] as String,
      direction: json['direction'] as String,
      content: json['content'] as String,
      sentAt: DateTime.parse(json['sentAt'] as String),
      status: json['status'] as String? ?? 'SENT',
    );

Map<String, dynamic> _$CommunicationRitualToJson(
  _CommunicationRitual instance,
) => <String, dynamic>{
  'id': instance.id,
  'clientId': instance.clientId,
  'clientName': instance.clientName,
  'type': instance.type,
  'direction': instance.direction,
  'content': instance.content,
  'sentAt': instance.sentAt.toIso8601String(),
  'status': instance.status,
};
