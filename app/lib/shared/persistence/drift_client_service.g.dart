// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_client_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(driftClientService)
final driftClientServiceProvider = DriftClientServiceProvider._();

final class DriftClientServiceProvider
    extends
        $FunctionalProvider<
          DriftClientService,
          DriftClientService,
          DriftClientService
        >
    with $Provider<DriftClientService> {
  DriftClientServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'driftClientServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$driftClientServiceHash();

  @$internal
  @override
  $ProviderElement<DriftClientService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DriftClientService create(Ref ref) {
    return driftClientService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DriftClientService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DriftClientService>(value),
    );
  }
}

String _$driftClientServiceHash() =>
    r'8a861b4addace5538f204bed9cc02c19f7caa4e9';
