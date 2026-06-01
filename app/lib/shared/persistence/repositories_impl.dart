import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../domain/client.dart' as domain;
import '../domain/appointment.dart' as domain;
import '../domain/inventory.dart' as domain;
import '../domain/communication.dart' as domain;
import '../domain/document.dart' as domain;
import '../domain/enums.dart';
import '../domain/repositories.dart';
import 'database.dart';

part 'repositories_impl.g.dart';

const _uuid = Uuid();

@Riverpod(keepAlive: true)
ClientRepository clientRepository(Ref ref) {
  return ClientRepositoryImpl(ref.watch(databaseProvider));
}

@Riverpod(keepAlive: true)
AppointmentRepository appointmentRepository(Ref ref) {
  return AppointmentRepositoryImpl(ref.watch(databaseProvider));
}

@Riverpod(keepAlive: true)
InventoryRepository inventoryRepository(Ref ref) {
  return InventoryRepositoryImpl(ref.watch(databaseProvider));
}

@Riverpod(keepAlive: true)
CommunicationRepository communicationRepository(Ref ref) {
  return CommunicationRepositoryImpl(ref.watch(databaseProvider));
}

@Riverpod(keepAlive: true)
DocumentRepository documentRepository(Ref ref) {
  return DocumentRepositoryImpl(ref.watch(databaseProvider));
}

// === Client Repository ===

class ClientRepositoryImpl implements ClientRepository {
  final AppDatabase _db;
  ClientRepositoryImpl(this._db);

  domain.Client _mapToDomain(Client row) {
    return domain.Client(
      id: row.id,
      syncId: row.syncId,
      firstName: row.firstName,
      middleName: row.middleName,
      lastName: row.lastName,
      phone: row.phone,
      email: row.email,
      notes: row.notes,
      visits: row.visits,
      photoPath: row.photoPath,
      status: ClientStatus.values.asNameMap()[row.status] ?? ClientStatus.bound,
      lastModifiedUtc: row.lastModifiedUtc,
      lastModifiedBy: row.lastModifiedBy,
      isDeleted: row.isDeleted,
    );
  }

  @override
  Stream<List<domain.Client>> watchAll() {
    return (_db.select(_db.clients)..where((c) => c.isDeleted.equals(false)))
        .watch()
        .map((rows) => rows.map(_mapToDomain).toList());
  }

  @override
  Stream<domain.Client?> watchById(int id) {
    return (_db.select(_db.clients)..where((c) => c.id.equals(id)))
        .watchSingleOrNull()
        .map((row) => row == null ? null : _mapToDomain(row));
  }

  @override
  Future<List<domain.Client>> getUnsynced() async {
    final rows = await (_db.select(_db.clients)).get();
    return rows.map(_mapToDomain).toList();
  }

  @override
  Future<void> save(domain.Client client) async {
    final syncIdVal = client.syncId.isEmpty ? _uuid.v4() : client.syncId;
    final companion = ClientsCompanion(
      id: client.id == 0 ? const Value.absent() : Value(client.id),
      syncId: Value(syncIdVal),
      firstName: Value(client.firstName),
      middleName: Value(client.middleName),
      lastName: Value(client.lastName),
      phone: Value(client.phone),
      email: Value(client.email),
      notes: Value(client.notes),
      visits: Value(client.visits),
      photoPath: Value(client.photoPath),
      status: Value(client.status.name),
      lastModifiedUtc: Value(DateTime.now().toUtc()),
      lastModifiedBy: Value(client.lastModifiedBy),
      isDeleted: Value(client.isDeleted),
    );

    if (client.id == 0) {
      await _db.into(_db.clients).insert(companion);
    } else {
      await _db.update(_db.clients).replace(companion);
    }
  }

