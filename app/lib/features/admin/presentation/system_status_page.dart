import 'package:infernal_ink_steel/shared/data/org_labels_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../app/theme/tokens.dart';
import '../../../shared/data/infernal_labels_provider.dart';
import '../../../shared/presentation/widgets/neon_plate.dart';

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

class SystemStatusPage extends ConsumerStatefulWidget {
  const SystemStatusPage({super.key});

  @override
  ConsumerState<SystemStatusPage> createState() => _SystemStatusPageState();
}

class _SystemStatusPageState extends ConsumerState<SystemStatusPage> {
  bool _isDbOnline = false;
  bool _isChecking = true;
  String _supabaseUrl = '';

  @override
  void initState() {
    super.initState();
    _checkStatus();
  }

  Future<void> _checkStatus() async {
    setState(() {
      _isChecking = true;
    });

    try {
      final client = Supabase.instance.client;
      _supabaseUrl = 'https://nmrnbwnyivxktbjukspu.supabase.co';
      
      // Ping database via lightweight select against public table
      await client.from('organizations').select('id').limit(1);
      if (mounted) {
        setState(() {
          _isDbOnline = true;
          _isChecking = false;
        });
      }
    } catch (e) {
      debugPrint('Supabase connection check failed: $e');
      if (mounted) {
        setState(() {
          _isDbOnline = false;
          _isChecking = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
          _buildSystemInfo(context),
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

  Widget _buildSystemInfo(BuildContext context) {
    return NeonPlate(
      color: _isDbOnline ? InfernalColors.success : InfernalColors.error,
      padding: const EdgeInsets.all(InfernalSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'SANCTUARY MONITORING',
                style: TextStyle(
                  color: InfernalColors.gold,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              if (_isChecking)
                const SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: InfernalColors.arcane,
                  ),
                )
              else
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _isDbOnline ? Colors.green : Colors.red,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: (_isDbOnline ? Colors.green : Colors.red).withValues(alpha: 0.8),
                            blurRadius: 6,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _isDbOnline ? 'DB ONLINE' : 'DB OFFLINE',
                      style: TextStyle(
                        color: _isDbOnline ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: InfernalSpacing.md),
          const Divider(color: InfernalColors.divider),
          const SizedBox(height: InfernalSpacing.sm),
          const _InfoRow(label: 'Database Engine', value: 'PostgreSQL (Supabase DB)'),
          _InfoRow(
            label: 'Connection Status',
            value: _isChecking ? 'Checking...' : (_isDbOnline ? 'Connected' : 'Offline / Failed'),
          ),
          _InfoRow(
            label: 'Supabase Endpoint',
            value: _supabaseUrl.isNotEmpty ? _supabaseUrl : 'Initializing...',
          ),
          const _InfoRow(label: 'Platform Version', value: 'v1.0.3 (Flutter Web)'),
          const _InfoRow(label: 'Spirit Sync Mode', value: 'Offline-First + Cloud Hybrid'),
          const SizedBox(height: InfernalSpacing.lg),
          Center(
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: InfernalColors.blood,
                  foregroundColor: InfernalColors.textPrimary,
                ),
                onPressed: _checkStatus,
                icon: const Icon(Icons.refresh),
                label: const Text('RE-VERIFY CONNECTION'),
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
