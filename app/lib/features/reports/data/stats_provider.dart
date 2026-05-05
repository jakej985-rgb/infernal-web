import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../shared/persistence/database.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rxdart/rxdart.dart';

part 'stats_provider.freezed.dart';
part 'stats_provider.g.dart';

@freezed
abstract class ShopOverviewStats with _$ShopOverviewStats {
  const factory ShopOverviewStats({
    required double totalRevenue,
    required int totalClients,
    required int completedAppointments,
    required int upcomingAppointments,
    required Map<String, int> appointmentsByStatus,
    required List<RevenueDataPoint> revenueOverTime,
  }) = _ShopOverviewStats;
}

class RevenueDataPoint {
  final DateTime date;
  final double amount;

  const RevenueDataPoint({
    required this.date,
    required this.amount,
  });
}

@riverpod
Stream<ShopOverviewStats> shopOverviewStats(Ref ref) {
  final db = ref.watch(databaseProvider);
  
  // Watch all relevant tables to trigger updates
  final appointmentsStream = db.appointmentsDao.watchAllAppointments();
  final clientsStream = db.clientsDao.watchAllClients();
  
  return Rx.combineLatest2(appointmentsStream, clientsStream, (appointments, clients) {
    double revenue = 0;
    int completed = 0;
    int upcoming = 0;
    final statusMap = <String, int>{};
    final revenueMap = <DateTime, double>{};
    
    final now = DateTime.now();
    
    for (final appt in appointments) {
      final status = appt.status.toLowerCase();
      statusMap[status] = (statusMap[status] ?? 0) + 1;
      
      if (status == 'completed') {
        completed++;
        final price = appt.finalPrice ?? appt.priceCharged;
        revenue += price;
        
        final date = DateTime(appt.startTime.year, appt.startTime.month, appt.startTime.day);
        revenueMap[date] = (revenueMap[date] ?? 0) + price;
      } else if (appt.startTime.isAfter(now) && status != 'cancelled') {
        upcoming++;
      }
    }
    
    final sortedRevenuePoints = revenueMap.entries
        .map((e) => RevenueDataPoint(date: e.key, amount: e.value))
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));
    
    return ShopOverviewStats(
      totalRevenue: revenue,
      totalClients: clients.length,
      completedAppointments: completed,
      upcomingAppointments: upcoming,
      appointmentsByStatus: statusMap,
      revenueOverTime: sortedRevenuePoints,
    );
  });
}
