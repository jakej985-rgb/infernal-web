import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../app/theme/tokens.dart';
import '../../../shared/presentation/widgets/neon_plate.dart';
import '../../../shared/presentation/widgets/neon_divider.dart';
import '../data/settings_provider.dart';
import '../../../shared/persistence/database.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(shopSettingsProvider);

    return Scaffold(
      backgroundColor: InfernalColors.background,
      appBar: AppBar(
        title: Text(
          'MACHINE SPIRIT',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: InfernalColors.blood,
            letterSpacing: 4,
          ),
        ),
        centerTitle: true,
        backgroundColor: InfernalColors.surface,
        elevation: 0,
      ),
      body: settingsAsync.when(
        data: (settings) => _buildSettingsList(context, ref, settings),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildSettingsList(
    BuildContext context,
    WidgetRef ref,
    ShopSettingsTableData? settings,
  ) {
    return ListView(
      padding: const EdgeInsets.all(InfernalSpacing.lg),
      children: [
        const NeonDivider(blurRadius: 10, thickness: 0.5),
        const SizedBox(height: InfernalSpacing.md),
        _SettingsSection(
          title: 'Shop Configuration',
          icon: Icons.storefront,
          color: InfernalColors.blood,
          items: [
            _SettingsItem(
              title: 'Shop Profile',
              subtitle: settings?.shopName ?? 'Name, logo, accent color',
              icon: Icons.business,
              onTap: () => _showShopProfileDialog(context, ref, settings),
            ),
            _SettingsItem(
              title: 'Pricing',
              subtitle: 'Hourly rates, minimums',
              icon: Icons.attach_money,
              onTap: () => _showPricingDialog(context, ref, settings),
            ),
             _SettingsItem(
              title: 'Deposits',
              subtitle: '${settings?.depositType ?? 'percentage'}: ${settings?.depositAmount ?? 0}',
              icon: Icons.payments,
              onTap: () => _showDepositDialog(context, ref, settings),
            ),
          ],
        ),
        const SizedBox(height: InfernalSpacing.lg),
        _SettingsSection(
          title: 'Administration',
          icon: Icons.admin_panel_settings,
          color: InfernalColors.arcane,
          items: [
            _SettingsItem(
              title: 'User Management',
              subtitle: 'Artists and admins',
              icon: Icons.group,
              onTap: () => context.go(AppRoutes.adminUsers),
            ),
            _SettingsItem(
              title: 'System Status',
              subtitle: 'Audit logs & machine health',
              icon: Icons.analytics,
              onTap: () => context.go(AppRoutes.systemStatus),
            ),
          ],
        ),
        const SizedBox(height: InfernalSpacing.lg),
        _SettingsSection(
          title: 'System',
          icon: Icons.settings,
          color: InfernalColors.voidColor,
          items: [
            _SettingsItem(
              title: 'Reset to Defaults',
              subtitle: 'Revert all settings to factory defaults',
              icon: Icons.restore,
              onTap: () => _showResetConfirmation(context, ref),
            ),
          ],
        ),
        const SizedBox(height: 100),
      ],
    );
  }

  void _showShopProfileDialog(BuildContext context, WidgetRef ref, ShopSettingsTableData? settings) {
    final nameCtrl = TextEditingController(text: settings?.shopName);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: InfernalColors.surface,
        title: const Text('SHOP PROFILE', style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: 'Shop Name'),
              style: const TextStyle(color: InfernalColors.textPrimary),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('CANCEL')),
          ElevatedButton(
            onPressed: () {
              ref.read(settingsServiceProvider).updateShopProfile(shopName: nameCtrl.text);
              Navigator.pop(ctx);
            },
            child: const Text('SAVE'),
          ),
        ],
      ),
    );
  }

  void _showPricingDialog(BuildContext context, WidgetRef ref, ShopSettingsTableData? settings) {
    final tattooCtrl = TextEditingController(text: settings?.tattooPerHour.toString());
    final minCtrl = TextEditingController(text: settings?.shopMinimumRate.toString());
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: InfernalColors.surface,
        title: const Text('PRICING SETTINGS', style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: tattooCtrl, decoration: const InputDecoration(labelText: 'Tattoo Hourly Rate'), keyboardType: TextInputType.number),
            const SizedBox(height: InfernalSpacing.md),
            TextField(controller: minCtrl, decoration: const InputDecoration(labelText: 'Shop Minimum'), keyboardType: TextInputType.number),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('CANCEL')),
          ElevatedButton(
            onPressed: () {
              ref.read(settingsServiceProvider).updatePricing(
                tattooPerHour: double.tryParse(tattooCtrl.text),
                shopMinimumRate: double.tryParse(minCtrl.text),
              );
              Navigator.pop(ctx);
            },
            child: const Text('SAVE'),
          ),
        ],
      ),
    );
  }

  void _showDepositDialog(BuildContext context, WidgetRef ref, ShopSettingsTableData? settings) {
    final amountCtrl = TextEditingController(text: settings?.depositAmount.toString());
    String currentType = settings?.depositType ?? 'percentage';
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          backgroundColor: InfernalColors.surface,
          title: const Text('DEPOSIT CONFIG', style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
               DropdownButtonFormField<String>(
                initialValue: currentType,
                dropdownColor: InfernalColors.surface,
                decoration: const InputDecoration(labelText: 'Deposit Type'),
                items: const [
                  DropdownMenuItem(value: 'percentage', child: Text('Percentage (%)', style: TextStyle(color: InfernalColors.textPrimary))),
                  DropdownMenuItem(value: 'fixed', child: Text('Fixed Amount (\$)', style: TextStyle(color: InfernalColors.textPrimary))),
                ],
                onChanged: (val) => setState(() => currentType = val!),
              ),
              const SizedBox(height: InfernalSpacing.md),
              TextField(controller: amountCtrl, decoration: const InputDecoration(labelText: 'Amount'), keyboardType: TextInputType.number),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('CANCEL')),
            ElevatedButton(
              onPressed: () {
                ref.read(settingsServiceProvider).updateDepositConfig(depositType: currentType, depositAmount: double.tryParse(amountCtrl.text));
                Navigator.pop(ctx);
              },
              child: const Text('SAVE'),
            ),
          ],
        ),
      ),
    );
  }

  void _showResetConfirmation(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: InfernalColors.surface,
        title: const Text('RESET SETTINGS?', style: TextStyle(color: InfernalColors.error, fontWeight: FontWeight.bold)),
        content: const Text('This will revert all shop configuration to factory defaults. This action cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('CANCEL')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: InfernalColors.blood),
            onPressed: () {
              ref.read(settingsServiceProvider).resetToDefaults();
              Navigator.pop(ctx);
            },
            child: const Text('RESET'),
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({
    required this.title,
    required this.icon,
    required this.items,
    required this.color,
  });

  final String title;
  final IconData icon;
  final List<_SettingsItem> items;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return NeonPlate(
      color: color,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(InfernalSpacing.md),
            child: Row(
              children: [
                Icon(icon, color: color, size: InfernalIconSize.sm),
                const SizedBox(width: InfernalSpacing.sm),
                Text(
                  title.toUpperCase(),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: InfernalColors.textPrimary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: InfernalColors.divider),
          ...items,
        ],
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  const _SettingsItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: InfernalColors.textSecondary, size: 20),
      title: Text(title, style: const TextStyle(color: InfernalColors.textPrimary, fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: const TextStyle(color: InfernalColors.textMuted, fontSize: 13)),
      trailing: const Icon(Icons.chevron_right, color: InfernalColors.textMuted, size: 20),
      onTap: onTap,
    );
  }
}
