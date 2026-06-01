// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientSyncDTO _$ClientSyncDTOFromJson(Map<String, dynamic> json) =>
    ClientSyncDTO(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      isDeleted: json['is_deleted'] as bool,
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$ClientSyncDTOToJson(ClientSyncDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'is_deleted': instance.isDeleted,
      'updated_at': instance.updatedAt.toIso8601String(),
    };

ApptSyncDTO _$ApptSyncDTOFromJson(Map<String, dynamic> json) => ApptSyncDTO(
  id: json['id'] as String,
  clientId: json['client_id'] as String,
  title: json['title'] as String,
  notes: json['notes'] as String,
  startTime: DateTime.parse(json['start_time'] as String),
  endTime: DateTime.parse(json['end_time'] as String),
  isDeleted: json['is_deleted'] as bool,
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$ApptSyncDTOToJson(ApptSyncDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'client_id': instance.clientId,
      'title': instance.title,
      'notes': instance.notes,
      'start_time': instance.startTime.toIso8601String(),
      'end_time': instance.endTime.toIso8601String(),
      'is_deleted': instance.isDeleted,
      'updated_at': instance.updatedAt.toIso8601String(),
    };

InvSyncDTO _$InvSyncDTOFromJson(Map<String, dynamic> json) => InvSyncDTO(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  quantity: (json['quantity'] as num).toInt(),
  lowStockThreshold: (json['low_stock_threshold'] as num).toInt(),
  category: json['category'] as String,
  unit: json['unit'] as String,
  supplier: json['supplier'] as String?,
  lastOrderedAt: json['last_ordered_at'] == null
      ? null
      : DateTime.parse(json['last_ordered_at'] as String),
  isDeleted: json['is_deleted'] as bool,
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$InvSyncDTOToJson(InvSyncDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'quantity': instance.quantity,
      'low_stock_threshold': instance.lowStockThreshold,
      'category': instance.category,
      'unit': instance.unit,
      'supplier': instance.supplier,
      'last_ordered_at': instance.lastOrderedAt?.toIso8601String(),
      'is_deleted': instance.isDeleted,
      'updated_at': instance.updatedAt.toIso8601String(),
    };

DocSyncDTO _$DocSyncDTOFromJson(Map<String, dynamic> json) => DocSyncDTO(
  id: json['id'] as String,
  clientId: json['client_id'] as String?,
  name: json['name'] as String,
  filePath: json['file_path'] as String,
  fileSize: (json['file_size'] as num).toInt(),
  isDeleted: json['is_deleted'] as bool,
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$DocSyncDTOToJson(DocSyncDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'client_id': instance.clientId,
      'name': instance.name,
      'file_path': instance.filePath,
      'file_size': instance.fileSize,
      'is_deleted': instance.isDeleted,
      'updated_at': instance.updatedAt.toIso8601String(),
    };

CommSyncDTO _$CommSyncDTOFromJson(Map<String, dynamic> json) => CommSyncDTO(
  id: json['id'] as String,
  clientId: json['client_id'] as String,
  type: json['type'] as String,
  content: json['content'] as String,
  isDeleted: json['is_deleted'] as bool,
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$CommSyncDTOToJson(CommSyncDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'client_id': instance.clientId,
      'type': instance.type,
      'content': instance.content,
      'is_deleted': instance.isDeleted,
      'updated_at': instance.updatedAt.toIso8601String(),
    };

SyncRequestPayload _$SyncRequestPayloadFromJson(Map<String, dynamic> json) =>
    SyncRequestPayload(
      lastSyncTimestamp: DateTime.parse(json['last_sync_timestamp'] as String),
      clients: (json['clients'] as List<dynamic>)
          .map((e) => ClientSyncDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      appointments: (json['appointments'] as List<dynamic>)
          .map((e) => ApptSyncDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      inventory: (json['inventory'] as List<dynamic>)
          .map((e) => InvSyncDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      documents: (json['documents'] as List<dynamic>)
          .map((e) => DocSyncDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      communications: (json['communications'] as List<dynamic>)
          .map((e) => CommSyncDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SyncRequestPayloadToJson(SyncRequestPayload instance) =>
    <String, dynamic>{
      'last_sync_timestamp': instance.lastSyncTimestamp.toIso8601String(),
      'clients': instance.clients,
      'appointments': instance.appointments,
      'inventory': instance.inventory,
      'documents': instance.documents,
      'communications': instance.communications,
    };

SyncResponsePayload _$SyncResponsePayloadFromJson(Map<String, dynamic> json) =>
    SyncResponsePayload(
      currentTimestamp: DateTime.parse(json['current_timestamp'] as String),
      clients: (json['clients'] as List<dynamic>)
          .map((e) => ClientSyncDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      appointments: (json['appointments'] as List<dynamic>)
          .map((e) => ApptSyncDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      inventory: (json['inventory'] as List<dynamic>)
          .map((e) => InvSyncDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      documents: (json['documents'] as List<dynamic>)
          .map((e) => DocSyncDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      communications: (json['communications'] as List<dynamic>)
          .map((e) => CommSyncDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SyncResponsePayloadToJson(
  SyncResponsePayload instance,
) => <String, dynamic>{
  'current_timestamp': instance.currentTimestamp.toIso8601String(),
  'clients': instance.clients,
  'appointments': instance.appointments,
  'inventory': instance.inventory,
  'documents': instance.documents,
  'communications': instance.communications,
};
