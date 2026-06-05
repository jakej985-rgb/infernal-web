import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../shared/data/org_provider.dart';
import '../../../shared/data/org_labels_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../features/auth/domain/auth_service.dart';
import '../../../features/auth/domain/auth_state.dart';

import '../../../app/router.dart';
import '../../../app/theme/tokens.dart';
import '../../../shared/presentation/widgets/neon_plate.dart';
import '../../../shared/presentation/widgets/neon_divider.dart';
import '../data/settings_provider.dart';
import '../../../shared/data/infernal_labels_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(shopSettingsProvider);
    final authState = ref.watch(authServiceProvider).value;
    final userEmail = authState?.maybeWhen(
      authenticated: (user) => user.username,
      orElse: () => '',
    );
    final isSystemAdmin = userEmail == 'admin@inkandsteel.xyz';

    return Scaffold(
      backgroundColor: InfernalColors.background,
      appBar: AppBar(
        title: Text(
          UiLabels.get('settings_title', ref.watch(labelModeProvider)),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: InfernalColors.blood,
            letterSpacing: 4,
          ),
        ),
        centerTitle: true,
        backgroundColor: InfernalColors.surface,
        elevation: 0,
      ),
      body: _buildSettingsList(context, ref, settings, isSystemAdmin),
    );
  }

  Widget _buildSettingsList(
    BuildContext context,
    WidgetRef ref,
    ShopSettings? settings,
    bool isSystemAdmin,
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
              subtitle:
                  '${settings?.depositType ?? 'percentage'}: ${settings?.depositAmount ?? 0}',
              icon: Icons.payments,
              onTap: () => _showDepositDialog(context, ref, settings),
            ),
            _SettingsItem(
              title: 'Integrations',
              subtitle: 'Google OAuth & SMTP fallback',
              icon: Icons.sync,
              onTap: () => context.go(AppRoutes.settingsIntegrations),
            ),
          ],
        ),
        const SizedBox(height: InfernalSpacing.lg),
        _SettingsSection(
          title: 'Administration',
          icon: Icons.admin_panel_settings,
          color: InfernalColors.arcane,
          items: [
            if (isSystemAdmin)
              _SettingsItem(
                title: 'Shop Requests',
                subtitle: 'Review & approve new tenant requests',
                icon: Icons.reviews,
                onTap: () => context.go(AppRoutes.adminRequests),
              ),
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
          title: 'Theme',
          icon: Icons.palette,
          color: InfernalColors.ember,
          items: [
            _SettingsItem(
              title: 'Studio Terminology',
              subtitle: _getSubtitleForMode(ref.watch(labelModeProvider)),
              icon: Icons.auto_awesome,
              trailing: DropdownButton<String>(
                value: ref.watch(labelModeProvider),
                dropdownColor: InfernalColors.surface,
                underline: const SizedBox(),
                items: const [
                  DropdownMenuItem(value: kLabelModeStandard, child: Text('Standard', style: TextStyle(color: InfernalColors.textPrimary))),
                  DropdownMenuItem(value: kLabelModeStudio, child: Text('Studio', style: TextStyle(color: InfernalColors.textPrimary))),
                  DropdownMenuItem(value: kLabelModeInfernal, child: Text('Infernal', style: TextStyle(color: InfernalColors.textPrimary))),
                  DropdownMenuItem(value: kLabelModeCustom, child: Text('Custom (Override)', style: TextStyle(color: InfernalColors.gold))),
                ],
                onChanged: (val) {
                  if (val != null) {
                    ref.read(labelModeProvider.notifier).setMode(val);
                  }
                },
              ),
              onTap: () {},
            ),
            if (ref.watch(labelModeProvider) == kLabelModeCustom)
              _SettingsItem(
                title: 'Edit Custom Labels',
                subtitle: 'Customize shop terminology',
                icon: Icons.edit_note,
                onTap: () => _showCustomLabelsDialog(context, ref),
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

  String _getSubtitleForMode(String mode) {
    switch (mode) {
      case kLabelModeStudio:
        return 'Studio terminology active (Studio, Sessions, Canvases)';
      case kLabelModeInfernal:
        return 'Infernal terminology active (Altar, Dark Rites, Bound Souls)';
      case kLabelModeCustom:
        return 'Custom terminology active (Configured by your shop)';
      default:
        return 'Standard terminology active (Home, Calendar, Contacts)';
    }
  }

    void _showCustomLabelsDialog(BuildContext context, WidgetRef ref) {
    final customLabelsAsync = ref.watch(orgLabelsProvider);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: InfernalColors.surface,
        title: const Text(
          'CUSTOM LABELS',
          style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold),
        ),
        content: customLabelsAsync.when(
          data: (custom) => _CustomLabelsEditor(initialData: custom, ref: ref),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Text('Error loading labels: $e'),
        ),
      ),
    );
  }

  void _showShopProfileDialog(
    BuildContext context,
    WidgetRef ref,
    ShopSettings? settings,
  ) {
    final nameCtrl = TextEditingController(text: settings?.shopName);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: InfernalColors.surface,
        title: const Text(
          'SHOP PROFILE',
          style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold),
        ),
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
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('CANCEL'),
          ),
          ElevatedButton(
            onPressed: () {
              ref
                  .read(localSettingsServiceProvider)
                  .updateShopProfile(shopName: nameCtrl.text);
              Navigator.pop(ctx);
            },
            child: const Text('SAVE'),
          ),
        ],
      ),
    );
  }

  void _showPricingDialog(
    BuildContext context,
    WidgetRef ref,
    ShopSettings? settings,
  ) {
    final tattooCtrl = TextEditingController(
      text: settings?.tattooPerHour.toString(),
    );
    final minCtrl = TextEditingController(
      text: settings?.shopMinimumRate.toString(),
    );
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: InfernalColors.surface,
        title: const Text(
          'PRICING SETTINGS',
          style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: tattooCtrl,
              decoration: const InputDecoration(
                labelText: 'Tattoo Hourly Rate',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: InfernalSpacing.md),
            TextField(
              controller: minCtrl,
              decoration: const InputDecoration(labelText: 'Shop Minimum'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('CANCEL'),
          ),
          ElevatedButton(
            onPressed: () {
              ref
                  .read(localSettingsServiceProvider)
                  .updatePricing(
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

  void _showDepositDialog(
    BuildContext context,
    WidgetRef ref,
    ShopSettings? settings,
  ) {
    final amountCtrl = TextEditingController(
      text: settings?.depositAmount.toString(),
    );
    String currentType = settings?.depositType ?? 'percentage';
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          backgroundColor: InfernalColors.surface,
          title: const Text(
            'DEPOSIT CONFIG',
            style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                initialValue: currentType,
                dropdownColor: InfernalColors.surface,
                decoration: const InputDecoration(labelText: 'Deposit Type'),
                items: const [
                  DropdownMenuItem(
                    value: 'percentage',
                    child: Text(
                      'Percentage (%)',
                      style: TextStyle(color: InfernalColors.textPrimary),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'fixed',
                    child: Text(
                      'Fixed Amount (\$)',
                      style: TextStyle(color: InfernalColors.textPrimary),
                    ),
                  ),
                ],
                onChanged: (val) => setState(() => currentType = val!),
              ),
              const SizedBox(height: InfernalSpacing.md),
              TextField(
                controller: amountCtrl,
                decoration: const InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('CANCEL'),
            ),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(localSettingsServiceProvider)
                    .updateDepositConfig(
                      depositType: currentType,
                      depositAmount: double.tryParse(amountCtrl.text),
                    );
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
        title: const Text(
          'RESET SETTINGS?',
          style: TextStyle(
            color: InfernalColors.error,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          'This will revert all shop configuration to factory defaults. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('CANCEL'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: InfernalColors.blood,
            ),
            onPressed: () {
              ref.read(localSettingsServiceProvider).resetToDefaults();
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
    this.trailing,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: InfernalColors.textSecondary, size: 20),
      title: Text(
        title,
        style: const TextStyle(
          color: InfernalColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: InfernalColors.textMuted, fontSize: 13),
      ),
      trailing:
          trailing ??
          const Icon(
            Icons.chevron_right,
            color: InfernalColors.textMuted,
            size: 20,
          ),
      onTap: onTap,
    );
  }
}

class _CustomLabelsEditor extends StatefulWidget {
  final Map<String, String> initialData;
  final WidgetRef ref;
  const _CustomLabelsEditor({required this.initialData, required this.ref});

  @override
  State<_CustomLabelsEditor> createState() => _CustomLabelsEditorState();
}

class _CustomLabelsEditorState extends State<_CustomLabelsEditor> {
  late final TextEditingController _contactsCtrl;
  late final TextEditingController _calendarCtrl;
  late final TextEditingController _quotesCtrl;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _contactsCtrl = TextEditingController(text: widget.initialData['contacts'] ?? '');
    _calendarCtrl = TextEditingController(text: widget.initialData['calendar'] ?? '');
    _quotesCtrl = TextEditingController(text: widget.initialData['quotes'] ?? '');
  }

  @override
  void dispose() {
    _contactsCtrl.dispose();
    _calendarCtrl.dispose();
    _quotesCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _isSaving = true);
    try {
      final orgId = widget.ref.read(orgIdProvider);
      
      final updates = <String, dynamic>{
        if (_contactsCtrl.text.isNotEmpty) 'labels.contacts': _contactsCtrl.text,
        if (_calendarCtrl.text.isNotEmpty) 'labels.calendar': _calendarCtrl.text,
        if (_quotesCtrl.text.isNotEmpty) 'labels.quotes': _quotesCtrl.text,
      };

      if (updates.isEmpty) {
        // Just clear
        await FirebaseFirestore.instance.collection('organizations').doc(orgId).update({
          'labels': FieldValue.delete(),
        });
      } else {
        await FirebaseFirestore.instance.collection('organizations').doc(orgId).set({
          'labels': {
            if (_contactsCtrl.text.isNotEmpty) 'contacts': _contactsCtrl.text,
            if (_calendarCtrl.text.isNotEmpty) 'calendar': _calendarCtrl.text,
            if (_quotesCtrl.text.isNotEmpty) 'quotes': _quotesCtrl.text,
          }
        }, SetOptions(merge: true));
      }
      
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _reset() async {
    setState(() => _isSaving = true);
    try {
      final orgId = widget.ref.read(orgIdProvider);
      await FirebaseFirestore.instance.collection('organizations').doc(orgId).update({
        'labels': FieldValue.delete(),
      });
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _contactsCtrl,
            style: const TextStyle(color: InfernalColors.textPrimary),
            decoration: const InputDecoration(labelText: 'Contacts / Clients', hintText: 'Collectors'),
          ),
          const SizedBox(height: InfernalSpacing.md),
          TextField(
            controller: _calendarCtrl,
            style: const TextStyle(color: InfernalColors.textPrimary),
            decoration: const InputDecoration(labelText: 'Calendar / Appointments', hintText: 'Bookings'),
          ),
          const SizedBox(height: InfernalSpacing.md),
          TextField(
            controller: _quotesCtrl,
            style: const TextStyle(color: InfernalColors.textPrimary),
            decoration: const InputDecoration(labelText: 'Quotes / Estimates', hintText: 'Estimates'),
          ),
          const SizedBox(height: InfernalSpacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: _isSaving ? null : _reset,
                child: const Text('RESET', style: TextStyle(color: InfernalColors.error)),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: _isSaving ? null : () => Navigator.pop(context),
                    child: const Text('CANCEL'),
                  ),
                  ElevatedButton(
                    onPressed: _isSaving ? null : _save,
                    child: _isSaving 
                      ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Text('SAVE'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
