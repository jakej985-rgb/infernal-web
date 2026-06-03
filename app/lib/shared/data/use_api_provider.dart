import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'interfaces/client_service.dart';
import 'interfaces/appointment_service.dart';
import '../core/services/client_service_firebase_impl.dart';
import '../core/services/client_service_api_impl.dart';
import '../core/services/appointment_service_firebase_impl.dart';
import '../core/services/appointment_service_api_impl.dart';

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

@riverpod
ClientService globalClientService(Ref ref) {
  final useApi = ref.watch(useApiProvider);
  if (useApi) {
    return ref.watch(clientServiceApiImplProvider);
  }
  return ref.watch(clientServiceFirebaseImplProvider);
}

@riverpod
AppointmentService globalAppointmentService(Ref ref) {
  final useApi = ref.watch(useApiProvider);
  if (useApi) {
    return ref.watch(appointmentServiceApiImplProvider);
  }
  return ref.watch(appointmentServiceFirebaseImplProvider);
}

