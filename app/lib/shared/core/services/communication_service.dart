import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart' as uuid;
import '../../cache/id_mapper.dart';
import '../../data/org_provider.dart';
import '../../domain/communication.dart';

part 'communication_service.g.dart';

@riverpod
CommunicationService communicationService(Ref ref) {
  return CommunicationService(ref);
}

class CommunicationService {
  final Ref _ref;
  CommunicationService(this._ref);

  IdMapper get _idMapper => _ref.read(idMapperProvider);
  String get _orgId => _ref.read(orgIdProvider);

  Stream<List<CommunicationRitual>> watchCommunications() {
    final client = sb.Supabase.instance.client;
    return client
        .from('communications')
        .stream(primaryKey: ['id'])
        .eq('org_id', _orgId)
        .asyncMap((data) async {
          final list = <CommunicationRitual>[];
          for (final row in data) {
            if (row['is_deleted'] == true) continue;
            list.add(await _mapRowToDomain(row, _idMapper));
          }
          return list;
        });
  }

  Future<void> sendCommunication(CommunicationRitual ritual) async {
    final uuidVal = const uuid.Uuid().v4();
    final client = sb.Supabase.instance.client;

    String? clientUuid;
    if (ritual.clientId != null) {
      clientUuid = _idMapper.getUuid('client', ritual.clientId!);
    }

    await client.from('communications').insert({
      'id': uuidVal,
      'org_id': _orgId,
      'client_id': clientUuid,
      'client_name': ritual.clientName,
      'type': ritual.type,
      'direction': ritual.direction,
      'content': ritual.content,
      'sent_at': DateTime.now().toUtc().toIso8601String(),
      'status': ritual.status,
      'last_modified_by': ritual.lastModifiedBy,
      'is_deleted': false,
    });

    await _idMapper.registerUuid('communication', uuidVal);
  }

  Future<void> deleteCommunication(int id) async {
    final uuidVal = _idMapper.getUuid('communication', id);
    if (uuidVal == null) throw Exception('Cannot resolve ID for communication.');

    final client = sb.Supabase.instance.client;
    await client.from('communications').update({
      'is_deleted': true,
      'sent_at': DateTime.now().toUtc().toIso8601String(),
    }).eq('id', uuidVal);
  }

  Future<CommunicationRitual> _mapRowToDomain(
    Map<String, dynamic> row,
    IdMapper idMapper,
  ) async {
    final uuidVal = row['id'] as String;
    final id = await idMapper.registerUuid('communication', uuidVal);

    final clientUuid = row['client_id'] as String?;
    int? clientId;
    if (clientUuid != null && clientUuid.isNotEmpty) {
      clientId = await idMapper.registerUuid('client', clientUuid);
    }

    final clientName = row['client_name'] as String? ?? '';
    final type = row['type'] as String? ?? 'SMS';
    final direction = row['direction'] as String? ?? 'OUTBOUND';
    final content = row['content'] as String? ?? '';

    final sentAtStr = row['sent_at'] as String;
    final sentAt = DateTime.parse(sentAtStr).toLocal();

    final status = row['status'] as String? ?? 'SENT';
    final lastModifiedBy = row['last_modified_by'] as String? ?? 'App';
    final isDeleted = row['is_deleted'] as bool? ?? false;

    return CommunicationRitual(
      id: id,
      syncId: uuidVal,
      clientId: clientId,
      clientName: clientName,
      type: type,
      direction: direction,
      content: content,
      sentAt: sentAt,
      status: status,
      lastModifiedUtc: sentAt.toUtc(),
      lastModifiedBy: lastModifiedBy,
      isDeleted: isDeleted,
    );
  }
}
