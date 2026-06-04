// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(inventoryItems)
final inventoryItemsProvider = InventoryItemsProvider._();

final class InventoryItemsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<domain.InventoryItem>>,
          List<domain.InventoryItem>,
          Stream<List<domain.InventoryItem>>
        >
    with
        $FutureModifier<List<domain.InventoryItem>>,
        $StreamProvider<List<domain.InventoryItem>> {
  InventoryItemsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'inventoryItemsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$inventoryItemsHash();

  @$internal
  @override
  $StreamProviderElement<List<domain.InventoryItem>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<domain.InventoryItem>> create(Ref ref) {
    return inventoryItems(ref);
  }
}

String _$inventoryItemsHash() => r'5e1499f0dfa0f7b8f5877848a33fc7b76e29ce08';

@ProviderFor(InventoryService)
final inventoryServiceProvider = InventoryServiceProvider._();

final class InventoryServiceProvider
    extends $AsyncNotifierProvider<InventoryService, void> {
  InventoryServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'inventoryServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$inventoryServiceHash();

  @$internal
  @override
  InventoryService create() => InventoryService();
}

String _$inventoryServiceHash() => r'210f2fcd516e61373ad5dad7f5724bbf16d8e650';

abstract class _$InventoryService extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
