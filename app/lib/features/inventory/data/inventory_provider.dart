import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared/persistence/database.dart';
import '../../../shared/persistence/daos/inventory_dao.dart';
import '../../../../shared/domain/inventory.dart' as domain;

part 'inventory_provider.g.dart';

@riverpod
InventoryDao inventoryDao(Ref ref) {
  return ref.watch(databaseProvider).inventoryDao;

}

@riverpod
Stream<List<domain.InventoryItem>> inventoryItems(Ref ref) {
  return ref.watch(inventoryDaoProvider).watchAllItems().map((rows) {
    return rows.map((row) => domain.InventoryItem(
      id: row.id,
      syncId: row.syncId,
      name: row.name,
      category: row.category,
      stockQuantity: row.stockQuantity,
      minimumQuantity: row.minimumQuantity,
      unit: row.unit,
      supplier: row.supplier,
      lastOrderedAt: row.lastOrderedAt,
      updatedAt: row.updatedAt,
      isDeleted: row.isDeleted,
    )).toList();
  });
}

@riverpod
class InventoryService extends _$InventoryService {
  @override
  FutureOr<void> build() {}

  Future<void> addItem(InventoryItemsCompanion item) async {
    await ref.read(inventoryDaoProvider).insertItem(item);
  }

  Future<void> updateItem(domain.InventoryItem item) async {
    // Convert Domain -> Drift
    final dbItem = InventoryItem(
      id: item.id,
      syncId: item.syncId,
      name: item.name,
      category: item.category,
      stockQuantity: item.stockQuantity,
      minimumQuantity: item.minimumQuantity,
      unit: item.unit,
      supplier: item.supplier,
      lastOrderedAt: item.lastOrderedAt,
      updatedAt: item.updatedAt,
      isDeleted: item.isDeleted,
    );
    await ref.read(inventoryDaoProvider).updateItem(dbItem);
  }

  Future<void> deleteItem(int id) async {
    await ref.read(inventoryDaoProvider).deleteItem(id);
  }
}
