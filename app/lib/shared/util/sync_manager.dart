import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/client.dart' as domain;
import '../domain/appointment.dart' as domain;
import '../domain/inventory.dart' as domain;
import '../domain/communication.dart' as domain;
import '../domain/document.dart' as domain;
import '../domain/repositories.dart';
import '../persistence/repositories_impl.dart';
import '../domain/dtos.dart';
import 'api_client.dart';
import 'shared_prefs_provider.dart';
import '../data/use_api_provider.dart';
import '../cache/id_mapper.dart';

part 'sync_manager.g.dart';

@Riverpod(keepAlive: true)
SyncManager syncManager(Ref ref) {
  return SyncManager(
    ref,
    ref.watch(clientRepositoryProvider),
    ref.watch(appointmentRepositoryProvider),
    ref.watch(inventoryRepositoryProvider),
    ref.watch(communicationRepositoryProvider),
    ref.watch(documentRepositoryProvider),
  );
}

class SyncManager {
  final Ref _ref;
  final ClientRepository _clientRepo;
  final AppointmentRepository _apptRepo;
  final InventoryRepository _invRepo;
  final CommunicationRepository _commRepo;
  final DocumentRepository _docRepo;

  static const _lastSyncKey = 'sync_engine_last_sync_timestamp';

  SyncManager(
    this._ref,
    this._clientRepo,
    this._apptRepo,
    this._invRepo,
    this._commRepo,
    this._docRepo,
  );

