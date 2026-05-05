import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:drift/drift.dart' show Value;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../../../../shared/domain/client.dart' as domain;
import '../../../../shared/domain/enums.dart';
import '../../../../shared/persistence/database.dart';

part 'clients_provider.g.dart';

@riverpod
class ClientSearchQuery extends _$ClientSearchQuery {
  @override
  String build() => '';

  void set(String query) => state = query;
}

@riverpod
Stream<List<domain.Client>> filteredClients(Ref ref) {
  final query = ref.watch(clientSearchQueryProvider);
  final dao = ref.watch(databaseProvider).clientsDao;

  return dao.watchAllClients().map((rows) {
    final clients = rows.map((row) => _mapToDomain(row)).toList();
    if (query.isEmpty) return clients;

    final lowerQ = query.toLowerCase();
    return clients.where((c) {
      return c.firstName.toLowerCase().contains(lowerQ) ||
          c.lastName.toLowerCase().contains(lowerQ) ||
          c.email.toLowerCase().contains(lowerQ) ||
          c.phone.contains(lowerQ);
    }).toList();
  });
}

@riverpod
Stream<domain.Client?> clientDetail(Ref ref, int id) {
  final dao = ref.watch(databaseProvider).clientsDao;
  return dao
      .watchClientById(id)
      .map((row) => row == null ? null : _mapToDomain(row));
}

// Helper to map Drift Row (database type) to Domain Entity
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

@riverpod
ClientsService clientsService(Ref ref) {
  return ClientsService(ref);
}

class ClientsService {
  final Ref _ref;
  ClientsService(this._ref);

  Future<String> saveAvatar(XFile file) async {
    if (kIsWeb) {
      // On web, we can't save to the physical disk using dart:io.
      // Usually would upload to a server, but for offline-first web, 
      // we can return the blob URL or store in IndexedDB.
      // For now, we'll return the path which is often a blob URL.
      return file.path;
    }

    final appDir = await getApplicationDocumentsDirectory();
    final avatarsDir = Directory(p.join(appDir.path, 'avatars'));
    if (!await avatarsDir.exists()) {
      await avatarsDir.create(recursive: true);
    }
    
    final fileName = '${const Uuid().v4()}${p.extension(file.path)}';
    // On native, we copy the file to our app directory
    final bytes = await file.readAsBytes();
    final localFile = File(p.join(avatarsDir.path, fileName));
    await localFile.writeAsBytes(bytes);
    
    return localFile.path;
  }

  Future<void> createClient(domain.Client client) async {
    final dao = _ref.read(databaseProvider).clientsDao;
    await dao.insertClient(
      ClientsCompanion(
        firstName: Value(client.firstName),
        middleName: Value(client.middleName),
        lastName: Value(client.lastName),
        email: Value(client.email),
        phone: Value(client.phone),
        notes: Value(client.notes),
        photoPath: Value(client.photoPath),
        status: Value(client.status.name),
        lastModifiedUtc: Value(DateTime.now()),
      ),
    );
  }

  Future<void> updateClient(domain.Client client) async {
    final dao = _ref.read(databaseProvider).clientsDao;
    final row = Client(
      id: client.id,
      syncId: client.syncId,
      firstName: client.firstName,
      middleName: client.middleName,
      lastName: client.lastName,
      email: client.email,
      phone: client.phone,
      notes: client.notes,
      visits: client.visits,
      photoPath: client.photoPath,
      status: client.status.name,
      lastModifiedUtc: DateTime.now(),
      lastModifiedBy: 'user', 
      isDeleted: client.isDeleted,
    );
    await dao.updateClient(row);
  }

  Future<void> deleteClient(int id) async {
    final dao = _ref.read(databaseProvider).clientsDao;
    await dao.softDeleteClient(id);
  }
}
