import 'dart:async';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared/cache/id_mapper.dart';
import '../../domain/appointment.dart' as domain;
import '../../util/api_client.dart';
import '../interfaces/appointment_service.dart';

part 'appointment_service_api_impl.g.dart';

@riverpod
AppointmentServiceApiImpl appointmentServiceApiImpl(Ref ref) {
  return AppointmentServiceApiImpl(ref);
}

class AppointmentServiceApiImpl implements AppointmentService {
  final Ref _ref;
  AppointmentServiceApiImpl(this._ref);

  IdMapper get _idMapper => _ref.read(idMapperProvider);
  Dio get _dio => _ref.read(apiClientProvider);

  // Broadcast controllers for reactive real-time updates
  final _apptsController = StreamController<List<domain.Appointment>>.broadcast();
  final _apptDetailControllers = <int, StreamController<domain.Appointment?>>{};

  // Single-flight deduplication fields to prevent API refetch storms
  Future<List<domain.Appointment>>? _pendingApptsFetch;
  final Map<int, Future<domain.Appointment?>> _pendingApptFetch = {};

  void _triggerApptsUpdate() async {
    try {
      final appts = await _getApptsDeduplicated();
      if (!_apptsController.isClosed) {
        _apptsController.add(appts);
      }
    } catch (e) {
      if (!_apptsController.isClosed) {
        _apptsController.addError(e);
      }
    }
  }

  void _triggerApptDetailUpdate(int id) async {
    try {
      final appt = await _getApptByIdDeduplicated(id);
      final controller = _apptDetailControllers[id];
      if (controller != null && !controller.isClosed) {
        controller.add(appt);
      }
    } catch (e) {
      final controller = _apptDetailControllers[id];
      if (controller != null && !controller.isClosed) {
        controller.addError(e);
      }
    }
  }

  Future<List<domain.Appointment>> _getApptsDeduplicated() {
    if (_pendingApptsFetch != null) return _pendingApptsFetch!;
    _pendingApptsFetch = getAppointments().whenComplete(() {
      _pendingApptsFetch = null;
    });
    return _pendingApptsFetch!;
  }

  Future<domain.Appointment?> _getApptByIdDeduplicated(int id) {
    if (_pendingApptFetch.containsKey(id)) return _pendingApptFetch[id]!;
    final fut = getAppointmentById(id).whenComplete(() {
      _pendingApptFetch.remove(id);
    });
    _pendingApptFetch[id] = fut;
    return fut;
  }

  Future<String?> _resolveUuid(int id) async {
    final uuid = _idMapper.getUuid('appointment', id);
    if (uuid != null) return uuid;

    // If UUID mapping is missing locally, resolve it by loading list of appointments
    await _getApptsDeduplicated();
    return _idMapper.getUuid('appointment', id);
  }

  @override
  Future<List<domain.Appointment>> getAppointments() async {
    try {
      final response = await _dio.get('/appointments');
      final rawList = response.data as List;
      
      final appointments = <domain.Appointment>[];
      for (final item in rawList) {
        final map = item as Map<String, dynamic>;
        appointments.add(await _mapToDomain(map));
      }
      return appointments;
    } on DioException catch (e) {
      throw ApiClientException.fromDioError(e);
    } catch (e) {
      throw ApiClientException('An unexpected error occurred: $e');
    }
  }

