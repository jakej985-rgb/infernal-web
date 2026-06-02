import 'package:freezed_annotation/freezed_annotation.dart';

part 'inventory.freezed.dart';
part 'inventory.g.dart';

@freezed
abstract class InventoryItem with _$InventoryItem {
  const factory InventoryItem({
    required int id,
    @Default('') String syncId,
    required String name,
    required String category,
    required double stockQuantity,
    required double minimumQuantity,
    required String unit,
    String? supplier,
    required DateTime? lastOrderedAt,
    required DateTime updatedAt,

    @Default(false) bool isDeleted,
  }) = _InventoryItem;

  factory InventoryItem.fromJson(Map<String, dynamic> json) =>
      _$InventoryItemFromJson(json);
}
