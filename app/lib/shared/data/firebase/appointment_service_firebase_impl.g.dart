// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_service_firebase_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appointmentServiceFirebaseImpl)
final appointmentServiceFirebaseImplProvider =
    AppointmentServiceFirebaseImplProvider._();

final class AppointmentServiceFirebaseImplProvider
    extends
        $FunctionalProvider<
          AppointmentServiceFirebaseImpl,
          AppointmentServiceFirebaseImpl,
          AppointmentServiceFirebaseImpl
        >
    with $Provider<AppointmentServiceFirebaseImpl> {
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
  $ProviderElement<AppointmentServiceFirebaseImpl> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AppointmentServiceFirebaseImpl create(Ref ref) {
    return appointmentServiceFirebaseImpl(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppointmentServiceFirebaseImpl value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppointmentServiceFirebaseImpl>(
        value,
      ),
    );
  }
}

String _$appointmentServiceFirebaseImplHash() =>
    r'67e23a05beee880e8b886337cb68836d23240e31';
