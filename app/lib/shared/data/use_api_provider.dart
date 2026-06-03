import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'interfaces/client_service.dart';
import 'interfaces/appointment_service.dart';
import '../core/services/client_service_firebase_impl.dart';
import '../core/services/client_service_api_impl.dart';
import '../core/services/appointment_service_firebase_impl.dart';
import '../core/services/appointment_service_api_impl.dart';

part 'use_api_provider.g.dart';

/// Controls whether the app uses the Go API backend or Firebase directly.
/// Currently hardcoded to true (Go API mode).
@riverpod
class UseApi extends _$UseApi {
  @override
  bool build() {
    // Go API / Cloud SQL is the sole backend — always true
    return true;
  }

  // ignore: no-op kept to avoid breaking the settings page UI
  void toggle(bool value) {}
}

@riverpod
ClientService clientServiceFirebaseImpl(Ref ref) {
  return ClientServiceFirebaseImpl(ref);
}

@riverpod
ClientService clientServiceApiImpl(Ref ref) {
  return ClientServiceApiImpl(ref);
}

@riverpod
AppointmentService appointmentServiceFirebaseImpl(Ref ref) {
  return AppointmentServiceFirebaseImpl(ref);
}

@riverpod
AppointmentService appointmentServiceApiImpl(Ref ref) {
  return AppointmentServiceApiImpl(ref);
}

/// Primary client service — always uses the API implementation.
@riverpod
ClientService globalClientService(Ref ref) {
  return ref.watch(clientServiceApiImplProvider);
}

/// Primary appointment service — always uses the API implementation.
@riverpod
AppointmentService globalAppointmentService(Ref ref) {
  return ref.watch(appointmentServiceApiImplProvider);
}
