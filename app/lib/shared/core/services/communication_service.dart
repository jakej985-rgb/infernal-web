import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../cache/id_mapper.dart';
import '../../data/org_provider.dart';
import '../../domain/communication.dart';
import 'firestore_helpers.dart';

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

  CollectionReference<Map<String, dynamic>> get _communicationsRef =>
      orgDoc(_orgId).collection('communications');

  Stream<List<CommunicationRitual>> watchCommunications() {
    return _communicationsRef
        .where('isDeleted', isEqualTo: false)
        .snapshots()
        .asyncMap((snapshot) async {
          final list = <CommunicationRitual>[];
          for (final doc in snapshot.docs) {
            list.add(await _mapDocToDomain(doc, _idMapper));
          }
          return list;
        });
  }

  Future<void> sendCommunication(CommunicationRitual ritual) async {
    final docRef = _communicationsRef.doc();
    final uuid = docRef.id;

    String? clientUuid;
    if (ritual.clientId != null) {
      clientUuid = _idMapper.getUuid('client', ritual.clientId!);
    }

    await docRef.set({
      'client_id': clientUuid,
      'client_name': ritual.clientName,
      'type': ritual.type,
      'direction': ritual.direction,
      'content': ritual.content,
      'sentAt': FieldValue.serverTimestamp(),
      'status': ritual.status,
      'lastModifiedBy': ritual.lastModifiedBy,
      'isDeleted': false,
    });

    await _idMapper.registerUuid('communication', uuid);
  }

  Future<void> deleteCommunication(int id) async {
    final uuid = _idMapper.getUuid('communication', id);
    if (uuid == null) throw Exception('Cannot resolve ID for communication.');

    await _communicationsRef.doc(uuid).update({
      'isDeleted': true,
      'sentAt': FieldValue.serverTimestamp(),
    });
  }

  Future<CommunicationRitual> _mapDocToDomain(
    DocumentSnapshot<Map<String, dynamic>> doc,
    IdMapper idMapper,
  ) async {
    final uuid = doc.id;
    final id = await idMapper.registerUuid('communication', uuid);

    final data = doc.data() ?? {};
    final clientUuid = data['client_id'] as String?;
    int? clientId;
    if (clientUuid != null && clientUuid.isNotEmpty) {
      clientId = await idMapper.registerUuid('client', clientUuid);
    }

    final clientName = data['client_name'] as String? ?? '';
    final type = data['type'] as String? ?? 'SMS';
    final direction = data['direction'] as String? ?? 'OUTBOUND';
    final content = data['content'] as String? ?? '';

    final sentAtTimestamp = data['sentAt'] as Timestamp?;
    final sentAt = sentAtTimestamp?.toDate() ?? DateTime.now();

    final status = data['status'] as String? ?? 'SENT';
    final lastModifiedBy = data['lastModifiedBy'] as String? ?? 'App';
    final isDeleted = data['isDeleted'] as bool? ?? false;

    return CommunicationRitual(
      id: id,
      syncId: uuid,
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
