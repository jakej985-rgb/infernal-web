import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../shared/data/interfaces/client_service.dart';
import '../../../../shared/data/api/client_api_service.dart';
import '../../../../shared/domain/client.dart' as domain;

part 'clients_provider.g.dart';

@riverpod
class ClientSearchQuery extends _$ClientSearchQuery {
  @override
  String build() => '';

  void set(String query) => state = query;
}

@riverpod
ClientService clientService(Ref ref) {
  // Toggle between API mode (Production/Extracted) and Drift mode (Local Legacy) in one line:
  return ref.watch(clientApiServiceProvider);
  // return ref.watch(driftClientServiceProvider);
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
