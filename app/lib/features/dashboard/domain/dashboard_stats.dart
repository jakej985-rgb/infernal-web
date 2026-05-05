import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_stats.freezed.dart';

@freezed
abstract class DashboardStats with _$DashboardStats {
  const factory DashboardStats({
    required int todayRituals,
    required int boundSouls,
    required int openScrolls,
    required int pending,
  }) = _DashboardStats;

  factory DashboardStats.initial() => const DashboardStats(
    todayRituals: 0,
    boundSouls: 0,
    openScrolls: 0,
    pending: 0,
  );
}
