import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'api/client_service_api_impl.dart';
import 'api/appointment_service_api_impl.dart';
import 'interfaces/client_service.dart';
import 'interfaces/appointment_service.dart';

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
  return ref.watch(clientServiceApiImplProvider);
}

@riverpod
AppointmentService globalAppointmentService(Ref ref) {
  return ref.watch(appointmentServiceApiImplProvider);
}
