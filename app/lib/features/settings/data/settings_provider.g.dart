// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ShopSettingsNotifier)
final shopSettingsProvider = ShopSettingsNotifierProvider._();

final class ShopSettingsNotifierProvider
    extends $NotifierProvider<ShopSettingsNotifier, ShopSettings> {
  ShopSettingsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shopSettingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shopSettingsNotifierHash();

  @$internal
  @override
  ShopSettingsNotifier create() => ShopSettingsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ShopSettings value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ShopSettings>(value),
    );
  }
}

String _$shopSettingsNotifierHash() =>
    r'498a133b09101fdb8b6baf40ad9ee4d7b96e779f';

abstract class _$ShopSettingsNotifier extends $Notifier<ShopSettings> {
  ShopSettings build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ShopSettings, ShopSettings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ShopSettings, ShopSettings>,
              ShopSettings,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(settingsService)
final settingsServiceProvider = SettingsServiceProvider._();

final class SettingsServiceProvider
    extends
        $FunctionalProvider<SettingsService, SettingsService, SettingsService>
    with $Provider<SettingsService> {
  SettingsServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsServiceHash();

  @$internal
  @override
  $ProviderElement<SettingsService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SettingsService create(Ref ref) {
    return settingsService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SettingsService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SettingsService>(value),
    );
  }
}

String _$settingsServiceHash() => r'baf34b05236fcf0cbf01fd0b3fbadb69195b3e70';
