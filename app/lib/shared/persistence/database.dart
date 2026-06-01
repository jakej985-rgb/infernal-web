import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'tables/tables.dart';
import 'daos/daos.dart';


part 'database.g.dart';

/// Main Drift database for Infernal Ink & Steel Suite
///
/// This is the single source of truth for local data persistence.
/// Uses drift_flutter for cross-platform support (mobile, desktop, web).
@DriftDatabase(
  tables: [
    Clients, 
    Users, 
    Appointments, 
    Quotes, 
    Documents, 
    ShopSettingsTable, 
    AuditLogs,
    InventoryItems,
    CommunicationsTable,
  ],
  daos: [
    ClientsDao,
    UsersDao,
    AppointmentsDao,
    QuotesDao,
    DocumentsDao,
    ShopSettingsDao,
    AuditLogsDao,
    InventoryDao,
    CommunicationsDao,
  ],

)
class AppDatabase extends _$AppDatabase {
  /// Default constructor using drift_flutter's cross-platform database.
  /// One unified code for all platforms (mobile, desktop, web).
  AppDatabase() : super(
    driftDatabase(
      name: 'infernal_ink_steel',
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.js'),
      ),
    ),
  );

  /// For testing with a custom executor
  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();

        // Create default shop settings if none exist
        await into(shopSettingsTable).insert(
          ShopSettingsTableCompanion.insert(
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        );
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          await m.addColumn(inventoryItems, inventoryItems.syncId);
          await m.addColumn(communicationsTable, communicationsTable.syncId);
          await m.addColumn(communicationsTable, communicationsTable.lastModifiedUtc);
          await m.addColumn(communicationsTable, communicationsTable.lastModifiedBy);
          await m.addColumn(communicationsTable, communicationsTable.isDeleted);
        }
      },
    );
  }
}

@Riverpod(keepAlive: true)
AppDatabase database(Ref ref) {
  return AppDatabase();
}

