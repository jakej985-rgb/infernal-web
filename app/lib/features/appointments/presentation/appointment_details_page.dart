import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../app/theme/tokens.dart';
import '../data/appointments_provider.dart';
import 'controllers/appointment_controller.dart';
import 'widgets/appointment_status_chip.dart';
import '../../../app/router.dart';
import '../../../shared/data/infernal_labels_provider.dart';

class AppointmentDetailsPage extends ConsumerWidget {
  final String appointmentId;

  const AppointmentDetailsPage({super.key, required this.appointmentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useInfernal = ref.watch(useInfernalLabelsProvider);
    final id = int.tryParse(appointmentId);
    if (id == null) {
      return const Scaffold(body: Center(child: Text("Invalid ID")));
    }

    final aptAsync = ref.watch(appointmentDetailProvider(id));

    return Scaffold(
      backgroundColor: InfernalColors.background,
      appBar: AppBar(
        title: Text(UiLabels.get('appointment_details', useInfernal)),
        backgroundColor: InfernalColors.surface,
        foregroundColor: InfernalColors.textPrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.go('${AppRoutes.appointments}/$id/edit'),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: InfernalColors.error),
            onPressed: () => _deleteAppointment(context, ref, id, useInfernal),
          ),
        ],
      ),
      body: aptAsync.when(
        data: (apt) {
          if (apt == null) {
            return Center(
              child: Text(UiLabels.get('appointment_not_found', useInfernal)),
            );
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(InfernalSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header (Date/Time)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(InfernalSpacing.lg),
                  decoration: BoxDecoration(
                    color: InfernalColors.surface,
                    borderRadius: BorderRadius.circular(InfernalRadius.md),
                  ),
                  child: Column(
                    children: [
                      Text(
                        DateFormat('EEEE, MMMM d').format(apt.dateTime),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: InfernalColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: InfernalSpacing.sm),
                      Text(
                        DateFormat('h:mm a').format(apt.dateTime),
                        style: Theme.of(context).textTheme.displayMedium
                            ?.copyWith(
                              color: InfernalColors.blood,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: InfernalSpacing.md),
                      AppointmentStatusChip(statusString: apt.status),
                    ],
                  ),
                ),
                const SizedBox(height: InfernalSpacing.lg),

                // Client Link
                InkWell(
                  onTap: () =>
                      context.push('${AppRoutes.clients}/${apt.clientId}'),
                  borderRadius: BorderRadius.circular(InfernalRadius.md),
                  child: Container(
                    padding: const EdgeInsets.all(InfernalSpacing.md),
                    decoration: BoxDecoration(
                      color: InfernalColors.surfaceElevated,
                      borderRadius: BorderRadius.circular(InfernalRadius.md),
                      border: Border.all(color: InfernalColors.border),
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: InfernalColors.surface,
                          child: Icon(
                            Icons.person,
                            color: InfernalColors.textPrimary,
                          ),
                        ),
                        const SizedBox(width: InfernalSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                useInfernal ? 'Canvas' : 'Client',
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                      color: InfernalColors.textSecondary,
                                    ),
                              ),
                              Text(
                                apt.clientName,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: InfernalColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          color: InfernalColors.textMuted,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: InfernalSpacing.lg),

                // Info Grid
                _InfoRow(
                  icon: Icons.flash_on,
                  label: 'Service',
                  value: apt.serviceType,
                ),
                const Divider(color: InfernalColors.divider),
                _InfoRow(
                  icon: Icons.timer,
                  label: 'Duration',
                  value: '${apt.durationMinutes} min',
                ),
                const Divider(color: InfernalColors.divider),
                _InfoRow(
                  icon: Icons.category,
                  label: 'Category',
                  value: apt.serviceCategory,
                ),

                const SizedBox(height: InfernalSpacing.lg),

                if (apt.notes != null && apt.notes!.isNotEmpty) ...[
                  Text(
                    "NOTES",
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: InfernalColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: InfernalSpacing.sm),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(InfernalSpacing.md),
                    decoration: BoxDecoration(
                      color: InfernalColors.surface,
                      borderRadius: BorderRadius.circular(InfernalRadius.sm),
                    ),
                    child: Text(
                      apt.notes!,
                      style: const TextStyle(color: InfernalColors.textPrimary),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
    );
  }

  void _deleteAppointment(
    BuildContext context,
    WidgetRef ref,
    int id,
    bool useInfernal,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: InfernalColors.surface,
        title: Text(
          UiLabels.get('delete_appointment_title', useInfernal),
          style: const TextStyle(color: InfernalColors.textPrimary),
        ),
        content: Text(
          UiLabels.get('delete_appointment_content', useInfernal),
          style: const TextStyle(color: InfernalColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Back'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await ref.read(appointmentControllerProvider).deleteAppointment(id);
              if (context.mounted) context.pop();
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: InfernalColors.error),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: InfernalSpacing.sm),
      child: Row(
        children: [
          Icon(icon, color: InfernalColors.textSecondary, size: 20),
          const SizedBox(width: InfernalSpacing.md),
          Text(
            label,
            style: const TextStyle(color: InfernalColors.textSecondary),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              color: InfernalColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
