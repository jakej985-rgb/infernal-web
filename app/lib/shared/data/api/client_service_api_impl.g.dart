// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_service_api_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(clientServiceApiImpl)
final clientServiceApiImplProvider = ClientServiceApiImplProvider._();

final class ClientServiceApiImplProvider
    extends
        $FunctionalProvider<
          ClientServiceApiImpl,
          ClientServiceApiImpl,
          ClientServiceApiImpl
        >
    with $Provider<ClientServiceApiImpl> {
  ClientServiceApiImplProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clientServiceApiImplProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clientServiceApiImplHash();

  @$internal
  @override
  $ProviderElement<ClientServiceApiImpl> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ClientServiceApiImpl create(Ref ref) {
    return clientServiceApiImpl(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ClientServiceApiImpl value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ClientServiceApiImpl>(value),
    );
  }
}

String _$clientServiceApiImplHash() =>
    r'36dd14266f4a04fa0a43adb56666508057ce6673';
