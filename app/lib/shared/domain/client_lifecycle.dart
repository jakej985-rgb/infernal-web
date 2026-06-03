import 'appointment.dart';
import 'client.dart';
import 'enums.dart';

enum ClientLifecycleLabel {
  newClient,
  active,
  inactive;

  String get displayName {
    switch (this) {
      case ClientLifecycleLabel.newClient:
        return 'New';
      case ClientLifecycleLabel.active:
        return 'Active';
      case ClientLifecycleLabel.inactive:
        return 'Inactive';
    }
  }
}

ClientLifecycleLabel deriveClientLifecycle({
  required Client client,
  required Iterable<Appointment> appointments,
  required DateTime now,
}) {
  final createdAt = client.createdAt.toUtc();
  final nowUtc = now.toUtc();

  if (!createdAt.isAfter(nowUtc) &&
      nowUtc.difference(createdAt) <= const Duration(days: 7)) {
    return ClientLifecycleLabel.newClient;
  }

  final inactiveCutoff = DateTime.utc(
    nowUtc.year - 2,
    nowUtc.month,
    nowUtc.day,
    nowUtc.hour,
    nowUtc.minute,
    nowUtc.second,
    nowUtc.millisecond,
    nowUtc.microsecond,
  );

  final hasRecentCompletedVisit = appointments.any((appointment) {
    if (appointment.clientId != client.id || appointment.isDeleted) {
      return false;
    }
    if (appointment.statusEnum != AppointmentStatus.completed) {
      return false;
    }
    final visitDate = appointment.dateTime.toUtc();
    return !visitDate.isAfter(nowUtc) && !visitDate.isBefore(inactiveCutoff);
  });

  return hasRecentCompletedVisit
      ? ClientLifecycleLabel.active
      : ClientLifecycleLabel.inactive;
}
