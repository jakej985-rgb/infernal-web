import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/audit_logs_table.dart';

part 'audit_logs_dao.g.dart';

@DriftAccessor(tables: [AuditLogs])
class AuditLogsDao extends DatabaseAccessor<AppDatabase> with _$AuditLogsDaoMixin {
  AuditLogsDao(super.db);

  Stream<List<AuditLog>> watchRecentLogs({int limit = 50}) {
    return (select(auditLogs)
      ..orderBy([(t) => OrderingTerm(expression: t.timestamp, mode: OrderingMode.desc)])
      ..limit(limit))
      .watch();
  }

  Future<int> insertLog(AuditLogsCompanion log) {
    return into(auditLogs).insert(log.copyWith(timestamp: Value(DateTime.now())));
  }
}
