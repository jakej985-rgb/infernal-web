import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/tokens.dart';

import '../../../clients/data/clients_provider.dart';

class ClientSelectionModal extends ConsumerStatefulWidget {
  const ClientSelectionModal({super.key});

  @override
  ConsumerState<ClientSelectionModal> createState() =>
      _ClientSelectionModalState();
}

class _ClientSelectionModalState extends ConsumerState<ClientSelectionModal> {
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    // Use addPostFrameCallback to avoid modifying provider in dispose?
    // Actually, setting it to empty on dispose is good practice so next view starts clean.
    // However, during dispose might be tricky.
    // Let's just set it to '' on Init.
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Clear search on open
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(clientSearchQueryProvider.notifier).set('');
    });
  }

  @override
  Widget build(BuildContext context) {
    final clientsAsync = ref.watch(filteredClientsProvider);

    return Container(
      decoration: const BoxDecoration(
        color: InfernalColors.background,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(InfernalRadius.lg),
        ),
      ),
      padding: const EdgeInsets.all(InfernalSpacing.md),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: InfernalSpacing.md),
            decoration: BoxDecoration(
              color: InfernalColors.surfaceElevated,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Text(
            'Summon Soul',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: InfernalColors.textPrimary),
          ),
          const SizedBox(height: InfernalSpacing.md),
          TextField(
            controller: _searchCtrl,
            style: const TextStyle(color: InfernalColors.textPrimary),
            decoration: InputDecoration(
              hintText: 'Search by name, email, or phone...',
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
          const SizedBox(height: InfernalSpacing.md),
          Expanded(
            child: clientsAsync.when(
              data: (clients) {
                if (clients.isEmpty) {
                  return const Center(
                    child: Text(
                      'No souls found.',
                      style: TextStyle(color: InfernalColors.textMuted),
                    ),
                  );
                }
                return ListView.separated(
                  itemCount: clients.length,
                  separatorBuilder: (_, _) =>
                      const Divider(color: InfernalColors.divider),
                  itemBuilder: (ctx, idx) {
                    final client = clients[idx];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: InfernalColors.surfaceElevated,
                        child: Text(
                          client.firstName.isNotEmpty
                              ? client.firstName[0]
                              : '?',
                          style: const TextStyle(
                            color: InfernalColors.textPrimary,
                          ),
                        ),
                      ),
                      title: Text(
                        client.fullName,
                        style: const TextStyle(
                          color: InfernalColors.textPrimary,
                        ),
                      ),
                      subtitle: Text(
                        client.phone,
                        style: const TextStyle(
                          color: InfernalColors.textSecondary,
                        ),
                      ),
                      onTap: () => context.pop(client),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, s) => Center(child: Text('Error: $e')),
            ),
          ),
        ],
      ),
    );
  }
}
