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
    r'a8458a29756df5b5e6feb3bcf19e68cbec567607';

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

@ProviderFor(localSettingsService)
final localSettingsServiceProvider = LocalSettingsServiceProvider._();

final class LocalSettingsServiceProvider
    extends
        $FunctionalProvider<
          LocalSettingsService,
          LocalSettingsService,
          LocalSettingsService
        >
    with $Provider<LocalSettingsService> {
  LocalSettingsServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localSettingsServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localSettingsServiceHash();

  @$internal
  @override
  $ProviderElement<LocalSettingsService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocalSettingsService create(Ref ref) {
    return localSettingsService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalSettingsService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalSettingsService>(value),
    );
  }
}

String _$localSettingsServiceHash() =>
    r'b5ef06e7a0d3964447abc52bc6ed08e67f1df218';
