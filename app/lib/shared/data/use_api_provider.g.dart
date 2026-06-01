// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'use_api_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UseApi)
final useApiProvider = UseApiProvider._();

final class UseApiProvider extends $NotifierProvider<UseApi, bool> {
  UseApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'useApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$useApiHash();

  @$internal
  @override
  UseApi create() => UseApi();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$useApiHash() => r'afd377c09cf25da6f4e25e97c756240bef15f5f7';

abstract class _$UseApi extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(globalClientService)
final globalClientServiceProvider = GlobalClientServiceProvider._();

final class GlobalClientServiceProvider
    extends $FunctionalProvider<ClientService, ClientService, ClientService>
    with $Provider<ClientService> {
  GlobalClientServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'globalClientServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$globalClientServiceHash();

  @$internal
  @override
  $ProviderElement<ClientService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ClientService create(Ref ref) {
    return globalClientService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ClientService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ClientService>(value),
    );
  }
}

String _$globalClientServiceHash() =>
    r'07a25204f7575c6d00d293ccee86241330e5ce87';
