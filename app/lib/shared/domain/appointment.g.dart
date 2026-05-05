// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Appointment _$AppointmentFromJson(Map<String, dynamic> json) => _Appointment(
  id: (json['id'] as num).toInt(),
  syncId: json['syncId'] as String,
  clientId: (json['clientId'] as num).toInt(),
  userId: (json['userId'] as num).toInt(),
  clientName: json['clientName'] as String? ?? '',
  dateTime: DateTime.parse(json['dateTime'] as String),
  durationMinutes: (json['durationMinutes'] as num).toInt(),
  serviceType: json['serviceType'] as String? ?? 'Tattoo',
  serviceCategory: json['serviceCategory'] as String? ?? 'General',
  priceType: json['priceType'] as String? ?? 'Hourly',
  priceCharged: (json['priceCharged'] as num?)?.toDouble() ?? 0.0,
  quotedPrice: (json['quotedPrice'] as num?)?.toDouble(),
  finalPrice: (json['finalPrice'] as num?)?.toDouble(),
  notes: json['notes'] as String?,
  photoPath: json['photoPath'] as String?,
  color: json['color'] as String? ?? '',
  status: json['status'] as String? ?? 'Scheduled',
  isBlockOff: json['isBlockOff'] as bool? ?? false,
  lastModifiedUtc: DateTime.parse(json['lastModifiedUtc'] as String),
  lastModifiedBy: json['lastModifiedBy'] as String? ?? '',
  isDeleted: json['isDeleted'] as bool? ?? false,
);

Map<String, dynamic> _$AppointmentToJson(_Appointment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'syncId': instance.syncId,
      'clientId': instance.clientId,
      'userId': instance.userId,
      'clientName': instance.clientName,
      'dateTime': instance.dateTime.toIso8601String(),
      'durationMinutes': instance.durationMinutes,
      'serviceType': instance.serviceType,
      'serviceCategory': instance.serviceCategory,
      'priceType': instance.priceType,
      'priceCharged': instance.priceCharged,
      'quotedPrice': instance.quotedPrice,
      'finalPrice': instance.finalPrice,
      'notes': instance.notes,
      'photoPath': instance.photoPath,
      'color': instance.color,
      'status': instance.status,
      'isBlockOff': instance.isBlockOff,
      'lastModifiedUtc': instance.lastModifiedUtc.toIso8601String(),
      'lastModifiedBy': instance.lastModifiedBy,
      'isDeleted': instance.isDeleted,
    };
