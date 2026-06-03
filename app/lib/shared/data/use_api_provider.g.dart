// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'use_api_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controls whether the app uses the Go API backend or Firebase directly.
/// Hardcoded to false now that the API layer is deleted.

@ProviderFor(UseApi)
final useApiProvider = UseApiProvider._();

/// Controls whether the app uses the Go API backend or Firebase directly.
/// Hardcoded to false now that the API layer is deleted.
final class UseApiProvider extends $NotifierProvider<UseApi, bool> {
  /// Controls whether the app uses the Go API backend or Firebase directly.
  /// Hardcoded to false now that the API layer is deleted.
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

String _$useApiHash() => r'1a6411b3d6269e9743f424976d725eea68fb4c18';

/// Controls whether the app uses the Go API backend or Firebase directly.
/// Hardcoded to false now that the API layer is deleted.

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

@ProviderFor(clientServiceFirebaseImpl)
final clientServiceFirebaseImplProvider = ClientServiceFirebaseImplProvider._();

final class ClientServiceFirebaseImplProvider
    extends $FunctionalProvider<ClientService, ClientService, ClientService>
    with $Provider<ClientService> {
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
  $ProviderElement<ClientService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ClientService create(Ref ref) {
    return clientServiceFirebaseImpl(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ClientService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ClientService>(value),
    );
  }
}

String _$clientServiceFirebaseImplHash() =>
    r'efb286012067dccc5ac85b82af10c0473bad4768';

@ProviderFor(appointmentServiceFirebaseImpl)
final appointmentServiceFirebaseImplProvider =
    AppointmentServiceFirebaseImplProvider._();

final class AppointmentServiceFirebaseImplProvider
    extends
        $FunctionalProvider<
          AppointmentService,
          AppointmentService,
          AppointmentService
        >
    with $Provider<AppointmentService> {
  AppointmentServiceFirebaseImplProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appointmentServiceFirebaseImplProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appointmentServiceFirebaseImplHash();

  @$internal
  @override
  $ProviderElement<AppointmentService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AppointmentService create(Ref ref) {
    return appointmentServiceFirebaseImpl(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppointmentService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppointmentService>(value),
    );
  }
}

String _$appointmentServiceFirebaseImplHash() =>
    r'94b0b4d8e5f70ce9dd39a69923440d9bfc96a86e';

/// Primary client service — always uses the Firebase implementation.

@ProviderFor(globalClientService)
final globalClientServiceProvider = GlobalClientServiceProvider._();

/// Primary client service — always uses the Firebase implementation.

final class GlobalClientServiceProvider
    extends $FunctionalProvider<ClientService, ClientService, ClientService>
    with $Provider<ClientService> {
  /// Primary client service — always uses the Firebase implementation.
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
    r'63c28e511fdee2d9bce459af327a74bc5f32c306';

/// Primary appointment service — always uses the Firebase implementation.

@ProviderFor(globalAppointmentService)
final globalAppointmentServiceProvider = GlobalAppointmentServiceProvider._();

/// Primary appointment service — always uses the Firebase implementation.

final class GlobalAppointmentServiceProvider
    extends
        $FunctionalProvider<
          AppointmentService,
          AppointmentService,
          AppointmentService
        >
    with $Provider<AppointmentService> {
  /// Primary appointment service — always uses the Firebase implementation.
  GlobalAppointmentServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'globalAppointmentServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$globalAppointmentServiceHash();

  @$internal
  @override
  $ProviderElement<AppointmentService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AppointmentService create(Ref ref) {
    return globalAppointmentService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppointmentService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppointmentService>(value),
    );
  }
}

String _$globalAppointmentServiceHash() =>
    r'9202ede33fddc3a84ee16b9cc0bea9895b8e3f57';