  @override
  Future<void> saveFromSync(domain.Client client) async {
    final existing = await (_db.select(_db.clients)
          ..where((c) => c.syncId.equals(client.syncId)))
        .getSingleOrNull();

    final companion = ClientsCompanion(
      id: existing == null ? const Value.absent() : Value(existing.id),
      syncId: Value(client.syncId),
      firstName: Value(client.firstName),
      middleName: Value(client.middleName),
      lastName: Value(client.lastName),
      phone: Value(client.phone),
      email: Value(client.email),
      notes: Value(client.notes),
      visits: Value(client.visits),
      photoPath: Value(client.photoPath),
      status: Value(client.status.name),
      lastModifiedUtc: Value(client.lastModifiedUtc),
      lastModifiedBy: Value(client.lastModifiedBy),
      isDeleted: Value(client.isDeleted),
    );

    if (existing == null) {
      await _db.into(_db.clients).insert(companion);
    } else {
      await _db.update(_db.clients).replace(companion);
    }
  }

  @override
  Future<void> delete(int id) async {
    await (_db.update(_db.clients)..where((c) => c.id.equals(id))).write(
      ClientsCompanion(
        isDeleted: const Value(true),
        lastModifiedUtc: Value(DateTime.now().toUtc()),
      ),
    );
  }

  @override
  Future<String?> getSyncId(int localId) async {
    final row = await (_db.select(_db.clients)..where((c) => c.id.equals(localId)))
        .getSingleOrNull();
    return row?.syncId;
  }

  @override
  Future<int?> getLocalId(String syncId) async {
    final row = await (_db.select(_db.clients)..where((c) => c.syncId.equals(syncId)))
        .getSingleOrNull();
    return row?.id;
  }
}

// === Appointment Repository ===

class AppointmentRepositoryImpl implements AppointmentRepository {
  final AppDatabase _db;
  AppointmentRepositoryImpl(this._db);

  domain.Appointment _mapToDomain(Appointment row) {
    return domain.Appointment(
      id: row.id,
      syncId: row.syncId,
      clientId: row.clientId,
      userId: row.userId,
      clientName: row.clientName,
      dateTime: row.startTime,
      durationMinutes: row.durationMinutes,
      serviceType: row.serviceType,
      serviceCategory: row.serviceCategory,
      priceType: row.priceType,
      priceCharged: row.priceCharged,
      quotedPrice: row.quotedPrice,
      finalPrice: row.finalPrice,
      notes: row.notes,
      photoPath: row.photoPath,
      color: row.color,
      status: row.status,
      isBlockOff: row.isBlockOff,
      lastModifiedUtc: row.modifiedAt,
      lastModifiedBy: row.lastModifiedBy,
      isDeleted: row.isDeleted,
    );
  }

  @override
  Stream<List<domain.Appointment>> watchAll() {
    return (_db.select(_db.appointments)..where((a) => a.isDeleted.equals(false)))
        .watch()
        .map((rows) => rows.map(_mapToDomain).toList());
  }

  @override
  Stream<domain.Appointment?> watchById(int id) {
    return (_db.select(_db.appointments)..where((a) => a.id.equals(id)))
        .watchSingleOrNull()
        .map((row) => row == null ? null : _mapToDomain(row));
  }

  @override
  Future<List<domain.Appointment>> getUnsynced() async {
    final rows = await (_db.select(_db.appointments)).get();
    return rows.map(_mapToDomain).toList();
  }

  @override
  Future<void> save(domain.Appointment appt) async {
    final syncIdVal = appt.syncId.isEmpty ? _uuid.v4() : appt.syncId;
    final companion = AppointmentsCompanion(
      id: appt.id == 0 ? const Value.absent() : Value(appt.id),
      syncId: Value(syncIdVal),
      clientId: Value(appt.clientId),
      userId: Value(appt.userId),
      clientName: Value(appt.clientName),
      startTime: Value(appt.dateTime),
      durationMinutes: Value(appt.durationMinutes),
      serviceType: Value(appt.serviceType),
      serviceCategory: Value(appt.serviceCategory),
      priceType: Value(appt.priceType),
      priceCharged: Value(appt.priceCharged),
      quotedPrice: Value(appt.quotedPrice),
      finalPrice: Value(appt.finalPrice),
      notes: Value(appt.notes),
      photoPath: Value(appt.photoPath),
      color: Value(appt.color),
      status: Value(appt.status),
      isBlockOff: Value(appt.isBlockOff),
      modifiedAt: Value(DateTime.now().toUtc()),
      lastModifiedBy: Value(appt.lastModifiedBy),
      isDeleted: Value(appt.isDeleted),
    );

    if (appt.id == 0) {
      await _db.into(_db.appointments).insert(companion);
    } else {
      await _db.update(_db.appointments).replace(companion);
    }
  }

