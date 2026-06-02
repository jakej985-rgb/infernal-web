import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';
import '../../appointments/data/appointments_provider.dart';
import '../../clients/data/clients_provider.dart';
import '../../../../shared/domain/appointment.dart' as domain;
import '../domain/dashboard_stats.dart';

part 'stats_repository.g.dart';

@riverpod
class DashboardStatsRepository extends _$DashboardStatsRepository {
  @override
  Stream<DashboardStats> build() {
    final apptsStream = ref
        .watch(appointmentServiceProvider)
        .watchAppointments();
    final clientsStream = ref.watch(clientServiceProvider).watchClients();

    return Rx.combineLatest2(apptsStream, clientsStream, (
      appointments,
      clients,
    ) {
      final now = DateTime.now();
      final todayStart = DateTime(now.year, now.month, now.day);
      final todayEnd = todayStart.add(const Duration(days: 1));

      int todayRituals = 0;
      int pending = 0;

      for (final appt in appointments) {
        if (appt.isDeleted) continue;
        if ((appt.dateTime.isAfter(todayStart) ||
                appt.dateTime.isAtSameMomentAs(todayStart)) &&
            appt.dateTime.isBefore(todayEnd)) {
          todayRituals++;
        } else if (appt.dateTime.isAfter(todayEnd)) {
          pending++;
        }
      }

      return DashboardStats(
        todayRituals: todayRituals,
        boundSouls: clients.length,
        openScrolls: 0, // Quotes is fully deprecated/stubbed
        pending: pending,
      );
    });
  }
}

final dashboardTodayAppointmentsProvider =
    Provider<AsyncValue<List<domain.Appointment>>>((ref) {
      return ref.watch(todaysAppointmentsProvider);
    });
