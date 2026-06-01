import 'dart:async';
import 'dart:io' as io;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../cache/id_mapper.dart';
import '../../domain/client.dart' as domain;
import '../../util/api_client.dart';
import '../interfaces/client_service.dart';

part 'client_api_service.g.dart';

@riverpod
ClientApiService clientApiService(Ref ref) {
  return ClientApiService(ref);
}

class ClientApiService implements ClientService {
  final Ref _ref;
  ClientApiService(this._ref);

  IdMapper get _idMapper => _ref.read(idMapperProvider);
  Dio get _dio => _ref.read(apiClientProvider);

  // Broadcast controllers for reactive real-time updates
  final _clientsController = StreamController<List<domain.Client>>.broadcast();
  final _clientDetailControllers = <int, StreamController<domain.Client?>>{};

  // Single-flight deduplication fields to prevent API refetch storms
  Future<List<domain.Client>>? _pendingClientsFetch;
  final Map<int, Future<domain.Client?>> _pendingClientFetch = {};

  void _triggerClientsUpdate() async {
    try {
      final clients = await _getClientsDeduplicated();
      if (!_clientsController.isClosed) {
        _clientsController.add(clients);
      }
    } catch (e) {
      if (!_clientsController.isClosed) {
        _clientsController.addError(e);
      }
    }
  }

  void _triggerClientDetailUpdate(int id) async {
    try {
      final client = await _getClientByIdDeduplicated(id);
      final controller = _clientDetailControllers[id];
      if (controller != null && !controller.isClosed) {
        controller.add(client);
      }
    } catch (e) {
      final controller = _clientDetailControllers[id];
      if (controller != null && !controller.isClosed) {
        controller.addError(e);
      }
    }
  }

  Future<List<domain.Client>> _getClientsDeduplicated() {
    if (_pendingClientsFetch != null) return _pendingClientsFetch!;
    _pendingClientsFetch = getClients().whenComplete(() {
      _pendingClientsFetch = null;
    });
    return _pendingClientsFetch!;
  }

  Future<domain.Client?> _getClientByIdDeduplicated(int id) {
    if (_pendingClientFetch.containsKey(id)) return _pendingClientFetch[id]!;
    final fut = getClientById(id).whenComplete(() {
      _pendingClientFetch.remove(id);
    });
    _pendingClientFetch[id] = fut;
    return fut;
  }

  Future<String?> _resolveUuid(int id) async {
    final uuid = _idMapper.getUuid(id);
    if (uuid != null) return uuid;

    // If UUID mapping is missing locally, resolve it by loading list of clients
    await _getClientsDeduplicated();
    return _idMapper.getUuid(id);
  }

  @override
  Future<List<domain.Client>> getClients() async {
    try {
      final response = await _dio.get('/clients');
      final rawList = response.data as List;
      
      final clients = <domain.Client>[];
      for (final item in rawList) {
        final map = item as Map<String, dynamic>;
        clients.add(await _mapToDomain(map));
      }
      return clients;
    } on DioException catch (e) {
      throw ApiClientException.fromDioError(e);
    } catch (e) {
      throw ApiClientException('An unexpected error occurred: $e');
    }
  }

  @override
  Future<domain.Client?> getClientById(int id) async {
    try {
      final uuid = await _resolveUuid(id);
      if (uuid == null) return null;

      final response = await _dio.get('/clients/$uuid');
      return await _mapToDomain(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiClientException.fromDioError(e);
    } catch (e) {
      throw ApiClientException('An unexpected error occurred: $e');
    }
  }

  @override
  Future<void> createClient(domain.Client client) async {
    try {
      final payload = {
        'name': client.fullName,
        'email': client.email,
        'phone': client.phone,
      };

      final response = await _dio.post('/clients', data: payload);
      final uuid = (response.data as Map<String, dynamic>)['id'] as String;
      
      // Warm up map cache
      await _idMapper.registerUuid(uuid);

      // Trigger hot stream refresh for active subscribers
      _triggerClientsUpdate();
    } on DioException catch (e) {
      throw ApiClientException.fromDioError(e);
    } catch (e) {
      throw ApiClientException('An unexpected error occurred: $e');
    }
  }

  @override
  Future<void> updateClient(domain.Client client) async {
    try {
      final uuid = await _resolveUuid(client.id);
      if (uuid == null) throw ApiClientException('Cannot resolve backend ID for client.');

      final payload = {
        'name': client.fullName,
        'email': client.email,
        'phone': client.phone,
      };

      await _dio.put('/clients/$uuid', data: payload);

      // Trigger hot stream updates
      _triggerClientsUpdate();
      _triggerClientDetailUpdate(client.id);
    } on DioException catch (e) {
      throw ApiClientException.fromDioError(e);
    } catch (e) {
      throw ApiClientException('An unexpected error occurred: $e');
    }
  }

  @override
  Future<void> deleteClient(int id) async {
    try {
      final uuid = await _resolveUuid(id);
      if (uuid == null) throw ApiClientException('Cannot resolve backend ID for client.');

      await _dio.delete('/clients/$uuid');

      // Trigger hot stream updates
      _triggerClientsUpdate();
      _triggerClientDetailUpdate(id);
    } on DioException catch (e) {
      throw ApiClientException.fromDioError(e);
    } catch (e) {
      throw ApiClientException('An unexpected error occurred: $e');
    }
  }

  @override
  Stream<List<domain.Client>> watchClients() {
    // Immediate stream seeding on subscription
    _triggerClientsUpdate();
    return _clientsController.stream;
  }

  @override
  Stream<domain.Client?> watchClientById(int id) {
    final controller = _clientDetailControllers.putIfAbsent(
      id,
      () => StreamController<domain.Client?>.broadcast(
        onListen: () => _triggerClientDetailUpdate(id),
      ),
    );
    _triggerClientDetailUpdate(id);
    return controller.stream;
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

  Future<domain.Client> _mapToDomain(Map<String, dynamic> json) async {
    final uuid = json['id'] as String;
    final id = await _idMapper.registerUuid(uuid);

    final fullName = json['name'] as String? ?? '';
    final parts = fullName.trim().split(' ');
    final firstName = parts.isNotEmpty ? parts.first : '';
    final lastName = parts.length > 1 ? parts.sublist(1).join(' ') : '';
    
    final email = json['email'] as String? ?? '';
    final phone = json['phone'] as String? ?? '';
    
    final updatedAtStr = json['updated_at'] as String? ?? json['created_at'] as String?;
    final updatedAt = updatedAtStr != null ? DateTime.parse(updatedAtStr).toLocal() : DateTime.now();

    return domain.Client(
      id: id,
      syncId: uuid,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      lastModifiedUtc: updatedAt.toUtc(),
    );
  }
}
