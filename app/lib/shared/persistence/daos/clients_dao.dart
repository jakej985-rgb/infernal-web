import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../database.dart';
import '../tables/clients_table.dart';

part 'clients_dao.g.dart';

/// Data Access Object for Clients table
@DriftAccessor(tables: [Clients])
class ClientsDao extends DatabaseAccessor<AppDatabase> with _$ClientsDaoMixin {
  ClientsDao(super.db);

  static const _uuid = Uuid();

  /// Get all non-deleted clients
  Future<List<Client>> getAllClients() {
    return (select(clients)..where((c) => c.isDeleted.equals(false))).get();
  }

  /// Watch all non-deleted clients (reactive stream)
  Stream<List<Client>> watchAllClients() {
    return (select(clients)..where((c) => c.isDeleted.equals(false))).watch();
  }

  /// Get client by ID
  Future<Client?> getClientById(int id) {
    return (select(clients)..where((c) => c.id.equals(id))).getSingleOrNull();
  }

  /// Watch client by ID
  Stream<Client?> watchClientById(int id) {
    return (select(clients)..where((c) => c.id.equals(id))).watchSingleOrNull();
  }

  /// Get client by sync ID
  Future<Client?> getClientBySyncId(String syncId) {
    return (select(
      clients,
    )..where((c) => c.syncId.equals(syncId))).getSingleOrNull();
  }

  /// Search clients by name (first, middle, or last)
  Future<List<Client>> searchClients(String query) {
    final pattern = '%$query%';
    return (select(clients)..where(
          (c) =>
              c.isDeleted.equals(false) &
              (c.firstName.like(pattern) |
                  c.middleName.like(pattern) |
                  c.lastName.like(pattern) |
                  c.email.like(pattern) |
                  c.phone.like(pattern)),
        ))
        .get();
  }

  /// Get clients by status
  Future<List<Client>> getClientsByStatus(String status) {
    return (select(
      clients,
    )..where((c) => c.isDeleted.equals(false) & c.status.equals(status))).get();
  }

  /// Insert a new client
  Future<int> insertClient(ClientsCompanion client) {
    final withSyncId = client.syncId.present
        ? client
        : client.copyWith(syncId: Value(_uuid.v4()));
    return into(clients).insert(withSyncId);
  }

  /// Update an existing client
  Future<bool> updateClient(Client client) {
    return update(clients).replace(client);
  }

  /// Soft delete a client
  Future<int> softDeleteClient(int id) {
    return (update(clients)..where((c) => c.id.equals(id))).write(
      ClientsCompanion(
        isDeleted: const Value(true),
        lastModifiedUtc: Value(DateTime.now()),
      ),
    );
  }

  /// Hard delete a client (use with caution)
  Future<int> deleteClient(int id) {
    return (delete(clients)..where((c) => c.id.equals(id))).go();
  }

  /// Increment visit count
  Future<int> incrementVisits(int id) async {
    final client = await getClientById(id);
    if (client == null) return 0;

    return (update(clients)..where((c) => c.id.equals(id))).write(
      ClientsCompanion(
        visits: Value(client.visits + 1),
        lastModifiedUtc: Value(DateTime.now()),
      ),
    );
  }
}
