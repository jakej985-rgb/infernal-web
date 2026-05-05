import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/communications_table.dart';

part 'communications_dao.g.dart';

@DriftAccessor(tables: [CommunicationsTable])
class CommunicationsDao extends DatabaseAccessor<AppDatabase> with _$CommunicationsDaoMixin {
  CommunicationsDao(super.db);

  Stream<List<CommunicationsTableData>> watchAllCommunications() => select(communicationsTable).watch();
  Future<int> insertCommunication(CommunicationsTableCompanion msg) => into(communicationsTable).insert(msg);
  Future<void> deleteCommunication(int id) => (delete(communicationsTable)..where((t) => t.id.equals(id))).go();
}

