// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_service_firebase_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(clientServiceFirebaseImpl)
final clientServiceFirebaseImplProvider = ClientServiceFirebaseImplProvider._();

final class ClientServiceFirebaseImplProvider
    extends
        $FunctionalProvider<
          ClientServiceFirebaseImpl,
          ClientServiceFirebaseImpl,
          ClientServiceFirebaseImpl
        >
    with $Provider<ClientServiceFirebaseImpl> {
  ClientServiceFirebaseImplProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clientServiceFirebaseImplProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clientServiceFirebaseImplHash();

  @$internal
  @override
  $ProviderElement<ClientServiceFirebaseImpl> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ClientServiceFirebaseImpl create(Ref ref) {
    return clientServiceFirebaseImpl(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ClientServiceFirebaseImpl value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ClientServiceFirebaseImpl>(value),
    );
  }
}

String _$clientServiceFirebaseImplHash() =>
    r'0be71b37693a1c3461e9672136ca267a7b5f9311';
