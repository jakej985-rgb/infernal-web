import 'package:json_annotation/json_annotation.dart';

part 'dtos.g.dart';

@JsonSerializable()
class ClientSyncDTO {
  final String id; // syncId
  final String name;
  final String email;
  final String phone;
  @JsonKey(name: 'is_deleted')
  final bool isDeleted;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  ClientSyncDTO({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.isDeleted,
    required this.updatedAt,
  });

  factory ClientSyncDTO.fromJson(Map<String, dynamic> json) => _$ClientSyncDTOFromJson(json);
  Map<String, dynamic> toJson() => _$ClientSyncDTOToJson(this);
}

@JsonSerializable()
class ApptSyncDTO {
  final String id; // syncId
  @JsonKey(name: 'client_id')
  final String clientId; // Client UUID
  final String title;
  final String notes;
  @JsonKey(name: 'start_time')
  final DateTime startTime;
  @JsonKey(name: 'end_time')
  final DateTime endTime;
  @JsonKey(name: 'is_deleted')
  final bool isDeleted;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  ApptSyncDTO({
    required this.id,
    required this.clientId,
    required this.title,
    required this.notes,
    required this.startTime,
    required this.endTime,
    required this.isDeleted,
    required this.updatedAt,
  });

  factory ApptSyncDTO.fromJson(Map<String, dynamic> json) => _$ApptSyncDTOFromJson(json);
  Map<String, dynamic> toJson() => _$ApptSyncDTOToJson(this);
}

@JsonSerializable()
class InvSyncDTO {
  final String id; // syncId
  final String name;
  final String description;
  final int quantity;
  @JsonKey(name: 'low_stock_threshold')
  final int lowStockThreshold;
  final String category;
  final String unit;
  final String? supplier;
  @JsonKey(name: 'last_ordered_at')
  final DateTime? lastOrderedAt;
  @JsonKey(name: 'is_deleted')
  final bool isDeleted;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  InvSyncDTO({
    required this.id,
    required this.name,
    required this.description,
    required this.quantity,
    required this.lowStockThreshold,
    required this.category,
    required this.unit,
    this.supplier,
    this.lastOrderedAt,
    required this.isDeleted,
    required this.updatedAt,
  });

  factory InvSyncDTO.fromJson(Map<String, dynamic> json) => _$InvSyncDTOFromJson(json);
  Map<String, dynamic> toJson() => _$InvSyncDTOToJson(this);
}

@JsonSerializable()
class DocSyncDTO {
  final String id; // syncId
  @JsonKey(name: 'client_id')
  final String? clientId; // Client UUID
  final String name;
  @JsonKey(name: 'file_path')
  final String filePath;
  @JsonKey(name: 'file_size')
  final int fileSize;
  @JsonKey(name: 'is_deleted')
  final bool isDeleted;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  DocSyncDTO({
    required this.id,
    this.clientId,
    required this.name,
    required this.filePath,
    required this.fileSize,
    required this.isDeleted,
    required this.updatedAt,
  });

  factory DocSyncDTO.fromJson(Map<String, dynamic> json) => _$DocSyncDTOFromJson(json);
  Map<String, dynamic> toJson() => _$DocSyncDTOToJson(this);
}

@JsonSerializable()
class CommSyncDTO {
  final String id; // syncId
  @JsonKey(name: 'client_id')
  final String clientId; // Client UUID
  final String type;
  final String content;
  @JsonKey(name: 'is_deleted')
  final bool isDeleted;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  CommSyncDTO({
    required this.id,
    required this.clientId,
    required this.type,
    required this.content,
    required this.isDeleted,
    required this.updatedAt,
  });

  factory CommSyncDTO.fromJson(Map<String, dynamic> json) => _$CommSyncDTOFromJson(json);
  Map<String, dynamic> toJson() => _$CommSyncDTOToJson(this);
}

@JsonSerializable()
class SyncRequestPayload {
  @JsonKey(name: 'last_sync_timestamp')
  final DateTime lastSyncTimestamp;
  final List<ClientSyncDTO> clients;
  final List<ApptSyncDTO> appointments;
  final List<InvSyncDTO> inventory;
  final List<DocSyncDTO> documents;
  final List<CommSyncDTO> communications;

  SyncRequestPayload({
    required this.lastSyncTimestamp,
    required this.clients,
    required this.appointments,
    required this.inventory,
    required this.documents,
    required this.communications,
  });

  factory SyncRequestPayload.fromJson(Map<String, dynamic> json) => _$SyncRequestPayloadFromJson(json);
  Map<String, dynamic> toJson() => _$SyncRequestPayloadToJson(this);
}

@JsonSerializable()
class SyncResponsePayload {
  @JsonKey(name: 'current_timestamp')
  final DateTime currentTimestamp;
  final List<ClientSyncDTO> clients;
  final List<ApptSyncDTO> appointments;
  final List<InvSyncDTO> inventory;
  final List<DocSyncDTO> documents;
  final List<CommSyncDTO> communications;

  SyncResponsePayload({
    required this.currentTimestamp,
    required this.clients,
    required this.appointments,
    required this.inventory,
    required this.documents,
    required this.communications,
  });

  factory SyncResponsePayload.fromJson(Map<String, dynamic> json) => _$SyncResponsePayloadFromJson(json);
  Map<String, dynamic> toJson() => _$SyncResponsePayloadToJson(this);
}
