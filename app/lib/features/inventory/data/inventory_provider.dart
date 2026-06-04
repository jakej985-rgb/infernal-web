import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../shared/core/services/inventory_service.dart' as srv;
import '../../../../shared/domain/inventory.dart' as domain;

part 'inventory_provider.g.dart';

@riverpod
Stream<List<domain.InventoryItem>> inventoryItems(Ref ref) {
  final inventoryService = ref.watch(srv.inventoryServiceProvider);
  return inventoryService.watchInventoryItems();
}

@riverpod
class InventoryService extends _$InventoryService {
  @override
  FutureOr<void> build() {}

  srv.InventoryService get _service => ref.read(srv.inventoryServiceProvider);

  Future<void> addItem(domain.InventoryItem item) async {
    await _service.addItem(item);
  }

  Future<void> updateItem(domain.InventoryItem item) async {
    await _service.updateItem(item);
  }

  Future<void> deleteItem(int id) async {
    await _service.deleteItem(id);
  }
}
