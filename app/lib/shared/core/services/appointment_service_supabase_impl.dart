import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart' as uuid;

import '../../cache/id_mapper.dart';
import '../../domain/appointment.dart' as domain;
import '../../data/interfaces/appointment_service.dart';
import '../../data/org_provider.dart';

class AppointmentServiceSupabaseImpl implements AppointmentService {
  final Ref _ref;
  AppointmentServiceSupabaseImpl(this._ref);

  IdMapper get _idMapper => _ref.read(idMapperProvider);
  String get _orgId => _ref.read(orgIdProvider);

  @override
  Future<List<domain.Appointment>> getAppointments() async {
    try {
      final client = sb.Supabase.instance.client;
      final response = await client
          .from('appointments')
          .select()
          .eq('org_id', _orgId)
          .eq('is_deleted', false);
      
      final appointments = <domain.Appointment>[];
      for (final row in response) {
        appointments.add(await _mapRowToDomain(row));
      }
      return appointments;
    } catch (e) {
      throw Exception('Failed to get appointments: $e');
    }
  }

  @override
  Future<domain.Appointment?> getAppointmentById(int id) async {
    try {
      final uuidVal = _idMapper.getUuid('appointment', id);
      if (uuidVal == null) return null;

      final client = sb.Supabase.instance.client;
      final row = await client
          .from('appointments')
          .select()
          .eq('id', uuidVal)
          .maybeSingle();
      if (row == null) return null;
      return await _mapRowToDomain(row);
    } catch (e) {
      throw Exception('Failed to get appointment: $e');
    }
  }

  @override
  Future<void> createAppointment(domain.Appointment appointment) async {
    try {
      final clientUuid = _idMapper.getUuid('client', appointment.clientId);
      if (clientUuid == null) {
        throw Exception('Cannot resolve ID for client.');
      }

      final uuidVal = const uuid.Uuid().v4();
      final supabaseClient = sb.Supabase.instance.client;

      await supabaseClient.from('appointments').insert({
        'id': uuidVal,
        'org_id': _orgId,
        'client_id': clientUuid,
        'client_name': appointment.clientName,
        'title': appointment.serviceType,
        'notes': appointment.notes ?? '',
        'start_time': appointment.dateTime.toUtc().toIso8601String(),
        'end_time': appointment.dateTime
            .add(Duration(minutes: appointment.durationMinutes))
            .toUtc()
            .toIso8601String(),
        'status': appointment.status,
        'price_charged': appointment.priceCharged,
        'final_price': appointment.finalPrice,
        'is_deleted': false,
        'created_at': DateTime.now().toUtc().toIso8601String(),
        'updated_at': DateTime.now().toUtc().toIso8601String(),
      });

      await _idMapper.registerUuid('appointment', uuidVal);
    } catch (e) {
      throw Exception('Failed to create appointment: $e');
    }
  }

  @override
  Future<void> updateAppointment(domain.Appointment appointment) async {
    try {
      final uuidVal = _idMapper.getUuid('appointment', appointment.id);
      if (uuidVal == null) throw Exception('Cannot resolve ID for appointment.');

      final clientUuid = _idMapper.getUuid('client', appointment.clientId);
      if (clientUuid == null) throw Exception('Cannot resolve ID for client.');

      final supabaseClient = sb.Supabase.instance.client;
      await supabaseClient.from('appointments').update({
        'client_id': clientUuid,
        'client_name': appointment.clientName,
        'title': appointment.serviceType,
        'notes': appointment.notes ?? '',
        'start_time': appointment.dateTime.toUtc().toIso8601String(),
        'end_time': appointment.dateTime
            .add(Duration(minutes: appointment.durationMinutes))
            .toUtc()
            .toIso8601String(),
        'status': appointment.status,
        'price_charged': appointment.priceCharged,
        'final_price': appointment.finalPrice,
        'updated_at': DateTime.now().toUtc().toIso8601String(),
      }).eq('id', uuidVal);
    } catch (e) {
      throw Exception('Failed to update appointment: $e');
    }
  }

  @override
  Future<void> deleteAppointment(int id) async {
    try {
      final uuidVal = _idMapper.getUuid('appointment', id);
      if (uuidVal == null) throw Exception('Cannot resolve ID for appointment.');

      final supabaseClient = sb.Supabase.instance.client;
      await supabaseClient.from('appointments').update({
        'is_deleted': true,
        'updated_at': DateTime.now().toUtc().toIso8601String(),
      }).eq('id', uuidVal);
    } catch (e) {
      throw Exception('Failed to delete appointment: $e');
    }
  }

  @override
  Stream<List<domain.Appointment>> watchAppointments() {
    final client = sb.Supabase.instance.client;
    return client
        .from('appointments')
        .stream(primaryKey: ['id'])
        .eq('org_id', _orgId)
        .asyncMap((data) async {
          final appointments = <domain.Appointment>[];
          for (final row in data) {
            if (row['is_deleted'] == true) continue;
            appointments.add(await _mapRowToDomain(row));
          }
          return appointments;
        });
  }

  @override
  Stream<domain.Appointment?> watchAppointmentById(int id) {
    final uuidVal = _idMapper.getUuid('appointment', id);
    if (uuidVal == null) {
      return Stream.value(null);
    }
    final client = sb.Supabase.instance.client;
    return client
        .from('appointments')
        .stream(primaryKey: ['id'])
        .eq('id', uuidVal)
        .asyncMap((data) async {
          if (data.isEmpty || data.first['is_deleted'] == true) return null;
          return await _mapRowToDomain(data.first);
        });
  }

  Future<domain.Appointment> _mapRowToDomain(
    Map<String, dynamic> row,
  ) async {
    final uuidVal = row['id'] as String;
    final id = await _idMapper.registerUuid('appointment', uuidVal);

    final clientUuid = row['client_id'] as String? ?? '';
    final clientId = await _idMapper.registerUuid('client', clientUuid);

    final clientName = row['client_name'] as String? ?? '';
    final title = row['title'] as String? ?? '';
    final notes = row['notes'] as String? ?? '';

    final startTimeStr = row['start_time'] as String? ?? '';
    final endTimeStr = row['end_time'] as String? ?? '';

    final startTime = startTimeStr.isNotEmpty
        ? DateTime.parse(startTimeStr).toLocal()
        : DateTime.now();
    final endTime = endTimeStr.isNotEmpty
        ? DateTime.parse(endTimeStr).toLocal()
        : DateTime.now();
    final duration = endTime.difference(startTime).inMinutes;

    final status = row['status'] as String? ?? 'Scheduled';
    final priceCharged = (row['price_charged'] as num?)?.toDouble() ?? 0.0;
    final finalPrice = (row['final_price'] as num?)?.toDouble();

    final updatedAt = DateTime.parse(row['updated_at'] as String? ?? row['created_at'] as String);

    return domain.Appointment(
      id: id,
      syncId: uuidVal,
      clientId: clientId,
      userId: 1, // Default local user ID
      clientName: clientName,
      dateTime: startTime,
      durationMinutes: duration,
      serviceType: title,
      notes: notes,
      status: status,
      priceCharged: priceCharged,
      finalPrice: finalPrice,
      lastModifiedUtc: updatedAt.toUtc(),
      isDeleted: row['is_deleted'] as bool? ?? false,
    );
  }
}
