import 'package:infernal_ink_steel/shared/data/org_labels_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/tokens.dart';
import '../data/clients_provider.dart';
import 'widgets/client_status_chip.dart';
import '../../../shared/data/infernal_labels_provider.dart';
import '../../../app/router.dart';
import '../../documents/data/documents_provider.dart';


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
    final lifecycleAsync = ref.watch(clientLifecycleProvider(id));
    final useInfernal = ref.watch(labelModeProvider);

    return Scaffold(
      backgroundColor: InfernalColors.background,
      appBar: AppBar(
        title: Text(UiLabels.get('client_details', useInfernal, ref.read(orgLabelsProvider).value)),
        backgroundColor: InfernalColors.surface,
        foregroundColor: InfernalColors.textPrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.go('${AppRoutes.clients}/$id/edit'),
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
          return SingleChildScrollView(
            child: Column(
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
                            lifecycleAsync.maybeWhen(
                              data: (lifecycle) => lifecycle == null
                                  ? const SizedBox.shrink()
                                  : ClientStatusChip(lifecycle: lifecycle),
                              orElse: () => const SizedBox.shrink(),
                            ),
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
                const Divider(color: InfernalColors.divider, height: 1),
                
                const SizedBox(height: InfernalSpacing.lg),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: InfernalSpacing.md),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        UiLabels.get('documents_client_section', useInfernal, ref.read(orgLabelsProvider).value),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: InfernalColors.textSecondary,
                              letterSpacing: 1.5,
                            ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.upload_file, color: InfernalColors.arcane, size: 20),
                        onPressed: () => context.push('/documents/new?clientId=${client.id}'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: InfernalSpacing.xs),
                Consumer(
                  builder: (context, ref, _) {
                    final docsAsync = ref.watch(clientDocumentsProvider(client.id));
                    return docsAsync.when(
                      data: (docs) {
                        if (docs.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: InfernalSpacing.md),
                            child: Text(
                              UiLabels.get('documents_client_empty', useInfernal, ref.read(orgLabelsProvider).value),
                              style: const TextStyle(
                                color: InfernalColors.textMuted,
                                fontSize: 13,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          );
                        }
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: InfernalSpacing.md),
                          itemCount: docs.length,
                          separatorBuilder: (_, _) => const SizedBox(height: 8),
                          itemBuilder: (context, index) {
                            final doc = docs[index];
                            return Card(
                              color: InfernalColors.surface,
                              margin: EdgeInsets.zero,
                              child: ListTile(
                                leading: Icon(
                                  doc.isImage ? Icons.image : Icons.description,
                                  color: InfernalColors.arcane,
                                ),
                                title: Text(
                                  doc.title,
                                  style: const TextStyle(
                                    color: InfernalColors.textPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                subtitle: Text(
                                  doc.filePath.length > 30 
                                      ? '${doc.filePath.substring(0, 30)}...' 
                                      : doc.filePath,
                                  style: const TextStyle(color: InfernalColors.textSecondary, fontSize: 11),
                                ),
                                trailing: const Icon(
                                  Icons.chevron_right,
                                  color: InfernalColors.textMuted,
                                ),
                                onTap: () => context.push('/documents/${doc.id}'),
                              ),
                            );
                          },
                        );
                      },
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (e, _) => Padding(
                        padding: const EdgeInsets.all(InfernalSpacing.md),
                        child: Text(
                          'Error loading documents: $e',
                          style: const TextStyle(color: InfernalColors.error),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 40),
              ],
            ),
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
    final useInfernal = ref.read(labelModeProvider);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: InfernalColors.surface,
        title: Text(
          UiLabels.get('delete_client_title', useInfernal, ref.read(orgLabelsProvider).value),
          style: const TextStyle(color: InfernalColors.textPrimary),
        ),
        content: Text(
          UiLabels.get('delete_client_content', useInfernal, ref.read(orgLabelsProvider).value),
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
              UiLabels.get('delete_client_action', useInfernal, ref.read(orgLabelsProvider).value),
              style: const TextStyle(color: InfernalColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
