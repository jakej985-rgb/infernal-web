import 'package:freezed_annotation/freezed_annotation.dart';

part 'communication.freezed.dart';
part 'communication.g.dart';

@freezed
abstract class CommunicationRitual with _$CommunicationRitual {

  const factory CommunicationRitual({
    required int id,
    @Default('') String syncId,
    required int? clientId,
    required String clientName,
    required String type, // SMS, Email, Ritual
    required String direction, // INBOUND, OUTBOUND
    required String content,
    required DateTime sentAt,
    @Default('SENT') String status, // PENDING, SENT, FAILED
    DateTime? lastModifiedUtc,
    @Default('') String lastModifiedBy,
    @Default(false) bool isDeleted,
  }) = _CommunicationRitual;

  factory CommunicationRitual.fromJson(Map<String, dynamic> json) => _$CommunicationRitualFromJson(json);
}
