import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'interfaces/client_service.dart';
import 'interfaces/appointment_service.dart';
import '../core/services/client_service_firebase_impl.dart';
import '../core/services/appointment_service_firebase_impl.dart';

part 'use_api_provider.g.dart';

/// Controls whether the app uses the Go API backend or Firebase directly.
/// Hardcoded to false now that the API layer is deleted.
@riverpod
class UseApi extends _$UseApi {
  @override
  bool build() {
    return false;
  }

  // ignore: no-op kept to avoid breaking the settings page UI
  void toggle(bool value) {}
}

@riverpod
ClientService clientServiceFirebaseImpl(Ref ref) {
  return ClientServiceFirebaseImpl(ref);
}

@riverpod
AppointmentService appointmentServiceFirebaseImpl(Ref ref) {
  return AppointmentServiceFirebaseImpl(ref);
}

/// Primary client service — always uses the Firebase implementation.
@riverpod
ClientService globalClientService(Ref ref) {
  return ref.watch(clientServiceFirebaseImplProvider);
}

/// Primary appointment service — always uses the Firebase implementation.
@riverpod
AppointmentService globalAppointmentService(Ref ref) {
  return ref.watch(appointmentServiceFirebaseImplProvider);
}
