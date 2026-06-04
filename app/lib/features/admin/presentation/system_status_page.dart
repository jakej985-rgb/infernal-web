import 'package:infernal_ink_steel/shared/data/org_labels_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../app/theme/tokens.dart';
import '../../../shared/data/infernal_labels_provider.dart';
import '../../../shared/util/app_version_helper.dart';

class AuditLog {
  final String action;
  final String? entityType;
  final String details;
  final DateTime timestamp;

  const AuditLog({
    required this.action,
    this.entityType,
    required this.details,
    required this.timestamp,
  });
}

class SystemStatusPage extends ConsumerWidget {
  const SystemStatusPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logsAsync = ref.watch(
      StreamProvider((ref) => Stream.value(<AuditLog>[])),
    );
    final useInfernal = ref.watch(labelModeProvider);
    final customLabels = ref.watch(orgLabelsProvider).value;

    return Scaffold(
      backgroundColor: InfernalColors.background,
      appBar: AppBar(
        title: Text(UiLabels.get('admin_status_title', useInfernal, customLabels)),
        backgroundColor: InfernalColors.surface,
        foregroundColor: InfernalColors.textPrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(InfernalSpacing.lg),
        children: [
          _buildSystemInfo(context, ref),
          const SizedBox(height: InfernalSpacing.xl),
          Text(
            UiLabels.get('recent_logs', useInfernal, customLabels).toUpperCase(),
            style: const TextStyle(
              color: InfernalColors.textMuted,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: InfernalSpacing.md),
          logsAsync.when(
            data: (logs) => _buildLogsList(logs),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, s) => Text(
              '${UiLabels.get('logs_error', useInfernal, customLabels)}: $e',
              style: const TextStyle(color: InfernalColors.error),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSystemInfo(BuildContext context, WidgetRef ref) {
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
            'SANCTUARY STANDING',
            style: TextStyle(
              color: InfernalColors.gold,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: InfernalSpacing.md),
          _InfoRow(label: 'Database Version', value: 'PostgreSQL (Cloud SQL)'),
          _InfoRow(label: 'Spirit Sync', value: 'Online (Central Go API)'),
          _InfoRow(label: 'Security Level', value: 'Inquisition Standard'),
          _InfoRow(
            label: 'Persistence Path',
            value: 'https://api.inkandsteel.xyz',
          ),
          const SizedBox(height: InfernalSpacing.lg),
          Center(
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: InfernalColors.blood,
                  foregroundColor: InfernalColors.textPrimary,
                ),
                onPressed: () async {
                  await resetApp();
                },
                icon: const Icon(Icons.refresh),
                label: const Text('HARD RESET APP'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogsList(List<AuditLog> logs) {
    if (logs.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(InfernalSpacing.xl),
          child: Text(
            'The chronicles are empty.',
            style: TextStyle(color: InfernalColors.textMuted),
          ),
        ),
      );
    }

    return Column(children: logs.map((log) => _LogItem(log: log)).toList());
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: InfernalSpacing.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: InfernalColors.textSecondary),
          ),
          Text(
            value,
            style: const TextStyle(
              color: InfernalColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _LogItem extends StatelessWidget {
  final AuditLog log;
  const _LogItem({required this.log});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: InfernalSpacing.sm),
      decoration: BoxDecoration(
        color: InfernalColors.surface,
        border: Border(
          left: BorderSide(color: _getActionColor(log.action), width: 4),
        ),
      ),
      child: ListTile(
        dense: true,
        title: Text(
          '${log.action} // ${log.entityType ?? ''}',
          style: const TextStyle(
            color: InfernalColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          '${log.details} • ${DateFormat('HH:mm:ss').format(log.timestamp)}',
          style: const TextStyle(color: InfernalColors.textMuted),
        ),
        trailing: Text(
          DateFormat('MMM d').format(log.timestamp),
          style: const TextStyle(color: InfernalColors.textMuted, fontSize: 10),
        ),
      ),
    );
  }

  Color _getActionColor(String action) {
    switch (action.toUpperCase()) {
      case 'CREATE':
        return Colors.green;
      case 'UPDATE':
        return Colors.blue;
      case 'DELETE':
        return Colors.red;
      case 'LOGIN':
        return Colors.purple;
      default:
        return InfernalColors.textMuted;
    }
  }
}
