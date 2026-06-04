import 'package:infernal_ink_steel/shared/data/org_labels_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/tokens.dart';
import '../data/user_management_provider.dart';
import '../../../../shared/domain/enums.dart';
import '../../../app/router.dart';
import '../../../shared/data/infernal_labels_provider.dart';

class UserListPage extends ConsumerWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(allUsersProvider);

    final useInfernal = ref.watch(labelModeProvider);
    final customLabels = ref.watch(orgLabelsProvider).value;

    return Scaffold(
      backgroundColor: InfernalColors.background,
      appBar: AppBar(
        title: Text(UiLabels.get('admin_users_title', useInfernal, customLabels)),
        backgroundColor: InfernalColors.surface,
        foregroundColor: InfernalColors.textPrimary,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: InfernalColors.gold,
        foregroundColor: InfernalColors.textPrimary,
        child: const Icon(Icons.person_add),
        onPressed: () => context.go('${AppRoutes.adminUsers}/new'),
      ),
      body: usersAsync.when(
        data: (users) {
          if (users.isEmpty) {
            return const Center(
              child: Text(
                'No users found.',
                style: TextStyle(color: InfernalColors.textMuted),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(InfernalSpacing.md),
            itemCount: users.length,
            separatorBuilder: (_, _) =>
                const SizedBox(height: InfernalSpacing.sm),
            itemBuilder: (ctx, idx) {
              final user = users[idx];
              final isAdminRole = user.role == UserRole.admin;
              return Card(
                color: InfernalColors.surface,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: isAdminRole
                        ? InfernalColors.blood
                        : InfernalColors.arcane,
                    child: Icon(
                      isAdminRole ? Icons.security : Icons.brush,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  title: Text(
                    user.displayName.isEmpty ? user.username : user.displayName,
                    style: const TextStyle(
                      color: InfernalColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '${user.role.name.toUpperCase()} // ${user.username}',
                    style: const TextStyle(
                      color: InfernalColors.textMuted,
                      fontSize: 12,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (user.hourlyRate > 0)
                        Text(
                          '\$${user.hourlyRate.toInt()}/hr',
                          style: const TextStyle(
                            color: InfernalColors.gold,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      const SizedBox(width: InfernalSpacing.sm),
                      const Icon(
                        Icons.chevron_right,
                        color: InfernalColors.textMuted,
                      ),
                    ],
                  ),
                  onTap: () => context.go('${AppRoutes.adminUsers}/${user.id}'),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(
          child: Text(
            'Error: $e',
            style: const TextStyle(color: InfernalColors.error),
          ),
        ),
      ),
    );
  }
}
