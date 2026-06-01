import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:drift/drift.dart' as drift;
import 'package:infernal_ink_steel/features/inventory/data/inventory_provider.dart';
import 'package:infernal_ink_steel/shared/persistence/daos/inventory_dao.dart';
import 'package:infernal_ink_steel/shared/persistence/database.dart';
import 'package:infernal_ink_steel/shared/domain/inventory.dart' as domain;

class MockInventoryDao extends Mock implements InventoryDao {}

// Fake classes for fallback
class FakeInventoryItemsCompanion extends Fake implements InventoryItemsCompanion {}
class FakeInventoryItem extends Fake implements InventoryItem {}

void main() {
  late MockInventoryDao mockDao;
  late ProviderContainer container;

  setUpAll(() {
    registerFallbackValue(FakeInventoryItemsCompanion());
    registerFallbackValue(FakeInventoryItem());
  });

  setUp(() {
    mockDao = MockInventoryDao();
    container = ProviderContainer(
      overrides: [
        inventoryDaoProvider.overrideWith((ref) => mockDao),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('InventoryService', () {
    test('addItem calls Dao insert', () async {
      when(() => mockDao.insertItem(any())).thenAnswer((_) async => 1);

      final companion = const InventoryItemsCompanion(
        name: drift.Value('Ink'),
      );

      await container.read(inventoryServiceProvider.notifier).addItem(companion);

      verify(() => mockDao.insertItem(companion)).called(1);
    });

    test('updateItem converts domain model and calls Dao update', () async {
      when(() => mockDao.updateItem(any())).thenAnswer((_) async => true);

      final domainItem = domain.InventoryItem(
        id: 1,
        name: 'Updated Ink',
        category: 'Inks',
        stockQuantity: 10,
        minimumQuantity: 5,
        unit: 'oz',
        lastOrderedAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isDeleted: false,
      );

      await container.read(inventoryServiceProvider.notifier).updateItem(domainItem);

      // Verify that updateItem was called with an InventoryItem (Drift type)
      // matching the ID and name
      final captured = verify(() => mockDao.updateItem(captureAny())).captured;
      final capturedItem = captured.first as InventoryItem;
      
      expect(capturedItem.id, 1);
      expect(capturedItem.name, 'Updated Ink');
    });

    test('deleteItem calls Dao delete', () async {
      when(() => mockDao.deleteItem(any())).thenAnswer((_) async => 1);

      await container.read(inventoryServiceProvider.notifier).deleteItem(123);

      verify(() => mockDao.deleteItem(123)).called(1);
    });
  });

  group('inventoryItems provider', () {
    test('emit domain items mapped from dao rows', () async {
      final now = DateTime.now();
      final driftItems = [
        InventoryItem(
          id: 1,
          syncId: 'mock-sync-id',
          name: 'Ink',
          category: 'Inks',
          stockQuantity: 10,
          minimumQuantity: 5,
          unit: 'oz',
          supplier: 'Supplier A',
          lastOrderedAt: now,
          updatedAt: now,
          isDeleted: false,
        ),
      ];

      when(() => mockDao.watchAllItems()).thenAnswer((_) => Stream.value(driftItems));

      // Listen to the provider to get the value
      final subscription = container.listen(inventoryItemsProvider, (_, _) {});
      await container.read(inventoryItemsProvider.future);
      final asyncValue = container.read(inventoryItemsProvider);
      subscription.close();
      
      expect(asyncValue.hasValue, true);
      final list = asyncValue.value!;
      expect(list.length, 1);
      expect(list.first.id, 1);
      expect(list.first.name, 'Ink');
      expect(list.first.category, 'Inks');
    });
  });
}