  @override
  Future<domain.Appointment?> getAppointmentById(int id) async {
    try {
      final uuid = await _resolveUuid(id);
      if (uuid == null) return null;

      final response = await _dio.get('/appointments/$uuid');
      return await _mapToDomain(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiClientException.fromDioError(e);
    } catch (e) {
      throw ApiClientException('An unexpected error occurred: $e');
    }
  }

  @override
  Future<void> createAppointment(domain.Appointment appointment) async {
    try {
      final clientUuid = _idMapper.getUuid('client', appointment.clientId);
      if (clientUuid == null) {
        throw ApiClientException('Cannot resolve backend ID for client.');
      }

      final payload = {
        'client_id': clientUuid,
        'title': appointment.serviceType,
        'notes': appointment.notes ?? '',
        'start_time': appointment.dateTime.toUtc().toIso8601String(),
        'end_time': appointment.dateTime.add(Duration(minutes: appointment.durationMinutes)).toUtc().toIso8601String(),
      };

      final response = await _dio.post('/appointments', data: payload);
      final uuid = (response.data as Map<String, dynamic>)['id'] as String;
      
      // Warm up map cache
      await _idMapper.registerUuid('appointment', uuid);

      // Trigger hot stream refresh for active subscribers
      _triggerApptsUpdate();
    } on DioException catch (e) {
      throw ApiClientException.fromDioError(e);
    } catch (e) {
      throw ApiClientException('An unexpected error occurred: $e');
    }
  }

  @override
  Future<void> updateAppointment(domain.Appointment appointment) async {
    try {
      final uuid = await _resolveUuid(appointment.id);
      if (uuid == null) {
        throw ApiClientException('Cannot resolve backend ID for appointment.');
      }

      final clientUuid = _idMapper.getUuid('client', appointment.clientId);
      if (clientUuid == null) {
        throw ApiClientException('Cannot resolve backend ID for client.');
      }

      final payload = {
        'client_id': clientUuid,
        'title': appointment.serviceType,
        'notes': appointment.notes ?? '',
        'start_time': appointment.dateTime.toUtc().toIso8601String(),
        'end_time': appointment.dateTime.add(Duration(minutes: appointment.durationMinutes)).toUtc().toIso8601String(),
      };

      await _dio.put('/appointments/$uuid', data: payload);

      // Trigger hot stream updates
      _triggerApptsUpdate();
      _triggerApptDetailUpdate(appointment.id);
    } on DioException catch (e) {
      throw ApiClientException.fromDioError(e);
    } catch (e) {
      throw ApiClientException('An unexpected error occurred: $e');
    }
  }

  @override
  Future<void> deleteAppointment(int id) async {
    try {
      final uuid = await _resolveUuid(id);
      if (uuid == null) {
        throw ApiClientException('Cannot resolve backend ID for appointment.');
      }

      await _dio.delete('/appointments/$uuid');

      // Trigger hot stream updates
      _triggerApptsUpdate();
      _triggerApptDetailUpdate(id);
    } on DioException catch (e) {
      throw ApiClientException.fromDioError(e);
    } catch (e) {
      throw ApiClientException('An unexpected error occurred: $e');
    }
  }

  @override
  Stream<List<domain.Appointment>> watchAppointments() {
    // Immediate stream seeding on subscription
    _triggerApptsUpdate();
    return _apptsController.stream;
  }

  @override
  Stream<domain.Appointment?> watchAppointmentById(int id) {
    final controller = _apptDetailControllers.putIfAbsent(
      id,
      () => StreamController<domain.Appointment?>.broadcast(
        onListen: () => _triggerApptDetailUpdate(id),
      ),
    );
    _triggerApptDetailUpdate(id);
    return controller.stream;
  }

  Future<domain.Appointment> _mapToDomain(Map<String, dynamic> json) async {
    final uuid = json['id'] as String;
    final id = await _idMapper.registerUuid('appointment', uuid);

    final clientUuid = json['client_id'] as String;
    final clientId = await _idMapper.registerUuid('client', clientUuid);

    final clientName = json['client_name'] as String? ?? '';
    final title = json['title'] as String? ?? '';
    final notes = json['notes'] as String? ?? '';
    
    final startTimeStr = json['start_time'] as String;
    final endTimeStr = json['end_time'] as String;
    
    final startTime = DateTime.parse(startTimeStr).toLocal();
    final endTime = DateTime.parse(endTimeStr).toLocal();
    final duration = endTime.difference(startTime).inMinutes;

    final updatedAtStr = json['updated_at'] as String? ?? json['created_at'] as String?;
    final updatedAt = updatedAtStr != null ? DateTime.parse(updatedAtStr).toLocal() : DateTime.now();

    return domain.Appointment(
      id: id,
      syncId: uuid,
      clientId: clientId,
      userId: 1, // Default local user ID
      clientName: clientName,
      dateTime: startTime,
      durationMinutes: duration,
      serviceType: title,
      notes: notes,
      lastModifiedUtc: updatedAt.toUtc(),
      isDeleted: false,
    );
  }
}
