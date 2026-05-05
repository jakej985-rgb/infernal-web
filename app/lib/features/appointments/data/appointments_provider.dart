import 'package:drift/drift.dart' show Value;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../shared/domain/appointment.dart' as domain;
import '../../../../shared/persistence/database.dart';

part 'appointments_provider.g.dart';

@riverpod
Stream<List<domain.Appointment>> todaysAppointments(Ref ref) {
  final dao = ref.watch(databaseProvider).appointmentsDao;
  return dao.watchTodaysAppointments().map(
        (rows) => rows.map((row) => _mapToDomain(row)).toList(),
      );
}

@riverpod
Stream<List<domain.Appointment>> allAppointments(Ref ref) {
  final dao = ref.watch(databaseProvider).appointmentsDao;
  return dao.watchAllAppointments().map(
        (rows) => rows.map((row) => _mapToDomain(row)).toList(),
      );
}

@riverpod
Stream<List<domain.Appointment>> upcomingAppointments(Ref ref) {
  final dao = ref.watch(databaseProvider).appointmentsDao;
  return dao.watchAllAppointments().map((rows) {
    final now = DateTime.now();
    return rows
        .where((row) => row.startTime.isAfter(now) && row.status == 'Scheduled')
        .map((row) => _mapToDomain(row))
        .take(10) // Limit to 10
        .toList();
  });
}

@riverpod
Stream<domain.Appointment?> appointmentDetail(Ref ref, int id) {
  final dao = ref.watch(databaseProvider).appointmentsDao;
  return dao
      .watchAppointmentById(id)
      .map((row) => row == null ? null : _mapToDomain(row));
}

@riverpod
AppointmentsService appointmentsService(Ref ref) {
  return AppointmentsService(ref);
}

// Mapper
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

class AppointmentsService {
  final Ref _ref;
  AppointmentsService(this._ref);

  Future<void> createAppointment(domain.Appointment appointment) async {
    final dao = _ref.read(databaseProvider).appointmentsDao;
    await dao.insertAppointment(AppointmentsCompanion(
      clientId: Value(appointment.clientId),
      userId: Value(appointment.userId),
      clientName: Value(appointment.clientName),
      startTime: Value(appointment.dateTime),
      durationMinutes: Value(appointment.durationMinutes),
      serviceType: Value(appointment.serviceType),
      serviceCategory: Value(appointment.serviceCategory),
      priceType: Value(appointment.priceType),
      priceCharged: Value(appointment.priceCharged),
      notes: Value(appointment.notes),
      status: Value(appointment.status),
      modifiedAt: Value(DateTime.now()),
      // syncId handled by DAO defaults
    ));
  }

  Future<void> updateAppointment(domain.Appointment appointment) async {
    final dao = _ref.read(databaseProvider).appointmentsDao;
    // Map domain -> row
    final row = Appointment(
      id: appointment.id,
      syncId: appointment.syncId,
      clientId: appointment.clientId,
      userId: appointment.userId,
      clientName: appointment.clientName,
      startTime: appointment.dateTime,
      durationMinutes: appointment.durationMinutes,
      serviceType: appointment.serviceType,
      serviceCategory: appointment.serviceCategory,
      priceType: appointment.priceType,
      priceCharged: appointment.priceCharged,
      quotedPrice: appointment.quotedPrice,
      finalPrice: appointment.finalPrice,
      notes: appointment.notes,
      photoPath: appointment.photoPath,
      color: appointment.color,
      status: appointment.status,
      isBlockOff: appointment.isBlockOff,
      modifiedAt: DateTime.now(),
      lastModifiedBy: 'user', 
      isDeleted: appointment.isDeleted,
    );
    await dao.updateAppointment(row);
  }

  Future<void> deleteAppointment(int id) async {
    final dao = _ref.read(databaseProvider).appointmentsDao;
    await dao.softDeleteAppointment(id);
  }
}
