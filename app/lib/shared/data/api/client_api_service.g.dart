// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_api_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(clientApiService)
final clientApiServiceProvider = ClientApiServiceProvider._();

final class ClientApiServiceProvider
    extends
        $FunctionalProvider<
          ClientApiService,
          ClientApiService,
          ClientApiService
        >
    with $Provider<ClientApiService> {
  ClientApiServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clientApiServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clientApiServiceHash();

  @$internal
  @override
  $ProviderElement<ClientApiService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ClientApiService create(Ref ref) {
    return clientApiService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ClientApiService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ClientApiService>(value),
    );
  }
}

String _$clientApiServiceHash() => r'07ff31f932c8e601598c46f636b92af8a9ffd10c';
