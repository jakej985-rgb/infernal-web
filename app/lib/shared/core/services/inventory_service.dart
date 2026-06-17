import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart' as uuid;
import '../../cache/id_mapper.dart';
import '../../data/org_provider.dart';
import '../../domain/inventory.dart' as domain;

part 'inventory_service.g.dart';

@riverpod
InventoryService inventoryService(Ref ref) {
  return InventoryService(ref);
}

class InventoryService {
  final Ref _ref;
  InventoryService(this._ref);

  IdMapper get _idMapper => _ref.read(idMapperProvider);
  String get _orgId => _ref.read(orgIdProvider);

  Stream<List<domain.InventoryItem>> watchInventoryItems() {
    final client = sb.Supabase.instance.client;
    return client
        .from('inventory')
        .stream(primaryKey: ['id'])
        .eq('org_id', _orgId)
        .asyncMap((data) async {
          final list = <domain.InventoryItem>[];
          for (final row in data) {
            if (row['is_deleted'] == true) continue;
            list.add(await _mapRowToDomain(row, _idMapper));
          }
          return list;
        });
  }

  Future<void> addItem(domain.InventoryItem item) async {
    final uuidVal = const uuid.Uuid().v4();
    final client = sb.Supabase.instance.client;

    await client.from('inventory').insert({
      'id': uuidVal,
      'org_id': _orgId,
      'name': item.name,
      'category': item.category,
      'stock_quantity': item.stockQuantity,
      'minimum_quantity': item.minimumQuantity,
      'unit': item.unit,
      'supplier': item.supplier ?? '',
      'last_ordered_at': item.lastOrderedAt?.toUtc().toIso8601String(),
      'is_deleted': false,
      'created_at': DateTime.now().toUtc().toIso8601String(),
      'updated_at': DateTime.now().toUtc().toIso8601String(),
    });

    await _idMapper.registerUuid('inventory', uuidVal);
  }

  Future<void> updateItem(domain.InventoryItem item) async {
    final uuidVal = _idMapper.getUuid('inventory', item.id);
    if (uuidVal == null) throw Exception('Cannot resolve ID for inventory item.');

    final client = sb.Supabase.instance.client;
    await client.from('inventory').update({
      'name': item.name,
      'category': item.category,
      'stock_quantity': item.stockQuantity,
      'minimum_quantity': item.minimumQuantity,
      'unit': item.unit,
      'supplier': item.supplier ?? '',
      'last_ordered_at': item.lastOrderedAt?.toUtc().toIso8601String(),
      'updated_at': DateTime.now().toUtc().toIso8601String(),
    }).eq('id', uuidVal);
  }

  Future<void> deleteItem(int id) async {
    final uuidVal = _idMapper.getUuid('inventory', id);
    if (uuidVal == null) throw Exception('Cannot resolve ID for inventory item.');

    final client = sb.Supabase.instance.client;
    await client.from('inventory').update({
      'is_deleted': true,
      'updated_at': DateTime.now().toUtc().toIso8601String(),
    }).eq('id', uuidVal);
  }

  Future<domain.InventoryItem> _mapRowToDomain(
    Map<String, dynamic> row,
    IdMapper idMapper,
  ) async {
    final uuidVal = row['id'] as String;
    final id = await idMapper.registerUuid('inventory', uuidVal);

    final name = row['name'] as String? ?? '';
    final category = row['category'] as String? ?? 'General';
    final stockQuantity = (row['stock_quantity'] as num? ?? 0.0).toDouble();
    final minimumQuantity = (row['minimum_quantity'] as num? ?? 5.0).toDouble();
    final unit = row['unit'] as String? ?? 'pcs';
    final supplier = row['supplier'] as String?;

    final lastOrderedAtStr = row['last_ordered_at'] as String?;
    final lastOrderedAt = lastOrderedAtStr != null && lastOrderedAtStr.isNotEmpty
        ? DateTime.parse(lastOrderedAtStr).toLocal()
        : null;

    final updatedAtStr = row['updated_at'] as String? ?? row['created_at'] as String;
    final updatedAt = DateTime.parse(updatedAtStr).toLocal();

    final isDeleted = row['is_deleted'] as bool? ?? false;

    return domain.InventoryItem(
      id: id,
      syncId: uuidVal,
      name: name,
      category: category,
      stockQuantity: stockQuantity,
      minimumQuantity: minimumQuantity,
      unit: unit,
      supplier: (supplier != null && supplier.isNotEmpty) ? supplier : null,
      lastOrderedAt: lastOrderedAt,
      updatedAt: updatedAt,
      isDeleted: isDeleted,
    );
  }
}
