import '../../domain/appointment.dart';

abstract class AppointmentService {
  Future<List<Appointment>> getAppointments();
  Future<Appointment?> getAppointmentById(int id);
  Future<void> createAppointment(Appointment appointment);
  Future<void> updateAppointment(Appointment appointment);
  Future<void> deleteAppointment(int id);
  Stream<List<Appointment>> watchAppointments();
  Stream<Appointment?> watchAppointmentById(int id);
}
