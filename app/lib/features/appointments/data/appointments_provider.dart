import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../shared/data/interfaces/appointment_service.dart';
import '../../../../shared/data/use_api_provider.dart';
import '../../../../shared/domain/appointment.dart' as domain;

part 'appointments_provider.g.dart';

@riverpod
AppointmentService appointmentService(Ref ref) {
  return ref.watch(globalAppointmentServiceProvider);
}

@riverpod
Stream<List<domain.Appointment>> todaysAppointments(Ref ref) {
  final service = ref.watch(appointmentServiceProvider);
  return service.watchAppointments().map((appts) {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return appts.where((a) =>
        !a.isDeleted &&
        (a.dateTime.isAfter(startOfDay) || a.dateTime.isAtSameMomentAs(startOfDay)) &&
        a.dateTime.isBefore(endOfDay)
    ).toList();
  });
}

@riverpod
Stream<List<domain.Appointment>> allAppointments(Ref ref) {
  final service = ref.watch(appointmentServiceProvider);
  return service.watchAppointments();
}

@riverpod
Stream<List<domain.Appointment>> upcomingAppointments(Ref ref) {
  final service = ref.watch(appointmentServiceProvider);
  return service.watchAppointments().map((appts) {
    final now = DateTime.now();
    return appts
        .where((a) => !a.isDeleted && a.dateTime.isAfter(now) && a.status == 'Scheduled')
        .take(10)
        .toList();
  });
}

@riverpod
Stream<domain.Appointment?> appointmentDetail(Ref ref, int id) {
  final service = ref.watch(appointmentServiceProvider);
  return service.watchAppointmentById(id);
}

@riverpod
AppointmentsService appointmentsService(Ref ref) {
  return AppointmentsService(ref);
}

class AppointmentsService {
  final Ref _ref;
  AppointmentsService(this._ref);

  AppointmentService get _service => _ref.read(appointmentServiceProvider);

  Future<void> createAppointment(domain.Appointment appointment) async {
    await _service.createAppointment(appointment);
  }

  Future<void> updateAppointment(domain.Appointment appointment) async {
    await _service.updateAppointment(appointment);
  }

  Future<void> deleteAppointment(int id) async {
    await _service.deleteAppointment(id);
  }
}