  @override
  Future<void> saveFromSync(domain.Appointment appt) async {
    final existing = await (_db.select(_db.appointments)
          ..where((a) => a.syncId.equals(appt.syncId)))
        .getSingleOrNull();

    final companion = AppointmentsCompanion(
      id: existing == null ? const Value.absent() : Value(existing.id),
      syncId: Value(appt.syncId),
      clientId: Value(appt.clientId),
      userId: Value(appt.userId),
      clientName: Value(appt.clientName),
      startTime: Value(appt.dateTime),
      durationMinutes: Value(appt.durationMinutes),
      serviceType: Value(appt.serviceType),
      serviceCategory: Value(appt.serviceCategory),
      priceType: Value(appt.priceType),
      priceCharged: Value(appt.priceCharged),
      quotedPrice: Value(appt.quotedPrice),
      finalPrice: Value(appt.finalPrice),
      notes: Value(appt.notes),
      photoPath: Value(appt.photoPath),
      color: Value(appt.color),
      status: Value(appt.status),
      isBlockOff: Value(appt.isBlockOff),
      modifiedAt: Value(appt.lastModifiedUtc),
      lastModifiedBy: Value(appt.lastModifiedBy),
      isDeleted: Value(appt.isDeleted),
    );

    if (existing == null) {
      await _db.into(_db.appointments).insert(companion);
    } else {
      await _db.update(_db.appointments).replace(companion);
    }
  }

