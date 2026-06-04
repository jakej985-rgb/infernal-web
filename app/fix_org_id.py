import os
filepath = '/home/m3tal/infernal-web/app/lib/shared/data/org_provider.dart'
with open(filepath, 'r') as f:
    content = f.read()

# Replace the body of orgId
new_body = """@riverpod
String orgId(Ref ref) {
  final authState = ref.watch(authServiceProvider);
  final state = authState.value;
  return state?.maybeWhen(
    authenticated: (user) => user.orgId,
    orElse: () => 'default-org',
  ) ?? 'default-org';
}"""

import re
content = re.sub(r'@riverpod\nString orgId\(Ref ref\) \{.*\}', new_body, content, flags=re.DOTALL)

with open(filepath, 'w') as f:
    f.write(content)
