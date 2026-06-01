// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(inventoryDao)
final inventoryDaoProvider = InventoryDaoProvider._();

final class InventoryDaoProvider
    extends $FunctionalProvider<InventoryDao, InventoryDao, InventoryDao>
    with $Provider<InventoryDao> {
  InventoryDaoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'inventoryDaoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$inventoryDaoHash();

  @$internal
  @override
  $ProviderElement<InventoryDao> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  InventoryDao create(Ref ref) {
    return inventoryDao(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(InventoryDao value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<InventoryDao>(value),
    );
  }
}

String _$inventoryDaoHash() => r'380c4fce9b724ec65d21271a80441d26f9fb562e';

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

String _$inventoryItemsHash() => r'a18d213cdbe9f2785d14ba1d9efae4a707beb579';

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

String _$inventoryServiceHash() => r'0f4e7be5a731a54dc10516175541428713d88de3';

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
