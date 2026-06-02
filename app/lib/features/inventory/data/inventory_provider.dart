import 'dart:async';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared/cache/id_mapper.dart';
import '../../../shared/util/api_client.dart';
import '../../../../shared/domain/inventory.dart' as domain;

part 'inventory_provider.g.dart';

final _inventoryController = StreamController<List<domain.InventoryItem>>.broadcast();
Future<List<domain.InventoryItem>>? _pendingInventoryFetch;

Future<List<domain.InventoryItem>> _fetchInventory(Ref ref) async {
  final dio = ref.read(apiClientProvider);
  final idMapper = ref.read(idMapperProvider);
  try {
    final response = await dio.get('/inventory');
    final rawList = response.data as List;
    final items = <domain.InventoryItem>[];
    for (final item in rawList) {
      final map = item as Map<String, dynamic>;
      final uuid = map['id'] as String;
      final id = await idMapper.registerUuid('inventory', uuid);
      final name = map['name'] as String? ?? '';
      final description = map['description'] as String? ?? '';
      final quantity = (map['quantity'] as num? ?? 0).toDouble();
      final threshold = (map['low_stock_threshold'] as num? ?? 5).toDouble();
      final updatedAtStr = map['updated_at'] as String?;
      final updatedAt = updatedAtStr != null ? DateTime.parse(updatedAtStr).toLocal() : DateTime.now();

      items.add(domain.InventoryItem(
        id: id,
        syncId: uuid,
        name: name,
        category: 'General',
        stockQuantity: quantity,
        minimumQuantity: threshold,
        unit: 'pcs',
        supplier: description.isNotEmpty ? description : null,
        lastOrderedAt: null,
        updatedAt: updatedAt,
        isDeleted: false,
      ));
    }
    return items;
  } on DioException catch (e) {
    throw ApiClientException.fromDioError(e);
  } catch (e) {
    throw ApiClientException('An unexpected error occurred: $e');
  }
}

void _triggerInventoryUpdate(Ref ref) async {
  if (_pendingInventoryFetch != null) return;
  _pendingInventoryFetch = _fetchInventory(ref);
  try {
    final list = await _pendingInventoryFetch!;
    if (!_inventoryController.isClosed) {
      _inventoryController.add(list);
    }
  } catch (e) {
    if (!_inventoryController.isClosed) {
      _inventoryController.addError(e);
    }
  } finally {
    _pendingInventoryFetch = null;
  }
}

@riverpod
Stream<List<domain.InventoryItem>> inventoryItems(Ref ref) {
  _triggerInventoryUpdate(ref);
  return _inventoryController.stream;
}

@riverpod
class InventoryService extends _$InventoryService {
  @override
  FutureOr<void> build() {}

  Dio get _dio => ref.read(apiClientProvider);
  IdMapper get _idMapper => ref.read(idMapperProvider);

  Future<void> addItem(domain.InventoryItem item) async {
    try {
      final payload = {
        'name': item.name,
        'description': item.supplier ?? '',
        'quantity': item.stockQuantity.toInt(),
        'low_stock_threshold': item.minimumQuantity.toInt(),
      };
      final response = await _dio.post('/inventory', data: payload);
      final uuid = (response.data as Map<String, dynamic>)['id'] as String;
      await _idMapper.registerUuid('inventory', uuid);
      _triggerInventoryUpdate(ref);
    } on DioException catch (e) {
      throw ApiClientException.fromDioError(e);
    }
  }

  Future<void> updateItem(domain.InventoryItem item) async {
    try {
      var uuid = _idMapper.getUuid('inventory', item.id);
      if (uuid == null) {
        await _fetchInventory(ref);
        uuid = _idMapper.getUuid('inventory', item.id);
      }
      if (uuid == null) {
        throw ApiClientException('Could not resolve inventory UUID.');
      }
      final payload = {
        'name': item.name,
        'description': item.supplier ?? '',
        'quantity': item.stockQuantity.toInt(),
        'low_stock_threshold': item.minimumQuantity.toInt(),
      };
      await _dio.put('/inventory/$uuid', data: payload);
      _triggerInventoryUpdate(ref);
    } on DioException catch (e) {
      throw ApiClientException.fromDioError(e);
    }
  }

  Future<void> deleteItem(int id) async {
    try {
      var uuid = _idMapper.getUuid('inventory', id);
      if (uuid == null) {
        await _fetchInventory(ref);
        uuid = _idMapper.getUuid('inventory', id);
      }
      if (uuid == null) {
        throw ApiClientException('Could not resolve inventory UUID.');
      }
      await _dio.delete('/inventory/$uuid');
      _triggerInventoryUpdate(ref);
    } on DioException catch (e) {
      throw ApiClientException.fromDioError(e);
    }
  }
}
