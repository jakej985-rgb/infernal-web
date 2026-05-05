// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InventoryItem _$InventoryItemFromJson(Map<String, dynamic> json) =>
    _InventoryItem(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      category: json['category'] as String,
      stockQuantity: (json['stockQuantity'] as num).toDouble(),
      minimumQuantity: (json['minimumQuantity'] as num).toDouble(),
      unit: json['unit'] as String,
      supplier: json['supplier'] as String?,
      lastOrderedAt: json['lastOrderedAt'] == null
          ? null
          : DateTime.parse(json['lastOrderedAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      isDeleted: json['isDeleted'] as bool? ?? false,
    );

Map<String, dynamic> _$InventoryItemToJson(_InventoryItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'stockQuantity': instance.stockQuantity,
      'minimumQuantity': instance.minimumQuantity,
      'unit': instance.unit,
      'supplier': instance.supplier,
      'lastOrderedAt': instance.lastOrderedAt?.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'isDeleted': instance.isDeleted,
    };
