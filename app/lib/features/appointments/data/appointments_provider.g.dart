// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointments_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(todaysAppointments)
final todaysAppointmentsProvider = TodaysAppointmentsProvider._();

final class TodaysAppointmentsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<domain.Appointment>>,
          List<domain.Appointment>,
          Stream<List<domain.Appointment>>
        >
    with
        $FutureModifier<List<domain.Appointment>>,
        $StreamProvider<List<domain.Appointment>> {
  TodaysAppointmentsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todaysAppointmentsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todaysAppointmentsHash();

  @$internal
  @override
  $StreamProviderElement<List<domain.Appointment>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<domain.Appointment>> create(Ref ref) {
    return todaysAppointments(ref);
  }
}

String _$todaysAppointmentsHash() =>
    r'6f46c1a83780c5dd016d947a0a71c0c8117caaf6';

@ProviderFor(allAppointments)
final allAppointmentsProvider = AllAppointmentsProvider._();

final class AllAppointmentsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<domain.Appointment>>,
          List<domain.Appointment>,
          Stream<List<domain.Appointment>>
        >
    with
        $FutureModifier<List<domain.Appointment>>,
        $StreamProvider<List<domain.Appointment>> {
  AllAppointmentsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allAppointmentsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allAppointmentsHash();

  @$internal
  @override
  $StreamProviderElement<List<domain.Appointment>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<domain.Appointment>> create(Ref ref) {
    return allAppointments(ref);
  }
}

String _$allAppointmentsHash() => r'6a2644fa07882508aa2b4c09b7613641a5a9dee4';

@ProviderFor(upcomingAppointments)
final upcomingAppointmentsProvider = UpcomingAppointmentsProvider._();

final class UpcomingAppointmentsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<domain.Appointment>>,
          List<domain.Appointment>,
          Stream<List<domain.Appointment>>
        >
    with
        $FutureModifier<List<domain.Appointment>>,
        $StreamProvider<List<domain.Appointment>> {
  UpcomingAppointmentsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'upcomingAppointmentsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$upcomingAppointmentsHash();

  @$internal
  @override
  $StreamProviderElement<List<domain.Appointment>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<domain.Appointment>> create(Ref ref) {
    return upcomingAppointments(ref);
  }
}

String _$upcomingAppointmentsHash() =>
    r'296970352db6b9a01d2862b99041a173bedf5746';

@ProviderFor(appointmentDetail)
final appointmentDetailProvider = AppointmentDetailFamily._();

final class AppointmentDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<domain.Appointment?>,
          domain.Appointment?,
          Stream<domain.Appointment?>
        >
    with
        $FutureModifier<domain.Appointment?>,
        $StreamProvider<domain.Appointment?> {
  AppointmentDetailProvider._({
    required AppointmentDetailFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'appointmentDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$appointmentDetailHash();

  @override
  String toString() {
    return r'appointmentDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<domain.Appointment?> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<domain.Appointment?> create(Ref ref) {
    final argument = this.argument as int;
    return appointmentDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AppointmentDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$appointmentDetailHash() => r'2fe130df28fb7a0067dc36e7ddd76a76e72c543c';

final class AppointmentDetailFamily extends $Family
    with $FunctionalFamilyOverride<Stream<domain.Appointment?>, int> {
  AppointmentDetailFamily._()
    : super(
        retry: null,
        name: r'appointmentDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AppointmentDetailProvider call(int id) =>
      AppointmentDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'appointmentDetailProvider';
}

@ProviderFor(appointmentsService)
final appointmentsServiceProvider = AppointmentsServiceProvider._();

final class AppointmentsServiceProvider
    extends
        $FunctionalProvider<
          AppointmentsService,
          AppointmentsService,
          AppointmentsService
        >
    with $Provider<AppointmentsService> {
  AppointmentsServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appointmentsServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appointmentsServiceHash();

  @$internal
  @override
  $ProviderElement<AppointmentsService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AppointmentsService create(Ref ref) {
    return appointmentsService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppointmentsService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppointmentsService>(value),
    );
  }
}

String _$appointmentsServiceHash() =>
    r'7cfb2fe9eac03315c731e565bc46077e9173941e';
