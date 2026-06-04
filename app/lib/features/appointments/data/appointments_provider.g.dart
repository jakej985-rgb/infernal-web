// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointments_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appointmentService)
final appointmentServiceProvider = AppointmentServiceProvider._();

final class AppointmentServiceProvider
    extends
        $FunctionalProvider<
          AppointmentService,
          AppointmentService,
          AppointmentService
        >
    with $Provider<AppointmentService> {
  AppointmentServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appointmentServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appointmentServiceHash();

  @$internal
  @override
  $ProviderElement<AppointmentService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AppointmentService create(Ref ref) {
    return appointmentService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppointmentService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppointmentService>(value),
    );
  }
}

String _$appointmentServiceHash() =>
    r'7b1746581351fd294b909042b09f978b4249e9a8';

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
    r'951c2ee490c352b8a49dd372df258b923dc37e62';

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

String _$allAppointmentsHash() => r'6c9c35d823db54107f329f898f3af46e4af54ef1';

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
    r'39d775b821e5f93d903273472fb1776eeb838c56';

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

String _$appointmentDetailHash() => r'332d6e1884fba87fa59bdd68de3a8262020ce2af';

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
