import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../shared/data/interfaces/client_service.dart';
import '../../../../shared/data/use_api_provider.dart';
import '../../../../shared/domain/appointment.dart' as appointment_domain;
import '../../../../shared/domain/client.dart' as domain;
import '../../../../shared/domain/client_lifecycle.dart';
import '../../appointments/data/appointments_provider.dart';

part 'clients_provider.g.dart';

typedef ClientLifecycleEntry = ({
  domain.Client client,
  ClientLifecycleLabel lifecycle,
});

@riverpod
class ClientSearchQuery extends _$ClientSearchQuery {
  @override
  String build() => '';

  void set(String query) => state = query;
}

// Points to the globalClientServiceProvider in shared/data/use_api_provider.dart
// to maintain feature-level abstraction while enabling global api toggle switching.
@riverpod
ClientService clientService(Ref ref) {
  return ref.watch(globalClientServiceProvider);
}

@riverpod
Stream<List<domain.Client>> filteredClients(Ref ref) {
  final query = ref.watch(clientSearchQueryProvider);
  final service = ref.watch(clientServiceProvider);

  return service.watchClients().map((clients) {
    if (query.isEmpty) return clients;

    final lowerQ = query.toLowerCase();
    return clients.where((c) {
      return c.firstName.toLowerCase().contains(lowerQ) ||
          c.lastName.toLowerCase().contains(lowerQ) ||
          c.email.toLowerCase().contains(lowerQ) ||
          c.phone.contains(lowerQ);
    }).toList();
  });
}

@riverpod
Stream<domain.Client?> clientDetail(Ref ref, int id) {
  final service = ref.watch(clientServiceProvider);
  return service.watchClientById(id);
}

@riverpod
Stream<List<ClientLifecycleEntry>> filteredClientsWithLifecycle(Ref ref) {
  final query = ref.watch(clientSearchQueryProvider);
  final clientService = ref.watch(clientServiceProvider);
  final appointmentService = ref.watch(appointmentServiceProvider);

  return Rx.combineLatest2<
    List<domain.Client>,
    List<appointment_domain.Appointment>,
    List<ClientLifecycleEntry>
  >(clientService.watchClients(), appointmentService.watchAppointments(), (
    clients,
    appointments,
  ) {
    final filteredClients = _filterClients(clients, query);
    final now = DateTime.now();
    return filteredClients
        .map(
          (client) => (
            client: client,
            lifecycle: deriveClientLifecycle(
              client: client,
              appointments: appointments,
              now: now,
            ),
          ),
        )
        .toList();
  });
}

@riverpod
Stream<ClientLifecycleLabel?> clientLifecycle(Ref ref, int id) {
  final clientService = ref.watch(clientServiceProvider);
  final appointmentService = ref.watch(appointmentServiceProvider);

  return Rx.combineLatest2<
    domain.Client?,
    List<appointment_domain.Appointment>,
    ClientLifecycleLabel?
  >(clientService.watchClientById(id), appointmentService.watchAppointments(), (
    client,
    appointments,
  ) {
    if (client == null) return null;
    return deriveClientLifecycle(
      client: client,
      appointments: appointments,
      now: DateTime.now(),
    );
  });
}

List<domain.Client> _filterClients(List<domain.Client> clients, String query) {
  if (query.isEmpty) return clients;

  final lowerQ = query.toLowerCase();
  return clients.where((c) {
    return c.firstName.toLowerCase().contains(lowerQ) ||
        c.lastName.toLowerCase().contains(lowerQ) ||
        c.email.toLowerCase().contains(lowerQ) ||
        c.phone.contains(lowerQ);
  }).toList();
}
