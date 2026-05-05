import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../shared/persistence/database.dart';
import '../../../shared/persistence/daos/communications_dao.dart';
import '../../../../shared/domain/communication.dart';

part 'communications_provider.g.dart';

@riverpod
CommunicationsDao communicationsDao(Ref ref) {
  return ref.watch(databaseProvider).communicationsDao;

}

@riverpod
Stream<List<CommunicationRitual>> communications(Ref ref) {
  return ref.watch(communicationsDaoProvider).watchAllCommunications().map((rows) {
    return rows.map((row) => CommunicationRitual(
      id: row.id,
      clientId: row.clientId,
      clientName: row.clientName,
      type: row.type,
      direction: row.direction,
      content: row.content,
      sentAt: row.sentAt,
      status: row.status,
    )).toList();
  });
}

@riverpod
class CommunicationsService extends _$CommunicationsService {
  @override
  FutureOr<void> build() {}

  Future<void> sendCommunication(CommunicationsTableCompanion ritual) async {
    await ref.read(communicationsDaoProvider).insertCommunication(ritual);
  }

  Future<void> deleteCommunication(int id) async {
    await ref.read(communicationsDaoProvider).deleteCommunication(id);
  }
}
