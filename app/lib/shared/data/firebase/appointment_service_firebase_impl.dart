import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared/cache/id_mapper.dart';
import '../../domain/appointment.dart' as domain;
import '../interfaces/appointment_service.dart';

part 'appointment_service_firebase_impl.g.dart';

@riverpod
AppointmentServiceFirebaseImpl appointmentServiceFirebaseImpl(Ref ref) {
  return AppointmentServiceFirebaseImpl(ref);
}

class AppointmentServiceFirebaseImpl implements AppointmentService {
  final Ref _ref;
  AppointmentServiceFirebaseImpl(this._ref);

  IdMapper get _idMapper => _ref.read(idMapperProvider);
  FirebaseFirestore get _firestore => FirebaseFirestore.instance;

  static const String _orgId = 'default-org';

  CollectionReference<Map<String, dynamic>> get _apptsRef =>
      _firestore.collection('organizations').doc(_orgId).collection('appointments');

  @override
  Future<List<domain.Appointment>> getAppointments() async {
    try {
      final snapshot = await _apptsRef.where('isDeleted', isEqualTo: false).get();
      final appointments = <domain.Appointment>[];
      for (final doc in snapshot.docs) {
        appointments.add(await _mapDocToDomain(doc));
      }
      return appointments;
    } catch (e) {
      throw Exception('Failed to get appointments: $e');
    }
  }

  @override
  Future<domain.Appointment?> getAppointmentById(int id) async {
    try {
      final uuid = _idMapper.getUuid('appointment', id);
      if (uuid == null) return null;

      final doc = await _apptsRef.doc(uuid).get();
      if (!doc.exists) return null;
      return await _mapDocToDomain(doc);
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

      final docRef = _apptsRef.doc();
      final uuid = docRef.id;

      await docRef.set({
        'client_id': clientUuid,
        'client_name': appointment.clientName,
        'title': appointment.serviceType,
        'notes': appointment.notes ?? '',
        'start_time': appointment.dateTime.toUtc().toIso8601String(),
        'end_time': appointment.dateTime.add(Duration(minutes: appointment.durationMinutes)).toUtc().toIso8601String(),
        'isDeleted': false,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      await _idMapper.registerUuid('appointment', uuid);
    } catch (e) {
      throw Exception('Failed to create appointment: $e');
    }
  }

  @override
  Future<void> updateAppointment(domain.Appointment appointment) async {
    try {
      final uuid = _idMapper.getUuid('appointment', appointment.id);
      if (uuid == null) throw Exception('Cannot resolve ID for appointment.');

      final clientUuid = _idMapper.getUuid('client', appointment.clientId);
      if (clientUuid == null) throw Exception('Cannot resolve ID for client.');

      await _apptsRef.doc(uuid).update({
        'client_id': clientUuid,
        'client_name': appointment.clientName,
        'title': appointment.serviceType,
        'notes': appointment.notes ?? '',
        'start_time': appointment.dateTime.toUtc().toIso8601String(),
        'end_time': appointment.dateTime.add(Duration(minutes: appointment.durationMinutes)).toUtc().toIso8601String(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to update appointment: $e');
    }
  }

  @override
  Future<void> deleteAppointment(int id) async {
    try {
      final uuid = _idMapper.getUuid('appointment', id);
      if (uuid == null) throw Exception('Cannot resolve ID for appointment.');

      await _apptsRef.doc(uuid).update({
        'isDeleted': true,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to delete appointment: $e');
    }
  }

  @override
  Stream<List<domain.Appointment>> watchAppointments() {
    return _apptsRef
        .where('isDeleted', isEqualTo: false)
        .snapshots()
        .asyncMap((snapshot) async {
      final appointments = <domain.Appointment>[];
      for (final doc in snapshot.docs) {
        appointments.add(await _mapDocToDomain(doc));
      }
      return appointments;
    });
  }

  @override
  Stream<domain.Appointment?> watchAppointmentById(int id) {
    final uuid = _idMapper.getUuid('appointment', id);
    if (uuid == null) {
      return Stream.value(null);
    }
    return _apptsRef.doc(uuid).snapshots().asyncMap((doc) async {
      if (!doc.exists) return null;
      return await _mapDocToDomain(doc);
    });
  }

  Future<domain.Appointment> _mapDocToDomain(DocumentSnapshot<Map<String, dynamic>> doc) async {
    final uuid = doc.id;
    final id = await _idMapper.registerUuid('appointment', uuid);

    final data = doc.data() ?? {};
    final clientUuid = data['client_id'] as String? ?? '';
    final clientId = await _idMapper.registerUuid('client', clientUuid);

    final clientName = data['client_name'] as String? ?? '';
    final title = data['title'] as String? ?? '';
    final notes = data['notes'] as String? ?? '';

    final startTimeStr = data['start_time'] as String? ?? '';
    final endTimeStr = data['end_time'] as String? ?? '';

    final startTime = startTimeStr.isNotEmpty ? DateTime.parse(startTimeStr).toLocal() : DateTime.now();
    final endTime = endTimeStr.isNotEmpty ? DateTime.parse(endTimeStr).toLocal() : DateTime.now();
    final duration = endTime.difference(startTime).inMinutes;

    final updatedAtTimestamp = data['updatedAt'] as Timestamp?;
    final updatedAt = updatedAtTimestamp?.toDate() ?? DateTime.now();

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
      isDeleted: data['isDeleted'] as bool? ?? false,
    );
  }
}
