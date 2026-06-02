import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../app/theme/tokens.dart';
import '../data/stats_provider.dart';
import '../../../shared/data/infernal_labels_provider.dart';

class StatsOverviewPage extends ConsumerWidget {
  const StatsOverviewPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(shopOverviewStatsProvider);
    final useInfernal = ref.watch(useInfernalLabelsProvider);

    return Scaffold(
      backgroundColor: InfernalColors.background,
      appBar: AppBar(
        title: Text(UiLabels.get('stats_title', useInfernal)),
        backgroundColor: InfernalColors.surface,
        foregroundColor: InfernalColors.textPrimary,
      ),
      body: statsAsync.when(
        data: (stats) => _buildBody(context, stats),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildBody(BuildContext context, ShopOverviewStats stats) {
    return ListView(
      padding: const EdgeInsets.all(InfernalSpacing.lg),
      children: [
        _buildMetricGrid(stats),
        const SizedBox(height: InfernalSpacing.xl),
        _buildRevenueChart(context, stats),
        const SizedBox(height: InfernalSpacing.xl),
        _buildStatusSection(context, stats),
      ],
    );
  }

  Widget _buildMetricGrid(ShopOverviewStats stats) {
    final currency = NumberFormat.currency(symbol: '\$');
    return Row(
      children: [
        Expanded(
          child: _MetricCard(
            label: 'REVENUE',
            value: currency.format(stats.totalRevenue),
            icon: Icons.payments,
            color: InfernalColors.gold,
          ),
        ),
        const SizedBox(width: InfernalSpacing.md),
        Expanded(
          child: _MetricCard(
            label: 'CLIENTS',
            value: stats.totalClients.toString(),
            icon: Icons.groups,
            color: InfernalColors.arcane,
          ),
        ),
        const SizedBox(width: InfernalSpacing.md),
        Expanded(
          child: _MetricCard(
            label: 'COMPLETED',
            value: stats.completedAppointments.toString(),
            icon: Icons.check_circle,
            color: Colors.green,
          ),
        ),
        const SizedBox(width: InfernalSpacing.md),
        Expanded(
          child: _MetricCard(
            label: 'UPCOMING',
            value: stats.upcomingAppointments.toString(),
            icon: Icons.event,
            color: InfernalColors.ember,
          ),
        ),
      ],
    );
  }

  Widget _buildRevenueChart(BuildContext context, ShopOverviewStats stats) {
    // Simple bar chart representation
    return Container(
      padding: const EdgeInsets.all(InfernalSpacing.lg),
      decoration: BoxDecoration(
        color: InfernalColors.surface,
        borderRadius: BorderRadius.circular(InfernalRadius.md),
        border: Border.all(color: InfernalColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'REVENUE TREND',
            style: TextStyle(
              color: InfernalColors.textSecondary,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: InfernalSpacing.lg),
          if (stats.revenueOverTime.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(InfernalSpacing.xl),
                child: Text('Not enough data for trend analysis', style: TextStyle(color: InfernalColors.textMuted)),
              ),
            )
          else
            SizedBox(
              height: 200,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: stats.revenueOverTime.takeLast(7).map((point) {
                  final maxRev = stats.revenueOverTime.map((p) => p.amount).fold(0.0, (m, v) => v > m ? v : m);
                  final heightFactor = maxRev > 0 ? point.amount / maxRev : 0.0;
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: (heightFactor * 150) + 4,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [InfernalColors.gold, InfernalColors.ember],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                              boxShadow: [
                                BoxShadow(
                                  color: InfernalColors.gold.withValues(alpha: 0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, -2),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            DateFormat('MM/dd').format(point.date),
                            style: const TextStyle(fontSize: 10, color: InfernalColors.textMuted),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStatusSection(BuildContext context, ShopOverviewStats stats) {
    return Container(
      padding: const EdgeInsets.all(InfernalSpacing.lg),
      decoration: BoxDecoration(
        color: InfernalColors.surface,
        borderRadius: BorderRadius.circular(InfernalRadius.md),
        border: Border.all(color: InfernalColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'STATUS DISTRIBUTION',
            style: TextStyle(
              color: InfernalColors.textSecondary,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: InfernalSpacing.md),
          ...stats.appointmentsByStatus.entries.map((e) {
            final total = stats.appointmentsByStatus.values.fold(0, (a, b) => a + b);
            final percent = total > 0 ? e.value / total : 0.0;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: InfernalSpacing.xs),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(e.key.toUpperCase(), style: const TextStyle(color: InfernalColors.textPrimary)),
                      Text('${e.value} (${(percent * 100).toInt()}%)', style: const TextStyle(color: InfernalColors.textMuted)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: LinearProgressIndicator(
                      value: percent,
                      backgroundColor: InfernalColors.border,
                      color: _getStatusColor(e.key),
                      minHeight: 4,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed': return Colors.green;
      case 'scheduled': return InfernalColors.arcane;
      case 'cancelled': return InfernalColors.error;
      case 'no show': return Colors.orange;
      default: return InfernalColors.textMuted;
    }
  }
}

class _MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _MetricCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(InfernalSpacing.md),
      decoration: BoxDecoration(
        color: InfernalColors.surface,
        borderRadius: BorderRadius.circular(InfernalRadius.md),
        border: Border.all(color: InfernalColors.border),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 16),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: InfernalColors.textMuted,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Outfit',
            ),
          ),
        ],
      ),
    );
  }
}

extension TakeLast<T> on Iterable<T> {
  Iterable<T> takeLast(int n) {
    if (n <= 0) return const Iterable.empty();
    final list = toList();
    if (n >= list.length) return list;
    return list.sublist(list.length - n);
  }
}
