import 'dart:io' as io;
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' show Value;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../domain/client.dart' as domain;
import '../domain/enums.dart';
import '../data/interfaces/client_service.dart';
import 'database.dart';
import 'daos/daos.dart';

part 'drift_client_service.g.dart';

@riverpod
DriftClientService driftClientService(Ref ref) {
  return DriftClientService(ref);
}

class DriftClientService implements ClientService {
  final Ref _ref;
  DriftClientService(this._ref);

  ClientsDao get _dao => _ref.read(databaseProvider).clientsDao;

  @override
  Future<List<domain.Client>> getClients() async {
    final rows = await _dao.getAllClients();
    return rows.map((row) => _mapToDomain(row)).toList();
  }

  @override
  Future<domain.Client?> getClientById(int id) async {
    final row = await _dao.getClientById(id);
    return row == null ? null : _mapToDomain(row);
  }

  @override
  Future<void> createClient(domain.Client client) async {
    await _dao.insertClient(
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

  @override
  Future<void> updateClient(domain.Client client) async {
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
    await _dao.updateClient(row);
  }

  @override
  Future<void> deleteClient(int id) async {
    await _dao.softDeleteClient(id);
  }

  @override
  Stream<List<domain.Client>> watchClients() {
    return _dao.watchAllClients().map((rows) {
      return rows.map((row) => _mapToDomain(row)).toList();
    });
  }

  @override
  Stream<domain.Client?> watchClientById(int id) {
    return _dao.watchClientById(id).map((row) {
      return row == null ? null : _mapToDomain(row);
    });
  }

  @override
  Future<String> saveAvatar(XFile file) async {
    if (kIsWeb) {
      return file.path;
    }

    final appDir = await getApplicationDocumentsDirectory();
    final avatarsDir = io.Directory(p.join(appDir.path, 'avatars'));
    if (!await avatarsDir.exists()) {
      await avatarsDir.create(recursive: true);
    }
    
    final fileName = '${const Uuid().v4()}${p.extension(file.path)}';
    final bytes = await file.readAsBytes();
    final localFile = io.File(p.join(avatarsDir.path, fileName));
    await localFile.writeAsBytes(bytes);
    
    return localFile.path;
  }

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
}
