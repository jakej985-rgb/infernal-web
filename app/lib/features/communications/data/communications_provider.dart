import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../shared/core/services/communication_service.dart';
import '../../../../shared/domain/communication.dart';

part 'communications_provider.g.dart';

@riverpod
Stream<List<CommunicationRitual>> communications(Ref ref) {
  final commsService = ref.watch(communicationServiceProvider);
  return commsService.watchCommunications();
}

@riverpod
class CommunicationsService extends _$CommunicationsService {
  @override
  FutureOr<void> build() {}

  CommunicationService get _service => ref.read(communicationServiceProvider);

  Future<void> sendCommunication(CommunicationRitual ritual) async {
    await _service.sendCommunication(ritual);
  }

  Future<void> deleteCommunication(int id) async {
    await _service.deleteCommunication(id);
  }
}
