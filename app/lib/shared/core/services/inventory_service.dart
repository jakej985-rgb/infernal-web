import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../cache/id_mapper.dart';
import '../../data/org_provider.dart';
import '../../domain/inventory.dart' as domain;
import 'firestore_helpers.dart';

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

  CollectionReference<Map<String, dynamic>> get _inventoryRef =>
      orgDoc(_orgId).collection('inventory');

  Stream<List<domain.InventoryItem>> watchInventoryItems() {
    return _inventoryRef
        .where('isDeleted', isEqualTo: false)
        .snapshots()
        .asyncMap((snapshot) async {
          final list = <domain.InventoryItem>[];
          for (final doc in snapshot.docs) {
            list.add(await _mapDocToDomain(doc, _idMapper));
          }
          return list;
        });
  }

  Future<void> addItem(domain.InventoryItem item) async {
    final docRef = _inventoryRef.doc();
    final uuid = docRef.id;

    await docRef.set({
      'name': item.name,
      'category': item.category,
      'stockQuantity': item.stockQuantity,
      'minimumQuantity': item.minimumQuantity,
      'unit': item.unit,
      'supplier': item.supplier ?? '',
      'lastOrderedAt': item.lastOrderedAt != null
          ? Timestamp.fromDate(item.lastOrderedAt!)
          : null,
      'isDeleted': false,
      'updatedAt': FieldValue.serverTimestamp(),
    });

    await _idMapper.registerUuid('inventory', uuid);
  }

  Future<void> updateItem(domain.InventoryItem item) async {
    final uuid = _idMapper.getUuid('inventory', item.id);
    if (uuid == null) throw Exception('Cannot resolve ID for inventory item.');

    await _inventoryRef.doc(uuid).update({
      'name': item.name,
      'category': item.category,
      'stockQuantity': item.stockQuantity,
      'minimumQuantity': item.minimumQuantity,
      'unit': item.unit,
      'supplier': item.supplier ?? '',
      'lastOrderedAt': item.lastOrderedAt != null
          ? Timestamp.fromDate(item.lastOrderedAt!)
          : null,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteItem(int id) async {
    final uuid = _idMapper.getUuid('inventory', id);
    if (uuid == null) throw Exception('Cannot resolve ID for inventory item.');

    await _inventoryRef.doc(uuid).update({
      'isDeleted': true,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<domain.InventoryItem> _mapDocToDomain(
    DocumentSnapshot<Map<String, dynamic>> doc,
    IdMapper idMapper,
  ) async {
    final uuid = doc.id;
    final id = await idMapper.registerUuid('inventory', uuid);

    final data = doc.data() ?? {};
    final name = data['name'] as String? ?? '';
    final category = data['category'] as String? ?? 'General';
    final stockQuantity = (data['stockQuantity'] as num? ?? 0.0).toDouble();
    final minimumQuantity = (data['minimumQuantity'] as num? ?? 5.0).toDouble();
    final unit = data['unit'] as String? ?? 'pcs';
    final supplier = data['supplier'] as String?;

    final lastOrderedAtTimestamp = data['lastOrderedAt'] as Timestamp?;
    final lastOrderedAt = lastOrderedAtTimestamp?.toDate();

    final updatedAtTimestamp = data['updatedAt'] as Timestamp?;
    final updatedAt = updatedAtTimestamp?.toDate() ?? DateTime.now();

    final isDeleted = data['isDeleted'] as bool? ?? false;

    return domain.InventoryItem(
      id: id,
      syncId: uuid,
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
