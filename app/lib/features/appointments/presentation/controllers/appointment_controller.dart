import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/appointments_provider.dart';
import '../../../../shared/domain/appointment.dart';

final appointmentControllerProvider = Provider((ref) {
  return AppointmentController(ref);
});

class AppointmentController {
  final Ref ref;
  AppointmentController(this.ref);

  Future<void> createAppointment(Appointment data) async {
    final service = ref.read(appointmentsServiceProvider);
    await service.createAppointment(data);
  }

  Future<void> updateAppointment(Appointment data) async {
    final service = ref.read(appointmentsServiceProvider);
    await service.updateAppointment(data);
  }

  Future<void> deleteAppointment(int id) async {
    final service = ref.read(appointmentsServiceProvider);
    await service.deleteAppointment(id);
  }
}
