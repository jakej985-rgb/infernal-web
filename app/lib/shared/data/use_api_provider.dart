import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../persistence/drift_client_service.dart';
import '../util/shared_prefs_provider.dart';
import 'api/client_service_api_impl.dart';
import 'interfaces/client_service.dart';

part 'use_api_provider.g.dart';

@riverpod
class UseApi extends _$UseApi {
  static const _storageKey = 'use_api_client';

  @override
  bool build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    // Default to true (Direct central cloud database API mode)
    return prefs.getBool(_storageKey) ?? true;
  }

  Future<void> toggle(bool value) async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setBool(_storageKey, value);
    state = value;
  }
}

@riverpod
ClientService globalClientService(Ref ref) {
  final useApi = ref.watch(useApiProvider);
  if (useApi) {
    return ref.watch(clientServiceApiImplProvider);
  } else {
    return ref.watch(driftClientServiceProvider);
  }
}
