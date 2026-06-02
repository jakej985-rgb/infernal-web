import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/tokens.dart';
import '../data/clients_provider.dart';
import 'widgets/client_status_chip.dart';
import '../../../shared/data/infernal_labels_provider.dart';

class ClientDetailsPage extends ConsumerWidget {
  final String clientId;

  const ClientDetailsPage({super.key, required this.clientId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = int.tryParse(clientId);
    if (id == null) {
      return const Scaffold(body: Center(child: Text("Invalid ID")));
    }

    final clientAsync = ref.watch(clientDetailProvider(id));
    final useInfernal = ref.watch(useInfernalLabelsProvider);

    return Scaffold(
      backgroundColor: InfernalColors.background,
      appBar: AppBar(
        title: Text(UiLabels.get('client_details', useInfernal)),
        backgroundColor: InfernalColors.surface,
        foregroundColor: InfernalColors.textPrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.go('/clients/$id/edit'),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: InfernalColors.error),
            onPressed: () => _deleteClient(context, ref, id),
          ),
        ],
      ),
      body: clientAsync.when(
        data: (client) {
          if (client == null) {
            return const Center(child: Text("Soul not found"));
          }
          return Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(InfernalSpacing.lg),
                color: InfernalColors.surface,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: InfernalColors.blood,
                      child: Text(
                        client.firstName.isNotEmpty ? client.firstName[0] : '?',
                        style: const TextStyle(
                          fontSize: 24,
                          color: InfernalColors.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(width: InfernalSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            client.fullName,
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  color: InfernalColors.textPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 4),
                          ClientStatusChip(status: client.status),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: InfernalSpacing.md),
              // Info
              ListTile(
                leading: const Icon(
                  Icons.email,
                  color: InfernalColors.textSecondary,
                ),
                title: Text(
                  client.email.isEmpty ? 'No email' : client.email,
                  style: const TextStyle(color: InfernalColors.textPrimary),
                ),
              ),
              const Divider(color: InfernalColors.divider, height: 1),
              ListTile(
                leading: const Icon(
                  Icons.phone,
                  color: InfernalColors.textSecondary,
                ),
                title: Text(
                  client.phone.isEmpty ? 'No phone' : client.phone,
                  style: const TextStyle(color: InfernalColors.textPrimary),
                ),
              ),
              const Divider(color: InfernalColors.divider, height: 1),
              ListTile(
                leading: const Icon(
                  Icons.note,
                  color: InfernalColors.textSecondary,
                ),
                title: Text(
                  client.notes.isEmpty ? 'No notes' : client.notes,
                  style: const TextStyle(color: InfernalColors.textPrimary),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(
          child: Text(
            'Error: $e',
            style: const TextStyle(color: InfernalColors.error),
          ),
        ),
      ),
    );
  }


  void _deleteClient(BuildContext context, WidgetRef ref, int id) {
    final useInfernal = ref.read(useInfernalLabelsProvider);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: InfernalColors.surface,
        title: Text(
          UiLabels.get('delete_client_title', useInfernal),
          style: const TextStyle(color: InfernalColors.textPrimary),
        ),
        content: Text(
          UiLabels.get('delete_client_content', useInfernal),
          style: const TextStyle(color: InfernalColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await ref.read(clientServiceProvider).deleteClient(id);
              if (context.mounted) context.pop();
            },
            child: Text(
              UiLabels.get('delete_client_action', useInfernal),
              style: const TextStyle(color: InfernalColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