  Future<bool> sync() async {
    debugPrint('[SyncManager] Starting synchronization cycle...');
    final prefs = _ref.read(sharedPreferencesProvider);
    final dio = _ref.read(apiClientProvider);
    final useApi = _ref.read(useApiProvider);
    final idMapper = _ref.read(idMapperProvider);

    // 1. Get the last sync timestamp
    final lastSyncStr = prefs.getString(_lastSyncKey);
    final lastSync = DateTime.parse(lastSyncStr ?? '1970-01-01T00:00:00.000Z');
    debugPrint('[SyncManager] Last sync timestamp: $lastSync');

    try {
      // 2. Query local unsynced updates (items modified after lastSync)
      // If we are in Direct API mode, clients are managed centrally in real-time.
      // We skip uploading local SQLite client table modifications.
      final unsyncedClients = <ClientSyncDTO>[];
      if (!useApi) {
        final localClients = await _clientRepo.getUnsynced();
        for (final c in localClients.where((c) => c.lastModifiedUtc.isAfter(lastSync))) {
          unsyncedClients.add(ClientSyncDTO(
            id: c.syncId,
            name: c.fullName,
            email: c.email,
            phone: c.phone,
            isDeleted: c.isDeleted,
            updatedAt: c.lastModifiedUtc,
          ));
        }
      }

      final localAppts = await _apptRepo.getUnsynced();
      final unsyncedAppts = <ApptSyncDTO>[];
      for (final a in localAppts.where((a) => a.lastModifiedUtc.isAfter(lastSync))) {
        final clientSyncId = useApi
            ? idMapper.getUuid('client', a.clientId)
            : await _clientRepo.getSyncId(a.clientId);
        if (clientSyncId != null) {
          unsyncedAppts.add(ApptSyncDTO(
            id: a.syncId,
            clientId: clientSyncId,
            title: a.serviceType,
            notes: a.notes ?? '',
            startTime: a.dateTime,
            endTime: a.endTime,
            isDeleted: a.isDeleted,
            updatedAt: a.lastModifiedUtc,
          ));
        }
      }

      final localInv = await _invRepo.getUnsynced();
      final unsyncedInv = localInv.where((iv) => iv.updatedAt.isAfter(lastSync)).map((iv) {
        return InvSyncDTO(
          id: iv.syncId,
          name: iv.name,
          description: '',
          quantity: iv.stockQuantity.toInt(),
          lowStockThreshold: iv.minimumQuantity.toInt(),
          category: iv.category,
          unit: iv.unit,
          supplier: iv.supplier,
          lastOrderedAt: iv.lastOrderedAt,
          isDeleted: iv.isDeleted,
          updatedAt: iv.updatedAt,
        );
      }).toList();

      final localDocs = await _docRepo.getUnsynced();
      final unsyncedDocs = <DocSyncDTO>[];
      for (final d in localDocs.where((d) => d.lastModifiedUtc.isAfter(lastSync))) {
        final clientSyncId = useApi
            ? idMapper.getUuid('client', d.clientId)
            : await _clientRepo.getSyncId(d.clientId);
        unsyncedDocs.add(DocSyncDTO(
          id: d.syncId,
          clientId: clientSyncId,
          name: d.title,
          filePath: d.filePath,
          fileSize: 0,
          isDeleted: d.isDeleted,
          updatedAt: d.lastModifiedUtc,
        ));
      }

      final localComms = await _commRepo.getUnsynced();
      final unsyncedComms = <CommSyncDTO>[];
      for (final cm in localComms.where((cm) => (cm.lastModifiedUtc ?? DateTime.fromMillisecondsSinceEpoch(0)).isAfter(lastSync))) {
        final clientSyncId = useApi
            ? idMapper.getUuid('client', cm.clientId ?? 0)
            : await _clientRepo.getSyncId(cm.clientId ?? 0);
        if (clientSyncId != null) {
          unsyncedComms.add(CommSyncDTO(
            id: cm.syncId,
            clientId: clientSyncId,
            type: cm.type,
            content: cm.content,
            isDeleted: cm.isDeleted,
            updatedAt: cm.lastModifiedUtc ?? DateTime.now().toUtc(),
          ));
        }
      }

      debugPrint('[SyncManager] Pushing unsynced local counts: '
          'clients=${unsyncedClients.length}, '
          'appointments=${unsyncedAppts.length}, '
          'inventory=${unsyncedInv.length}, '
          'documents=${unsyncedDocs.length}, '
          'communications=${unsyncedComms.length}');

      // 3. Post payload to sync endpoint
      final payload = SyncRequestPayload(
        lastSyncTimestamp: lastSync.toUtc(),
        clients: unsyncedClients,
        appointments: unsyncedAppts,
        inventory: unsyncedInv,
        documents: unsyncedDocs,
        communications: unsyncedComms,
      );

      final response = await dio.post('/sync', data: payload.toJson());
      final syncResponse = SyncResponsePayload.fromJson(response.data);

      debugPrint('[SyncManager] Server responded with updates: '
          'clients=${syncResponse.clients.length}, '
          'appointments=${syncResponse.appointments.length}, '
          'inventory=${syncResponse.inventory.length}, '
          'documents=${syncResponse.documents.length}, '
          'communications=${syncResponse.communications.length}');

      // 4. Merge server changes into local DB
      // Note: order is important (Clients first, then referencing tables)
      
      // Process Clients
      for (final c in syncResponse.clients) {
        // Warm up / Register mapping globally so referencing entities can translate correctly
        await idMapper.registerUuid('client', c.id);

        if (useApi) {
          // Skip local database modifications in direct API mode
          continue;
        }

        final parts = c.name.split(' ');
        final firstName = parts.first;
        final lastName = parts.length > 1 ? parts.sublist(1).join(' ') : '';

        final domainClient = domain.Client(
          id: 0,
          syncId: c.id,
          firstName: firstName,
          lastName: lastName,
          email: c.email,
          phone: c.phone,
          lastModifiedUtc: c.updatedAt,
          isDeleted: c.isDeleted,
        );
        await _clientRepo.saveFromSync(domainClient);
      }

      // Process Appointments
      for (final a in syncResponse.appointments) {
        final localClientId = useApi
            ? await idMapper.registerUuid('client', a.clientId)
            : await _clientRepo.getLocalId(a.clientId);
        if (localClientId != null) {
          final domainAppt = domain.Appointment(
            id: 0,
            syncId: a.id,
            clientId: localClientId,
            userId: 1, // Default local user ID
            clientName: '',
            dateTime: a.startTime.toLocal(),
            durationMinutes: a.endTime.difference(a.startTime).inMinutes,
            serviceType: a.title,
            lastModifiedUtc: a.updatedAt,
            isDeleted: a.isDeleted,
          );
          await _apptRepo.saveFromSync(domainAppt);
        }
      }

      // Process Inventory
      for (final iv in syncResponse.inventory) {
        final domainInv = domain.InventoryItem(
          id: 0,
          syncId: iv.id,
          name: iv.name,
          category: iv.category,
          stockQuantity: iv.quantity.toDouble(),
          minimumQuantity: iv.lowStockThreshold.toDouble(),
          unit: iv.unit,
          supplier: iv.supplier,
          lastOrderedAt: iv.lastOrderedAt?.toLocal(),
          updatedAt: iv.updatedAt,
          isDeleted: iv.isDeleted,
        );
        await _invRepo.saveFromSync(domainInv);
      }

      // Process Documents
      for (final d in syncResponse.documents) {
        final localClientId = useApi
            ? (d.clientId != null ? await idMapper.registerUuid('client', d.clientId!) : null)
            : await _clientRepo.getLocalId(d.clientId ?? '');
        final domainDoc = domain.Document(
          id: 0,
          syncId: d.id,
          uploadedByUserId: 1,
          clientId: localClientId ?? 0,
          title: d.name,
          filePath: d.filePath,
          createdAt: d.updatedAt.toLocal(),
          lastModifiedUtc: d.updatedAt,
          isDeleted: d.isDeleted,
        );
        await _docRepo.saveFromSync(domainDoc);
      }

      // Process Communications
      for (final cm in syncResponse.communications) {
        final localClientId = useApi
            ? await idMapper.registerUuid('client', cm.clientId)
            : await _clientRepo.getLocalId(cm.clientId);
        if (localClientId != null) {
          final domainComm = domain.CommunicationRitual(
            id: 0,
            syncId: cm.id,
            clientId: localClientId,
            clientName: '',
            type: cm.type,
            direction: 'INBOUND',
            content: cm.content,
            sentAt: cm.updatedAt.toLocal(),
            lastModifiedUtc: cm.updatedAt,
            isDeleted: cm.isDeleted,
          );
          await _commRepo.saveFromSync(domainComm);
        }
      }

      // 5. Save the new sync timestamp
      await prefs.setString(_lastSyncKey, syncResponse.currentTimestamp.toIso8601String());
      debugPrint('[SyncManager] Sync completed successfully. Saved timestamp: ${syncResponse.currentTimestamp}');
      return true;

    } catch (e) {
      debugPrint('[SyncManager] Sync cycle failed: $e');
      return false;
    }
  }
}
