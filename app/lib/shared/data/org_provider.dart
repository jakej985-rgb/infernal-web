import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../features/auth/domain/auth_service.dart';
import '../../features/auth/domain/auth_state.dart';

part 'org_provider.g.dart';

@riverpod
String orgId(Ref ref) {
  final authState = ref.watch(authServiceProvider);
  return authState.value?.maybeMap(
    authenticated: (s) => s.user.orgId,
    orElse: () => 'default-org',
  ) ?? 'default-org';
}
