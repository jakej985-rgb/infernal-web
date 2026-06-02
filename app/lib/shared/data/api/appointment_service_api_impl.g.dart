// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_service_api_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appointmentServiceApiImpl)
final appointmentServiceApiImplProvider = AppointmentServiceApiImplProvider._();

final class AppointmentServiceApiImplProvider
    extends
        $FunctionalProvider<
          AppointmentServiceApiImpl,
          AppointmentServiceApiImpl,
          AppointmentServiceApiImpl
        >
    with $Provider<AppointmentServiceApiImpl> {
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
  $ProviderElement<AppointmentServiceApiImpl> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AppointmentServiceApiImpl create(Ref ref) {
    return appointmentServiceApiImpl(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppointmentServiceApiImpl value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppointmentServiceApiImpl>(value),
    );
  }
}

String _$appointmentServiceApiImplHash() =>
    r'7d7d74674a853ce4a7edbf787d8f1c762be5e588';
