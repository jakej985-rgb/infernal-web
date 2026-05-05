import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infernal_ink_steel/features/inventory/data/inventory_provider.dart';
import 'package:infernal_ink_steel/features/inventory/presentation/inventory_hub_page.dart';
import 'package:infernal_ink_steel/shared/domain/inventory.dart';

void main() {
  testWidgets('InventoryHubPage shows empty state when no items', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          inventoryItemsProvider.overrideWith((ref) => Stream.value([])),
        ],
        child: const MaterialApp(home: InventoryHubPage()),
      ),
    );

    // Pump to settle stream
    await tester.pumpAndSettle();

    expect(find.text('THE ARSENAL IS EMPTY'), findsOneWidget);
    expect(find.text('Summon supplies to begin tracking.'), findsOneWidget);
  });

  testWidgets('InventoryHubPage shows items in grid', (tester) async {
    final item = InventoryItem(
      id: 1,
      name: 'Black Ink',
      category: 'Inks',
      stockQuantity: 10,
      minimumQuantity: 5,
      unit: 'bottle',
      updatedAt: DateTime.now(),
      lastOrderedAt: null,
      isDeleted: false,
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          inventoryItemsProvider.overrideWith((ref) => Stream.value([item])),
        ],
        child: const MaterialApp(home: InventoryHubPage()),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('BLACK INK'), findsOneWidget);
    expect(find.text('10.0 bottle'), findsOneWidget);

    // Let's check what the card actually displays.
    // In InventoryHubPage -> _buildSupplyGrid -> NeonPlate -> column
    // It likely displays name, and quantity.
  });
}
