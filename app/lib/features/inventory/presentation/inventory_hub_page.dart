import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/theme/tokens.dart';

import '../../../shared/presentation/widgets/neon_plate.dart';

import '../data/inventory_provider.dart';
import 'inventory_form_page.dart';
import '../../../../shared/domain/inventory.dart' as domain;

class InventoryHubPage extends ConsumerWidget {
  const InventoryHubPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inventoryItemsAsync = ref.watch(inventoryItemsProvider);

    return Scaffold(
      backgroundColor: InfernalColors.background,
      appBar: AppBar(
        title: const Text('ALCHEMICAL SUPPLIES', style: TextStyle(letterSpacing: 4)),
        centerTitle: true,
        backgroundColor: InfernalColors.surface,
        elevation: 0,
      ),
      body: inventoryItemsAsync.when(
        data: (items) => items.isEmpty ? _buildEmptyState(context) : _buildSupplyGrid(context, items, ref),
        loading: () => const Center(child: CircularProgressIndicator(color: InfernalColors.blood)),
        error: (err, stack) => Center(child: Text('Ritual error: $err', style: const TextStyle(color: InfernalColors.error))),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const InventoryFormPage()),
        ),
        backgroundColor: InfernalColors.blood,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.inventory_2_outlined, size: 64, color: InfernalColors.textMuted),
          const SizedBox(height: InfernalSpacing.md),
          const Text(
            'THE ARSENAL IS EMPTY',
            style: TextStyle(color: InfernalColors.textPrimary, letterSpacing: 2, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: InfernalSpacing.sm),
          const Text(
            'Summon supplies to begin tracking.',
            style: TextStyle(color: InfernalColors.textMuted),
          ),
        ],
      ),
    );
  }

  Widget _buildSupplyGrid(BuildContext context, List<domain.InventoryItem> items, WidgetRef ref) {
    return GridView.builder(
      padding: const EdgeInsets.all(InfernalSpacing.lg),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: InfernalSpacing.md,
        crossAxisSpacing: InfernalSpacing.md,
        childAspectRatio: 0.8,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final bool isLow = item.stockQuantity <= item.minimumQuantity;

        return NeonPlate(
          color: isLow ? InfernalColors.error : InfernalColors.arcane,
          child: InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InventoryFormPage(item: item)),
            ),
            onLongPress: () => _confirmDeletion(context, item, ref),
            child: Padding(
              padding: const EdgeInsets.all(InfernalSpacing.sm),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isLow ? Icons.warning_amber_rounded : Icons.inventory_2_outlined,
                    color: isLow ? InfernalColors.error : InfernalColors.arcane,
                    size: 32,
                  ),
                  const SizedBox(height: InfernalSpacing.sm),
                  Text(
                    item.name.toUpperCase(),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: InfernalColors.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    item.category,
                    style: const TextStyle(color: InfernalColors.textMuted, fontSize: 10),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: (isLow ? InfernalColors.error : InfernalColors.arcane).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(InfernalRadius.pill),
                    ),
                    child: Text(
                      '${item.stockQuantity} ${item.unit}',
                      style: TextStyle(
                        color: isLow ? InfernalColors.error : InfernalColors.arcane,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _confirmDeletion(BuildContext context, domain.InventoryItem item, WidgetRef ref) {

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: InfernalColors.surface,
        title: const Text('BANISH SUPPLY?'),
        content: Text('Shall we remove ${item.name} from the arsenal?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('STAY')),
          TextButton(
            onPressed: () async {
              await ref.read(inventoryServiceProvider.notifier).deleteItem(item.id);
              if (context.mounted) Navigator.pop(ctx);
            },
            child: const Text('BANISH', style: TextStyle(color: InfernalColors.error)),
          ),
        ],
      ),
    );
  }
}

