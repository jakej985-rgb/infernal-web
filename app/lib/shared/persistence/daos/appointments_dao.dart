import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../database.dart';
import '../tables/appointments_table.dart';

part 'appointments_dao.g.dart';

/// Data Access Object for Appointments table
@DriftAccessor(tables: [Appointments])
class AppointmentsDao extends DatabaseAccessor<AppDatabase>
    with _$AppointmentsDaoMixin {
  AppointmentsDao(super.db);

  static const _uuid = Uuid();

  /// Get all non-deleted appointments
  Future<List<Appointment>> getAllAppointments() {
    return (select(appointments)
          ..where((a) => a.isDeleted.equals(false))
          ..orderBy([(a) => OrderingTerm.asc(a.startTime)]))
        .get();
  }

  /// Watch all non-deleted appointments
  Stream<List<Appointment>> watchAllAppointments() {
    return (select(appointments)
          ..where((a) => a.isDeleted.equals(false))
          ..orderBy([(a) => OrderingTerm.asc(a.startTime)]))
        .watch();
  }

  /// Get appointment by ID
  Future<Appointment?> getAppointmentById(int id) {
    return (select(
      appointments,
    )..where((a) => a.id.equals(id))).getSingleOrNull();
  }

  /// Watch appointment by ID
  Stream<Appointment?> watchAppointmentById(int id) {
    return (select(appointments)..where((a) => a.id.equals(id)))
        .watchSingleOrNull();
  }

  /// Get appointments by date (for a specific day)
  Future<List<Appointment>> getAppointmentsByDate(DateTime date) {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return (select(appointments)
          ..where(
            (a) =>
                a.isDeleted.equals(false) &
                a.startTime.isBiggerOrEqualValue(startOfDay) &
                a.startTime.isSmallerThanValue(endOfDay),
          )
          ..orderBy([(a) => OrderingTerm.asc(a.startTime)]))
        .get();
  }

  /// Watch appointments for today
  Stream<List<Appointment>> watchTodaysAppointments() {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return (select(appointments)
          ..where(
            (a) =>
                a.isDeleted.equals(false) &
                a.startTime.isBiggerOrEqualValue(startOfDay) &
                a.startTime.isSmallerThanValue(endOfDay),
          )
          ..orderBy([(a) => OrderingTerm.asc(a.startTime)]))
        .watch();
  }

  /// Get appointments by date range
  Future<List<Appointment>> getAppointmentsByDateRange(
    DateTime start,
    DateTime end,
  ) {
    return (select(appointments)
          ..where(
            (a) =>
                a.isDeleted.equals(false) &
                a.startTime.isBiggerOrEqualValue(start) &
                a.startTime.isSmallerOrEqualValue(end),
          )
          ..orderBy([(a) => OrderingTerm.asc(a.startTime)]))
        .get();
  }

  /// Get appointments by artist (user ID)
  Future<List<Appointment>> getAppointmentsByArtist(int userId) {
    return (select(appointments)
          ..where((a) => a.isDeleted.equals(false) & a.userId.equals(userId))
          ..orderBy([(a) => OrderingTerm.asc(a.startTime)]))
        .get();
  }

  /// Get appointments by client
  Future<List<Appointment>> getAppointmentsByClient(int clientId) {
    return (select(appointments)
          ..where(
            (a) => a.isDeleted.equals(false) & a.clientId.equals(clientId),
          )
          ..orderBy([(a) => OrderingTerm.desc(a.startTime)]))
        .get();
  }

  /// Get appointments by status
  Future<List<Appointment>> getAppointmentsByStatus(String status) {
    return (select(appointments)
          ..where((a) => a.isDeleted.equals(false) & a.status.equals(status))
          ..orderBy([(a) => OrderingTerm.asc(a.startTime)]))
        .get();
  }

  /// Get upcoming appointments (future from now)
  Future<List<Appointment>> getUpcomingAppointments({int limit = 10}) {
    return (select(appointments)
          ..where(
            (a) =>
                a.isDeleted.equals(false) &
                a.startTime.isBiggerThanValue(DateTime.now()) &
                a.status.equals('Scheduled'),
          )
          ..orderBy([(a) => OrderingTerm.asc(a.startTime)])
          ..limit(limit))
        .get();
  }

  /// Insert a new appointment
  Future<int> insertAppointment(AppointmentsCompanion appointment) {
    final withSyncId = appointment.syncId.present
        ? appointment
        : appointment.copyWith(syncId: Value(_uuid.v4()));
    return into(appointments).insert(withSyncId);
  }

  /// Update an existing appointment
  Future<bool> updateAppointment(Appointment appointment) {
    return update(appointments).replace(appointment);
  }

  /// Update appointment status
  Future<int> updateStatus(int id, String status) {
    return (update(appointments)..where((a) => a.id.equals(id))).write(
      AppointmentsCompanion(
        status: Value(status),
        modifiedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Soft delete an appointment
  Future<int> softDeleteAppointment(int id) {
    return (update(appointments)..where((a) => a.id.equals(id))).write(
      AppointmentsCompanion(
        isDeleted: const Value(true),
        modifiedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Hard delete an appointment
  Future<int> deleteAppointment(int id) {
    return (delete(appointments)..where((a) => a.id.equals(id))).go();
  }

  /// Count appointments for today
  Future<int> countTodaysAppointments() async {
    final list = await getAppointmentsByDate(DateTime.now());
    return list.where((a) => !a.isBlockOff).length;
  }

  /// Count upcoming scheduled appointments
  Future<int> countUpcomingAppointments() async {
    final list = await getUpcomingAppointments(limit: 1000);
    return list.length;
  }
}
