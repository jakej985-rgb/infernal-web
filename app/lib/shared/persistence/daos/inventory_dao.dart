import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/inventory_table.dart';

part 'inventory_dao.g.dart';

@DriftAccessor(tables: [InventoryItems])
class InventoryDao extends DatabaseAccessor<AppDatabase> with _$InventoryDaoMixin {
  InventoryDao(super.db);

  Stream<List<InventoryItem>> watchAllItems() => select(inventoryItems).watch();
  Future<int> insertItem(InventoryItemsCompanion item) => into(inventoryItems).insert(item);
  Future<bool> updateItem(InventoryItem item) => update(inventoryItems).replace(item);
  Future<int> deleteItem(int id) => (delete(inventoryItems)..where((t) => t.id.equals(id))).go();
}
