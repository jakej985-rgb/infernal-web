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

String _$useApiHash() => r'6646087f1df2f7ffea9ad8d032c6c8ff42aca493';

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

@ProviderFor(clientServiceApiImpl)
final clientServiceApiImplProvider = ClientServiceApiImplProvider._();

final class ClientServiceApiImplProvider
    extends $FunctionalProvider<ClientService, ClientService, ClientService>
    with $Provider<ClientService> {
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
  $ProviderElement<ClientService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ClientService create(Ref ref) {
    return clientServiceApiImpl(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ClientService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ClientService>(value),
    );
  }
}

String _$clientServiceApiImplHash() =>
    r'93bfdf144af7270f7ff481f6fccccedf065fa366';

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

@ProviderFor(appointmentServiceApiImpl)
final appointmentServiceApiImplProvider = AppointmentServiceApiImplProvider._();

final class AppointmentServiceApiImplProvider
    extends
        $FunctionalProvider<
          AppointmentService,
          AppointmentService,
          AppointmentService
        >
    with $Provider<AppointmentService> {
  AppointmentServiceApiImplProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appointmentServiceApiImplProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appointmentServiceApiImplHash();

  @$internal
  @override
  $ProviderElement<AppointmentService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AppointmentService create(Ref ref) {
    return appointmentServiceApiImpl(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppointmentService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppointmentService>(value),
    );
  }
}

String _$appointmentServiceApiImplHash() =>
    r'a7355f412ac5a1c25c302816ab9e43578d967e60';

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
    r'8b40359c110dc157a25831c724c094c472417003';

@ProviderFor(globalAppointmentService)
final globalAppointmentServiceProvider = GlobalAppointmentServiceProvider._();

final class GlobalAppointmentServiceProvider
    extends
        $FunctionalProvider<
          AppointmentService,
          AppointmentService,
          AppointmentService
        >
    with $Provider<AppointmentService> {
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
    r'678cda2920999f5dee67eed408c9b62d43b90c32';
