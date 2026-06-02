import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'interfaces/client_service.dart';
import 'interfaces/appointment_service.dart';
import 'firebase/client_service_firebase_impl.dart';
import 'firebase/appointment_service_firebase_impl.dart';

part 'use_api_provider.g.dart';

@riverpod
class UseApi extends _$UseApi {
  @override
  bool build() {
    // Hardcoded to true as Drift SQLite is fully removed and central Go API/Cloud SQL is the sole database
    return true;
  }

  Future<void> toggle(bool value) async {
    // No-op: Toggle disabled since local DB mode is deleted
  }
}

@riverpod
ClientService globalClientService(Ref ref) {
  return ref.watch(clientServiceFirebaseImplProvider);
}

@riverpod
AppointmentService globalAppointmentService(Ref ref) {
  return ref.watch(appointmentServiceFirebaseImplProvider);
}