  @override
  Future<void> delete(int id) async {
    await (_db.update(_db.appointments)..where((a) => a.id.equals(id))).write(
      AppointmentsCompanion(
        isDeleted: const Value(true),
        modifiedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }
}

// === Inventory Repository ===

class InventoryRepositoryImpl implements InventoryRepository {
  final AppDatabase _db;
  InventoryRepositoryImpl(this._db);

  domain.InventoryItem _mapToDomain(InventoryItem row) {
    return domain.InventoryItem(
      id: row.id,
      syncId: row.syncId,
      name: row.name,
      category: row.category,
      stockQuantity: row.stockQuantity,
      minimumQuantity: row.minimumQuantity,
      unit: row.unit,
      supplier: row.supplier,
      lastOrderedAt: row.lastOrderedAt,
      updatedAt: row.updatedAt,
      isDeleted: row.isDeleted,
    );
  }

  @override
  Stream<List<domain.InventoryItem>> watchAll() {
    return (_db.select(_db.inventoryItems)..where((iv) => iv.isDeleted.equals(false)))
        .watch()
        .map((rows) => rows.map(_mapToDomain).toList());
  }

  @override
  Future<List<domain.InventoryItem>> getUnsynced() async {
    final rows = await (_db.select(_db.inventoryItems)).get();
    return rows.map(_mapToDomain).toList();
  }

  @override
  Future<void> save(domain.InventoryItem item) async {
    final syncIdVal = item.syncId.isEmpty ? _uuid.v4() : item.syncId;
    final companion = InventoryItemsCompanion(
      id: item.id == 0 ? const Value.absent() : Value(item.id),
      syncId: Value(syncIdVal),
      name: Value(item.name),
      category: Value(item.category),
      stockQuantity: Value(item.stockQuantity),
      minimumQuantity: Value(item.minimumQuantity),
      unit: Value(item.unit),
      supplier: Value(item.supplier),
      lastOrderedAt: Value(item.lastOrderedAt),
      updatedAt: Value(DateTime.now().toUtc()),
      isDeleted: Value(item.isDeleted),
    );

    if (item.id == 0) {
      await _db.into(_db.inventoryItems).insert(companion);
    } else {
      await _db.update(_db.inventoryItems).replace(companion);
    }
  }

  @override
  Future<void> saveFromSync(domain.InventoryItem item) async {
    final existing = await (_db.select(_db.inventoryItems)
          ..where((iv) => iv.syncId.equals(item.syncId)))
        .getSingleOrNull();

    final companion = InventoryItemsCompanion(
      id: existing == null ? const Value.absent() : Value(existing.id),
      syncId: Value(item.syncId),
      name: Value(item.name),
      category: Value(item.category),
      stockQuantity: Value(item.stockQuantity),
      minimumQuantity: Value(item.minimumQuantity),
      unit: Value(item.unit),
      supplier: Value(item.supplier),
      lastOrderedAt: Value(item.lastOrderedAt),
      updatedAt: Value(item.updatedAt),
      isDeleted: Value(item.isDeleted),
    );

    if (existing == null) {
      await _db.into(_db.inventoryItems).insert(companion);
    } else {
      await _db.update(_db.inventoryItems).replace(companion);
    }
  }

  @override
  Future<void> delete(int id) async {
    await (_db.update(_db.inventoryItems)..where((iv) => iv.id.equals(id))).write(
      InventoryItemsCompanion(
        isDeleted: const Value(true),
        updatedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }
}

// === Communication Repository ===

class CommunicationRepositoryImpl implements CommunicationRepository {
  final AppDatabase _db;
  CommunicationRepositoryImpl(this._db);

  domain.CommunicationRitual _mapToDomain(CommunicationsTableData row) {
    return domain.CommunicationRitual(
      id: row.id,
      syncId: row.syncId,
      clientId: row.clientId,
      clientName: row.clientName,
      type: row.type,
      direction: row.direction,
      content: row.content,
      sentAt: row.sentAt,
      status: row.status,
      lastModifiedUtc: row.lastModifiedUtc,
      lastModifiedBy: row.lastModifiedBy,
      isDeleted: row.isDeleted,
    );
  }

  @override
  Stream<List<domain.CommunicationRitual>> watchAll() {
    return (_db.select(_db.communicationsTable)..where((cm) => cm.isDeleted.equals(false)))
        .watch()
        .map((rows) => rows.map(_mapToDomain).toList());
  }

  @override
  Future<List<domain.CommunicationRitual>> getUnsynced() async {
    final rows = await (_db.select(_db.communicationsTable)).get();
    return rows.map(_mapToDomain).toList();
  }

  @override
  Future<void> save(domain.CommunicationRitual comm) async {
    final syncIdVal = comm.syncId.isEmpty ? _uuid.v4() : comm.syncId;
    final companion = CommunicationsTableCompanion(
      id: comm.id == 0 ? const Value.absent() : Value(comm.id),
      syncId: Value(syncIdVal),
      clientId: Value(comm.clientId),
      clientName: Value(comm.clientName),
      type: Value(comm.type),
      direction: Value(comm.direction),
      content: Value(comm.content),
      sentAt: Value(comm.sentAt),
      status: Value(comm.status),
      lastModifiedUtc: Value(DateTime.now().toUtc()),
      lastModifiedBy: Value(comm.lastModifiedBy),
      isDeleted: Value(comm.isDeleted),
    );

    if (comm.id == 0) {
      await _db.into(_db.communicationsTable).insert(companion);
    } else {
      await _db.update(_db.communicationsTable).replace(companion);
    }
  }

  @override
  Future<void> saveFromSync(domain.CommunicationRitual comm) async {
    final existing = await (_db.select(_db.communicationsTable)
          ..where((cm) => cm.syncId.equals(comm.syncId)))
        .getSingleOrNull();

    final companion = CommunicationsTableCompanion(
      id: existing == null ? const Value.absent() : Value(existing.id),
      syncId: Value(comm.syncId),
      clientId: Value(comm.clientId),
      clientName: Value(comm.clientName),
      type: Value(comm.type),
      direction: Value(comm.direction),
      content: Value(comm.content),
      sentAt: Value(comm.sentAt),
      status: Value(comm.status),
      lastModifiedUtc: Value(comm.lastModifiedUtc ?? DateTime.now().toUtc()),
      lastModifiedBy: Value(comm.lastModifiedBy),
      isDeleted: Value(comm.isDeleted),
    );

    if (existing == null) {
      await _db.into(_db.communicationsTable).insert(companion);
    } else {
      await _db.update(_db.communicationsTable).replace(companion);
    }
  }

  @override
  Future<void> delete(int id) async {
    await (_db.update(_db.communicationsTable)..where((cm) => cm.id.equals(id))).write(
      CommunicationsTableCompanion(
        isDeleted: const Value(true),
        lastModifiedUtc: Value(DateTime.now().toUtc()),
      ),
    );
  }
}

// === Document Repository ===

class DocumentRepositoryImpl implements DocumentRepository {
  final AppDatabase _db;
  DocumentRepositoryImpl(this._db);

  domain.Document _mapToDomain(Document row) {
    return domain.Document(
      id: row.id,
      syncId: row.syncId,
      uploadedByUserId: row.uploadedByUserId,
      clientId: row.clientId,
      title: row.title,
      filePath: row.filePath,
      createdAt: row.createdAt,
      lastModifiedUtc: row.lastModifiedUtc,
      lastModifiedBy: row.lastModifiedBy,
      isDeleted: row.isDeleted,
    );
  }

  @override
  Stream<List<domain.Document>> watchAll() {
    return (_db.select(_db.documents)..where((d) => d.isDeleted.equals(false)))
        .watch()
        .map((rows) => rows.map(_mapToDomain).toList());
  }

  @override
  Future<List<domain.Document>> getUnsynced() async {
    final rows = await (_db.select(_db.documents)).get();
    return rows.map(_mapToDomain).toList();
  }

  @override
  Future<void> save(domain.Document doc) async {
    final syncIdVal = doc.syncId.isEmpty ? _uuid.v4() : doc.syncId;
    final companion = DocumentsCompanion(
      id: doc.id == 0 ? const Value.absent() : Value(doc.id),
      syncId: Value(syncIdVal),
      uploadedByUserId: Value(doc.uploadedByUserId),
      clientId: Value(doc.clientId),
      title: Value(doc.title),
      filePath: Value(doc.filePath),
      createdAt: Value(doc.createdAt),
      lastModifiedUtc: Value(DateTime.now().toUtc()),
      lastModifiedBy: Value(doc.lastModifiedBy),
      isDeleted: Value(doc.isDeleted),
    );

    if (doc.id == 0) {
      await _db.into(_db.documents).insert(companion);
    } else {
      await _db.update(_db.documents).replace(companion);
    }
  }

  @override
  Future<void> saveFromSync(domain.Document doc) async {
    final existing = await (_db.select(_db.documents)
          ..where((d) => d.syncId.equals(doc.syncId)))
        .getSingleOrNull();

    final companion = DocumentsCompanion(
      id: existing == null ? const Value.absent() : Value(existing.id),
      syncId: Value(doc.syncId),
      uploadedByUserId: Value(doc.uploadedByUserId),
      clientId: Value(doc.clientId),
      title: Value(doc.title),
      filePath: Value(doc.filePath),
      createdAt: Value(doc.createdAt),
      lastModifiedUtc: Value(doc.lastModifiedUtc),
      lastModifiedBy: Value(doc.lastModifiedBy),
      isDeleted: Value(doc.isDeleted),
    );

    if (existing == null) {
      await _db.into(_db.documents).insert(companion);
    } else {
      await _db.update(_db.documents).replace(companion);
    }
  }

  @override
  Future<void> delete(int id) async {
    await (_db.update(_db.documents)..where((d) => d.id.equals(id))).write(
      DocumentsCompanion(
        isDeleted: const Value(true),
        lastModifiedUtc: Value(DateTime.now().toUtc()),
      ),
    );
  }
}
