import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../shared/persistence/database.dart';
import '../domain/dashboard_stats.dart';

part 'stats_repository.g.dart';

@riverpod
class DashboardStatsRepository extends _$DashboardStatsRepository {
  @override
  Stream<DashboardStats> build() {
    final db = ref.watch(databaseProvider);

    // Today's Rituals (Appointments started today)
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final todayRitualsStream =
        (db.select(db.appointments)
              ..where((t) => t.startTime.isBetweenValues(startOfDay, endOfDay)))
            .watch()
            .map((rows) => rows.length);

    // Bound Souls (Total Clients)
    final boundSoulsStream = db
        .select(db.clients)
        .watch()
        .map((rows) => rows.length);

    // Open Scrolls (Total Quotes)
    final openScrollsStream = db
        .select(db.quotes)
        .watch()
        .map((rows) => rows.length);

    // Pending (Appointments in future)
    final pendingStream =
        (db.select(db.appointments)
              ..where((t) => t.startTime.isBiggerThanValue(endOfDay)))
            .watch()
            .map((rows) => rows.length);

    return CombineLatestStream.list([
      todayRitualsStream,
      boundSoulsStream,
      openScrollsStream,
      pendingStream,
    ]).map((counts) {
      return DashboardStats(
        todayRituals: counts[0],
        boundSouls: counts[1],
        openScrolls: counts[2],
        pending: counts[3],
      );
    });
  }
}

/// Provider for today's appointments - using raw StreamProvider to avoid generator issues with Drift types
final dashboardTodayAppointmentsProvider = StreamProvider<List<Appointment>>((ref) {
  final db = ref.watch(databaseProvider);
  final now = DateTime.now();
  final startOfDay = DateTime(now.year, now.month, now.day);
  final endOfDay = startOfDay.add(const Duration(days: 1));

  return (db.select(db.appointments)
        ..where((t) => t.startTime.isBetweenValues(startOfDay, endOfDay))
        ..orderBy([(t) => OrderingTerm(expression: t.startTime)]))
      .watch();
});

