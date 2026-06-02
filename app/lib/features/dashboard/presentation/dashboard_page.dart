import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../app/theme/tokens.dart';
import '../../../shared/presentation/widgets/neon_plate.dart';
import '../../../shared/presentation/widgets/neon_divider.dart';
import '../../auth/domain/auth_service.dart';
import '../data/stats_repository.dart';
import 'widgets/metric_card.dart';
import '../../../app/router.dart';
import '../../../shared/data/infernal_labels_provider.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(dashboardStatsRepositoryProvider);
    final appointmentsAsync = ref.watch(dashboardTodayAppointmentsProvider);
    final useInfernal = ref.watch(useInfernalLabelsProvider);

    return Scaffold(
      backgroundColor: InfernalColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            backgroundColor: InfernalColors.background,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                UiLabels.get('dashboard_title', useInfernal),
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: InfernalColors.blood,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4.0,
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [InfernalColors.surface, InfernalColors.background],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout, color: InfernalColors.textMuted),
                onPressed: () => ref.read(authServiceProvider.notifier).logout(),
              ),
            ],
          ),
          const SliverToBoxAdapter(child: NeonDivider(blurRadius: 10, thickness: 0.5)),
          SliverPadding(
            padding: const EdgeInsets.all(InfernalSpacing.md),
            sliver: statsAsync.when(
              data: (stats) => SliverGrid.count(
                crossAxisCount: 4,
                crossAxisSpacing: InfernalSpacing.md,
                mainAxisSpacing: InfernalSpacing.md,
                childAspectRatio: 1.2,
                children: [
                  MetricCard(
                    label: UiLabels.get('todays_appointments', useInfernal),
                    value: stats.todayRituals.toString(),
                    icon: Icons.auto_awesome,
                    color: InfernalColors.blood,
                  ),
                  MetricCard(
                    label: UiLabels.get('active_clients', useInfernal),
                    value: stats.boundSouls.toString(),
                    icon: Icons.people_outline,
                    color: InfernalColors.arcane,
                  ),
                  MetricCard(
                    label: UiLabels.get('open_quotes', useInfernal),
                    value: stats.openScrolls.toString(),
                    icon: Icons.history_edu,
                    color: InfernalColors.gold,
                  ),
                  MetricCard(
                    label: UiLabels.get('pending_actions', useInfernal),
                    value: stats.pending.toString(),
                    icon: Icons.hourglass_top,
                    color: InfernalColors.voidColor,
                  ),
                ],
              ),
              loading: () => const SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (e, _) => SliverToBoxAdapter(
                child: Text('Error: $e', style: const TextStyle(color: InfernalColors.error)),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(InfernalSpacing.md, InfernalSpacing.lg, InfernalSpacing.md, InfernalSpacing.sm),
              child: Row(
                children: [
                  const Icon(Icons.visibility, color: InfernalColors.blood, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    UiLabels.get('timeline_title', useInfernal),
                    style: const TextStyle(
                      color: InfernalColors.textPrimary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          appointmentsAsync.when(
            data: (appointments) {
              if (appointments.isEmpty) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(InfernalSpacing.xl),
                    child: Center(child: Text(UiLabels.get('no_upcoming_appointments', useInfernal), style: const TextStyle(color: InfernalColors.textMuted, fontStyle: FontStyle.italic))),
                  ),
                );
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final appt = appointments[index];
                  final timeFmt = DateFormat.jm().format(appt.startTime);
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: InfernalSpacing.md, vertical: 4),
                    child: NeonPlate(
                      color: InfernalColors.blood,
                      padding: EdgeInsets.zero,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: InfernalColors.blood.withValues(alpha: 0.1),
                          child: const Icon(Icons.circle, size: 12, color: InfernalColors.blood),
                        ),
                        title: Text(appt.clientName, style: const TextStyle(color: InfernalColors.textPrimary, fontWeight: FontWeight.bold)),
                        subtitle: Text('$timeFmt • ${appt.serviceType}', style: const TextStyle(color: InfernalColors.textSecondary)),
                        trailing: const Icon(Icons.chevron_right, color: InfernalColors.textMuted),
                        onTap: () => context.go('/appointments'),
                      ),
                    ),
                  );
                }, childCount: appointments.length),
              );
            },
            loading: () => const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator())),
            error: (e, _) => SliverToBoxAdapter(child: Text('Error: $e', style: const TextStyle(color: InfernalColors.error))),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(InfernalSpacing.md, InfernalSpacing.xl, InfernalSpacing.md, InfernalSpacing.md),
              child: Text(
                UiLabels.get('summoning_grid_title', useInfernal),
                style: const TextStyle(color: InfernalColors.textPrimary, fontWeight: FontWeight.bold, letterSpacing: 1.5, fontSize: 14),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: InfernalSpacing.md),
            sliver: SliverGrid.count(
              crossAxisCount: 3,
              mainAxisSpacing: InfernalSpacing.md,
              crossAxisSpacing: InfernalSpacing.md,
              childAspectRatio: 1.6,
              children: [
                _QuickActionBtn(
                  icon: Icons.calendar_month,
                  label: UiLabels.get('action_new_ritual', useInfernal),
                  color: InfernalColors.blood,
                  onTap: () => context.go('/appointments/new'),
                ),
                _QuickActionBtn(
                  icon: Icons.person_add,
                  label: UiLabels.get('action_new_soul', useInfernal),
                  color: InfernalColors.arcane,
                  onTap: () => context.go('/clients/new'),
                ),
                _QuickActionBtn(
                  icon: Icons.calculate,
                  label: UiLabels.get('action_new_quote', useInfernal),
                  color: InfernalColors.gold,
                  onTap: () => context.go('/quotes/new'),
                ),
                _QuickActionBtn(
                  icon: Icons.inventory_2_outlined,
                  label: UiLabels.get('action_supplies', useInfernal),
                  color: InfernalColors.arcane,
                  onTap: () => context.go(AppRoutes.inventory),
                ),
                _QuickActionBtn(
                  icon: Icons.chat_bubble_outline,
                  label: UiLabels.get('action_invocation', useInfernal),
                  color: InfernalColors.blood,
                  onTap: () => context.go(AppRoutes.communications),
                ),
                _QuickActionBtn(
                  icon: Icons.build_outlined,
                  label: UiLabels.get('tools', useInfernal),
                  color: InfernalColors.textMuted,
                  onTap: () => context.go(AppRoutes.tools),
                ),
                _QuickActionBtn(
                  icon: Icons.analytics_outlined,
                  label: UiLabels.get('stats', useInfernal),
                  color: InfernalColors.gold,
                  onTap: () => context.go(AppRoutes.stats),
                ),
                _QuickActionBtn(
                  icon: Icons.admin_panel_settings,
                  label: "Admin",
                  color: InfernalColors.blood,
                  onTap: () => context.go(AppRoutes.adminUsers),
                ),
                _QuickActionBtn(
                  icon: Icons.settings,
                  label: UiLabels.get('settings', useInfernal),
                  color: InfernalColors.voidColor,
                  onTap: () => context.go('/settings'),
                ),
              ],
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}

class _QuickActionBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionBtn({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return NeonPlate(
      color: color,
      onTap: onTap,
      padding: const EdgeInsets.all(InfernalSpacing.sm),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 8),
          FittedBox(
            child: Text(
              label.toUpperCase(),
              style: const TextStyle(
                color: InfernalColors.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 10,
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
