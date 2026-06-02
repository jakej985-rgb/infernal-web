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
    r'63c28e511fdee2d9bce459af327a74bc5f32c306';

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
    r'9202ede33fddc3a84ee16b9cc0bea9895b8e3f57';
