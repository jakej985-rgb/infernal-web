import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/theme/tokens.dart';
import '../../../shared/data/org_provider.dart';
import '../../../shared/core/services/integration_service.dart';
import '../../../shared/presentation/widgets/neon_divider.dart';
import '../../../shared/presentation/widgets/neon_plate.dart';
import '../../../shared/util/url_launcher_helper.dart';

class IntegrationsPage extends ConsumerStatefulWidget {
  const IntegrationsPage({super.key});

  @override
  ConsumerState<IntegrationsPage> createState() => _IntegrationsPageState();
}

class _IntegrationsPageState extends ConsumerState<IntegrationsPage> {
  final _formKey = GlobalKey<FormState>();
  final _hostController = TextEditingController();
  final _portController = TextEditingController(text: '587');
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isTesting = false;
  bool _isSaving = false;
  bool _isDisconnecting = false;
  bool _showSmtpForm = false;

  @override
  void dispose() {
    _hostController.dispose();
    _portController.dispose();
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _connectGoogle() async {
    final orgId = ref.read(orgIdProvider);
    final redirect = getCurrentUrl();
    
    // Construct functions URL for authGoogle
    // In production, functions are deployed under project region and id
    // We target us-central1 region and project 'm3tal-project'
    final authUrl = 'https://us-central1-m3tal-project.cloudfunctions.net/authGoogle'
        '?orgId=$orgId&redirectUrl=${Uri.encodeComponent(redirect)}';
        
    try {
      openUrl(authUrl);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: InfernalColors.error,
            content: Text('Failed to launch connection ritual: $e'),
          ),
        );
      }
    }
  }

  Future<void> _testSmtpConnection() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isTesting = true);
    final service = ref.read(integrationServiceProvider);

    try {
      await service.testSmtpConnection(
        host: _hostController.text.trim(),
        port: int.parse(_portController.text.trim()),
        user: _userController.text.trim(),
        password: _passwordController.text,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: InfernalColors.success,
            content: Text('SMTP Ritual Verified! Test email dispatched successfully.'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: InfernalColors.error,
            content: Text('Ritual failure: $e'),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isTesting = false);
    }
  }

  Future<void> _saveSmtpConfig() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);
    final service = ref.read(integrationServiceProvider);

    try {
      await service.saveSmtpConfig(
        host: _hostController.text.trim(),
        port: int.parse(_portController.text.trim()),
        user: _userController.text.trim(),
        password: _passwordController.text,
      );
      if (mounted) {
        setState(() {
          _showSmtpForm = false;
          _passwordController.clear();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: InfernalColors.success,
            content: Text('SMTP configuration successfully locked in.'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: InfernalColors.error,
            content: Text('Failed to save settings: $e'),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _disconnect() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: InfernalColors.surface,
        title: const Text(
          'SEVER INTEGRATION?',
          style: TextStyle(color: InfernalColors.error, fontWeight: FontWeight.bold, letterSpacing: 2),
        ),
        content: const Text(
          'This will wipe all active tokens and credentials from the system database. Invocations will be disabled.',
          style: TextStyle(color: InfernalColors.textPrimary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('CANCEL'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: InfernalColors.blood),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('DISCONNECT'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    setState(() => _isDisconnecting = true);
    try {
      await ref.read(integrationServiceProvider).disconnectIntegration();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: InfernalColors.success,
            content: Text('Integration severed successfully.'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: InfernalColors.error,
            content: Text('Sever failure: $e'),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isDisconnecting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final configAsync = ref.watch(watchIntegrationConfigProvider);

    return Scaffold(
      backgroundColor: InfernalColors.background,
      appBar: AppBar(
        title: const Text(
          'COMMUNICATION GATEWAYS',
          style: TextStyle(color: InfernalColors.blood, letterSpacing: 3, fontSize: 16),
        ),
        centerTitle: true,
        backgroundColor: InfernalColors.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(InfernalSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const NeonDivider(blurRadius: 10, thickness: 0.5),
            const SizedBox(height: InfernalSpacing.md),
            const Text(
              'Establish the connection conduit for studio communications, confirmations, and scheduling.',
              style: TextStyle(color: InfernalColors.textSecondary, fontSize: 13, height: 1.4),
            ),
            const SizedBox(height: InfernalSpacing.lg),
            configAsync.when(
              data: (config) => _buildGateways(config),
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.0),
                  child: CircularProgressIndicator(color: InfernalColors.blood),
                ),
              ),
              error: (err, _) => NeonPlate(
                color: InfernalColors.error,
                child: Padding(
                  padding: const EdgeInsets.all(InfernalSpacing.md),
                  child: Text('Conduit Error: $err', style: const TextStyle(color: InfernalColors.textPrimary)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGateways(IntegrationConfig config) {
    final activeType = config.type;

    return Column(
      children: [
        // 1. Google OAuth Gateway
        NeonPlate(
          color: activeType == 'google' ? InfernalColors.success : InfernalColors.blood,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.mail_outline,
                    color: activeType == 'google' ? InfernalColors.success : InfernalColors.blood,
                    size: 32,
                  ),
                  const SizedBox(width: InfernalSpacing.md),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'GOOGLE CONDUIT',
                          style: TextStyle(
                            color: InfernalColors.textPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            letterSpacing: 2,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Gmail API + Google Calendar + Contacts list',
                          style: TextStyle(color: InfernalColors.textMuted, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                  if (activeType == 'google')
                    const Icon(Icons.check_circle, color: InfernalColors.success, size: 20),
                ],
              ),
              const SizedBox(height: InfernalSpacing.md),
              const Divider(color: InfernalColors.border, height: 1),
              const SizedBox(height: InfernalSpacing.md),
              if (activeType == 'google') ...[
                _buildGatewayInfo('Connected Account', config.google.email),
                _buildGatewayInfo('Calendar Integration', 'Enabled (Real-time Sync)'),
                _buildGatewayInfo('Contacts API', 'Enabled (Autofill Collector Search)'),
                const SizedBox(height: InfernalSpacing.md),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: InfernalColors.error.withValues(alpha: 0.1),
                      side: const BorderSide(color: InfernalColors.error, width: 0.5),
                    ),
                    icon: _isDisconnecting
                        ? const SizedBox(width: 14, height: 14, child: CircularProgressIndicator(strokeWidth: 2, color: InfernalColors.textPrimary))
                        : const Icon(Icons.link_off, color: InfernalColors.error, size: 16),
                    label: const Text('DISCONNECT CONDUIT', style: TextStyle(color: InfernalColors.textPrimary, fontSize: 11, letterSpacing: 1.5)),
                    onPressed: _isDisconnecting ? null : _disconnect,
                  ),
                ),
              ] else ...[
                const Text(
                  'Connects to Gmail API to dispatch communications and hooks into Google Calendar to automatically update shop sessions.',
                  style: TextStyle(color: InfernalColors.textSecondary, fontSize: 12, height: 1.4),
                ),
                const SizedBox(height: InfernalSpacing.md),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: InfernalColors.blood,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    icon: const Icon(Icons.electric_bolt, color: Colors.white, size: 16),
                    label: const Text(
                      'CONNECT GOOGLE SERVICE',
                      style: TextStyle(color: Colors.white, fontSize: 11, letterSpacing: 1.5, fontWeight: FontWeight.bold),
                    ),
                    onPressed: activeType != null ? null : _connectGoogle,
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: InfernalSpacing.lg),

        // 2. SMTP Gateway
        NeonPlate(
          color: activeType == 'smtp' ? InfernalColors.success : InfernalColors.arcane,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.dns_outlined,
                    color: activeType == 'smtp' ? InfernalColors.success : InfernalColors.arcane,
                    size: 32,
                  ),
                  const SizedBox(width: InfernalSpacing.md),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SMTP FALLBACK',
                          style: TextStyle(
                            color: InfernalColors.textPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            letterSpacing: 2,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Outbound custom email only (No Calendar/Contacts)',
                          style: TextStyle(color: InfernalColors.textMuted, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                  if (activeType == 'smtp')
                    const Icon(Icons.check_circle, color: InfernalColors.success, size: 20),
                ],
              ),
              const SizedBox(height: InfernalSpacing.md),
              const Divider(color: InfernalColors.border, height: 1),
              const SizedBox(height: InfernalSpacing.md),
              if (activeType == 'smtp') ...[
                _buildGatewayInfo('Server Host', config.smtp.host),
                _buildGatewayInfo('Port', config.smtp.port.toString()),
                _buildGatewayInfo('Authentication', config.smtp.user),
                const SizedBox(height: InfernalSpacing.md),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: InfernalColors.error.withValues(alpha: 0.1),
                      side: const BorderSide(color: InfernalColors.error, width: 0.5),
                    ),
                    icon: _isDisconnecting
                        ? const SizedBox(width: 14, height: 14, child: CircularProgressIndicator(strokeWidth: 2, color: InfernalColors.textPrimary))
                        : const Icon(Icons.link_off, color: InfernalColors.error, size: 16),
                    label: const Text('SEVER SMTP GATEWAY', style: TextStyle(color: InfernalColors.textPrimary, fontSize: 11, letterSpacing: 1.5)),
                    onPressed: _isDisconnecting ? null : _disconnect,
                  ),
                ),
              ] else if (_showSmtpForm) ...[
                _buildSmtpForm(),
              ] else ...[
                const Text(
                  'Fallback option to dispatch outbound notification and confirmations utilizing custom SMTP configurations.',
                  style: TextStyle(color: InfernalColors.textSecondary, fontSize: 12, height: 1.4),
                ),
                const SizedBox(height: InfernalSpacing.md),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: InfernalColors.arcane, width: 0.5),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    icon: const Icon(Icons.settings_suggest, color: InfernalColors.textPrimary, size: 16),
                    label: const Text(
                      'CONFIGURE SMTP GATEWAY',
                      style: TextStyle(color: InfernalColors.textPrimary, fontSize: 11, letterSpacing: 1.5),
                    ),
                    onPressed: activeType != null
                        ? null
                        : () => setState(() => _showSmtpForm = true),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGatewayInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: InfernalSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: InfernalColors.textMuted, fontSize: 12)),
          Text(value, style: const TextStyle(color: InfernalColors.textPrimary, fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSmtpForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _hostController,
            style: const TextStyle(color: InfernalColors.textPrimary, fontSize: 13),
            decoration: const InputDecoration(
              labelText: 'Host Server (e.g. smtp.gmail.com)',
              labelStyle: TextStyle(fontSize: 12),
            ),
            validator: (val) => val == null || val.trim().isEmpty ? 'Server host required' : null,
          ),
          const SizedBox(height: InfernalSpacing.sm),
          TextFormField(
            controller: _portController,
            style: const TextStyle(color: InfernalColors.textPrimary, fontSize: 13),
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Port (e.g. 587 or 465)',
              labelStyle: TextStyle(fontSize: 12),
            ),
            validator: (val) {
              if (val == null || val.trim().isEmpty) return 'Port required';
              if (int.tryParse(val.trim()) == null) return 'Invalid integer port';
              return null;
            },
          ),
          const SizedBox(height: InfernalSpacing.sm),
          TextFormField(
            controller: _userController,
            style: const TextStyle(color: InfernalColors.textPrimary, fontSize: 13),
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Authentication User / Email',
              labelStyle: TextStyle(fontSize: 12),
            ),
            validator: (val) => val == null || val.trim().isEmpty ? 'Authentication user required' : null,
          ),
          const SizedBox(height: InfernalSpacing.sm),
          TextFormField(
            controller: _passwordController,
            style: const TextStyle(color: InfernalColors.textPrimary, fontSize: 13),
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Authentication Password',
              labelStyle: TextStyle(fontSize: 12),
            ),
            validator: (val) => val == null || val.isEmpty ? 'Authentication password required' : null,
          ),
          const SizedBox(height: InfernalSpacing.lg),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: InfernalColors.arcane, width: 0.5),
                  ),
                  onPressed: _isTesting || _isSaving ? null : _testSmtpConnection,
                  child: _isTesting
                      ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: InfernalColors.textPrimary))
                      : const Text('TEST CONDUIT', style: TextStyle(color: InfernalColors.textPrimary, fontSize: 11)),
                ),
              ),
              const SizedBox(width: InfernalSpacing.sm),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: InfernalColors.arcane),
                  onPressed: _isTesting || _isSaving ? null : _saveSmtpConfig,
                  child: _isSaving
                      ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : const Text('SAVE CONDUIT', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
          const SizedBox(height: InfernalSpacing.sm),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => setState(() => _showSmtpForm = false),
              child: const Text('CANCEL', style: TextStyle(color: InfernalColors.textMuted, fontSize: 11)),
            ),
          )
        ],
      ),
    );
  }
}
