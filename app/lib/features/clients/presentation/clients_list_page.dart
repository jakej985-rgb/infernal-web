import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/tokens.dart';
import '../data/clients_provider.dart';
import 'widgets/client_status_chip.dart';
import '../../../shared/data/infernal_labels_provider.dart';

class ClientsListPage extends ConsumerWidget {
  const ClientsListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clientsAsync = ref.watch(filteredClientsProvider);
    final useInfernal = ref.watch(useInfernalLabelsProvider);

    return Scaffold(
      backgroundColor: InfernalColors.background,
      appBar: AppBar(
        title: Text(UiLabels.get('contacts', useInfernal)),
        backgroundColor: InfernalColors.surface,
        foregroundColor: InfernalColors.textPrimary,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: InfernalColors.blood,
        foregroundColor: InfernalColors.textPrimary,
        child: const Icon(Icons.person_add),
        onPressed: () => context.go('/clients/new'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(InfernalSpacing.md),
            child: TextField(
              style: const TextStyle(color: InfernalColors.textPrimary),
              decoration: InputDecoration(
                hintText: UiLabels.get('search_placeholder', useInfernal),
                hintStyle: const TextStyle(color: InfernalColors.textMuted),
                prefixIcon: const Icon(
                  Icons.search,
                  color: InfernalColors.textMuted,
                ),
                filled: true,
                fillColor: InfernalColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(InfernalRadius.md),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (val) =>
                  ref.read(clientSearchQueryProvider.notifier).set(val),
            ),
          ),
          Expanded(
            child: clientsAsync.when(
              data: (clients) {
                if (clients.isEmpty) {
                  return Center(
                    child: Text(
                      UiLabels.get('no_clients_found', useInfernal),
                      style: const TextStyle(color: InfernalColors.textMuted),
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: InfernalSpacing.md,
                    vertical: InfernalSpacing.sm,
                  ),
                  itemCount: clients.length,
                  separatorBuilder: (_, index) =>
                      const SizedBox(height: InfernalSpacing.sm),
                  itemBuilder: (ctx, idx) {
                    final client = clients[idx];
                    return Card(
                      color: InfernalColors.surface,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: InfernalColors.voidColor,
                          foregroundColor: InfernalColors.textPrimary,
                          child: Text(
                            client.firstName.isNotEmpty
                                ? client.firstName[0].toUpperCase()
                                : '?',
                          ),
                        ),
                        title: Text(
                          client.fullName,
                          style: const TextStyle(
                            color: InfernalColors.textPrimary,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Row(
                            children: [
                              ClientStatusChip(status: client.status),
                              if (client.phone.isNotEmpty) ...[
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    client.phone,
                                    style: const TextStyle(
                                      color: InfernalColors.textSecondary,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        trailing: const Icon(
                          Icons.chevron_right,
                          color: InfernalColors.textMuted,
                        ),
                        onTap: () => context.go('/clients/${client.id}'),
                      ),
                    );
                  },
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
          ),
        ],
      ),
    );
  }
}
