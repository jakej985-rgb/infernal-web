import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'org_provider.g.dart';

@riverpod
String orgId(Ref ref) {
  // TODO: Retrieve the active tenant org ID dynamically from user profile/claims
  return 'default-org';
}
