import 'dart:async';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared/cache/id_mapper.dart';
import '../../../shared/util/api_client.dart';
import '../../../../shared/domain/communication.dart';

part 'communications_provider.g.dart';

final _communicationsController = StreamController<List<CommunicationRitual>>.broadcast();
Future<List<CommunicationRitual>>? _pendingCommsFetch;

Future<List<CommunicationRitual>> _fetchCommunications(Ref ref) async {
  final dio = ref.read(apiClientProvider);
  final idMapper = ref.read(idMapperProvider);
  try {
    final response = await dio.get('/communications');
    final rawList = response.data as List;
    final rituals = <CommunicationRitual>[];
    for (final item in rawList) {
      final map = item as Map<String, dynamic>;
      final uuid = map['id'] as String;
      final id = await idMapper.registerUuid('communication', uuid);
      final clientUuid = map['client_id'] as String? ?? '';
      
      int? clientId;
      if (clientUuid.isNotEmpty) {
        clientId = await idMapper.registerUuid('client', clientUuid);
      }
      
      final type = map['type'] as String? ?? 'SMS';
      final content = map['content'] as String? ?? '';
      
      final createdAtStr = map['created_at'] as String?;
      final createdAt = createdAtStr != null ? DateTime.parse(createdAtStr).toLocal() : DateTime.now();

      rituals.add(CommunicationRitual(
        id: id,
        syncId: uuid,
        clientId: clientId,
        clientName: 'Client $clientId', // Or resolve via clients list if denormalized
        type: type,
        direction: 'OUTBOUND',
        content: content,
        sentAt: createdAt,
        status: 'SENT',
        lastModifiedUtc: createdAt,
        lastModifiedBy: 'App',
        isDeleted: false,
      ));
    }
    return rituals;
  } on DioException catch (e) {
    throw ApiClientException.fromDioError(e);
  } catch (e) {
    throw ApiClientException('An unexpected error occurred: $e');
  }
}

void _triggerCommsUpdate(Ref ref) async {
  if (_pendingCommsFetch != null) return;
  _pendingCommsFetch = _fetchCommunications(ref);
  try {
    final list = await _pendingCommsFetch!;
    if (!_communicationsController.isClosed) {
      _communicationsController.add(list);
    }
  } catch (e) {
    if (!_communicationsController.isClosed) {
      _communicationsController.addError(e);
    }
  } finally {
    _pendingCommsFetch = null;
  }
}

@riverpod
Stream<List<CommunicationRitual>> communications(Ref ref) {
  _triggerCommsUpdate(ref);
  return _communicationsController.stream;
}

@riverpod
class CommunicationsService extends _$CommunicationsService {
  @override
  FutureOr<void> build() {}

  Dio get _dio => ref.read(apiClientProvider);
  IdMapper get _idMapper => ref.read(idMapperProvider);

  Future<void> sendCommunication(CommunicationRitual ritual) async {
    try {
      String? clientUuid;
      if (ritual.clientId != null) {
        clientUuid = _idMapper.getUuid('client', ritual.clientId!);
      }
      if (clientUuid == null) {
        throw ApiClientException('Could not resolve client UUID.');
      }
      final payload = {
        'client_id': clientUuid,
        'type': ritual.type,
        'content': ritual.content,
      };
      final response = await _dio.post('/communications', data: payload);
      final uuid = (response.data as Map<String, dynamic>)['id'] as String;
      await _idMapper.registerUuid('communication', uuid);
      _triggerCommsUpdate(ref);
    } on DioException catch (e) {
      throw ApiClientException.fromDioError(e);
    }
  }

  Future<void> deleteCommunication(int id) async {
    try {
      var uuid = _idMapper.getUuid('communication', id);
      if (uuid == null) {
        await _fetchCommunications(ref);
        uuid = _idMapper.getUuid('communication', id);
      }
      if (uuid == null) {
        throw ApiClientException('Could not resolve communication UUID.');
      }
      await _dio.delete('/communications/$uuid');
      _triggerCommsUpdate(ref);
    } on DioException catch (e) {
      throw ApiClientException.fromDioError(e);
    }
  }
}
