import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../shared/cache/id_mapper.dart';
import '../../../../shared/domain/inventory.dart' as domain;

part 'inventory_provider.g.dart';

CollectionReference<Map<String, dynamic>> _inventoryRef() => FirebaseFirestore
    .instance
    .collection('organizations')
    .doc('default-org')
    .collection('inventory');

@riverpod
Stream<List<domain.InventoryItem>> inventoryItems(Ref ref) {
  final idMapper = ref.watch(idMapperProvider);
  return _inventoryRef()
      .where('isDeleted', isEqualTo: false)
      .snapshots()
      .asyncMap((snapshot) async {
        final list = <domain.InventoryItem>[];
        for (final doc in snapshot.docs) {
          list.add(await _mapDocToDomain(doc, idMapper));
        }
        return list;
      });
}

@riverpod
class InventoryService extends _$InventoryService {
  @override
  FutureOr<void> build() {}

  IdMapper get _idMapper => ref.read(idMapperProvider);

  Future<void> addItem(domain.InventoryItem item) async {
    final docRef = _inventoryRef().doc();
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

    await _inventoryRef().doc(uuid).update({
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

    await _inventoryRef().doc(uuid).update({
      'isDeleted': true,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
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
