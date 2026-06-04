import re

filepath = '/home/m3tal/infernal-web/app/lib/shared/data/org_provider.dart'
with open(filepath, 'r') as f:
    content = f.read()

# Make sure auth_state.dart is imported
if 'auth_state.dart' not in content:
    content = content.replace("import '../../features/auth/domain/auth_service.dart';", 
                              "import '../../features/auth/domain/auth_service.dart';\nimport '../../features/auth/domain/auth_state.dart';")

new_body = """@riverpod
String orgId(Ref ref) {
  final authState = ref.watch(authServiceProvider);
  return authState.value?.maybeMap(
    authenticated: (s) => s.user.orgId,
    orElse: () => 'default-org',
  ) ?? 'default-org';
}"""

content = re.sub(r'@riverpod\nString orgId\(Ref ref\) \{.*\}', new_body, content, flags=re.DOTALL)

with open(filepath, 'w') as f:
    f.write(content)
