import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/tokens.dart';
import '../data/user_management_provider.dart';
import '../../../../shared/domain/user.dart';
import '../../../../shared/domain/enums.dart';

class UserFormPage extends ConsumerStatefulWidget {
  final String? userId;
  const UserFormPage({super.key, this.userId});

  @override
  ConsumerState<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends ConsumerState<UserFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  final _usernameCtrl = TextEditingController();
  final _displayNameCtrl = TextEditingController();
  final _rateCtrl = TextEditingController(text: '150');
  final _passwordCtrl = TextEditingController();
  String _selectedRole = 'artist';
  
  User? _existingUser;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
       _loadData();
       _isInit = false;
     }
  }
  
  @override
  void dispose() {
    _usernameCtrl.dispose();
    _displayNameCtrl.dispose();
    _rateCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
     if (widget.userId != null) {
        final id = int.tryParse(widget.userId!);
        if (id != null) {
           final users = await ref.read(allUsersProvider.future);
           final user = users.firstWhere((u) => u.id == id);
           setState(() {
              _existingUser = user;
              _usernameCtrl.text = user.username;
              _displayNameCtrl.text = user.displayName;
              _rateCtrl.text = user.hourlyRate.toString();
              _selectedRole = user.role.name;
           });
        }
     }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      final service = ref.read(userManagementServiceProvider);
      
      if (_existingUser != null) {
        await service.updateUser(
          _existingUser!.copyWith(
            username: _usernameCtrl.text,
            displayName: _displayNameCtrl.text,
            role: UserRole.values.firstWhere((e) => e.name == _selectedRole, orElse: () => UserRole.artist),
            hourlyRate: double.tryParse(_rateCtrl.text) ?? 150.0,
          ),
          newPassword: _passwordCtrl.text.isNotEmpty ? _passwordCtrl.text : null,
        );
      } else {
        await service.createUser(
          username: _usernameCtrl.text,
          password: _passwordCtrl.text,
          displayName: _displayNameCtrl.text,
          role: _selectedRole,
          hourlyRate: double.tryParse(_rateCtrl.text) ?? 150.0,
        );
      }
      
      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: InfernalColors.error),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _delete() async {
    if (_existingUser == null) return;
    
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: InfernalColors.surface,
        title: const Text('Delete User?'),
        content: const Text('This will deactivate the user account.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete', style: TextStyle(color: InfernalColors.error)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      setState(() => _isLoading = true);
      await ref.read(userManagementServiceProvider).deleteUser(_existingUser!.id);
      if (mounted) context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: InfernalColors.background,
      appBar: AppBar(
        title: Text(_existingUser == null ? 'NEW MACHINE SPIRIT' : 'EDIT SPIRIT'),
        backgroundColor: InfernalColors.surface,
        foregroundColor: InfernalColors.textPrimary,
        actions: [
          if (_existingUser != null)
            IconButton(
              icon: const Icon(Icons.delete_outline, color: InfernalColors.error),
              onPressed: _isLoading ? null : _delete,
            ),
          IconButton(
            icon: _isLoading 
              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) 
              : const Icon(Icons.check),
            onPressed: _isLoading ? null : _save,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(InfernalSpacing.lg),
          children: [
            TextFormField(
              controller: _usernameCtrl,
              decoration: const InputDecoration(
                labelText: 'Username (Login)',
                prefixIcon: Icon(Icons.login),
              ),
              style: const TextStyle(color: InfernalColors.textPrimary),
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              enabled: _existingUser == null,
            ),
            const SizedBox(height: InfernalSpacing.md),
            TextFormField(
              controller: _passwordCtrl,
              decoration: InputDecoration(
                labelText: _existingUser == null ? 'Password' : 'New Password (Optional)',
                prefixIcon: const Icon(Icons.lock_outline),
                helperText: _existingUser == null ? 'Initial password for the spirit' : 'Leave blank to retain current password',
              ),
              obscureText: true,
              style: const TextStyle(color: InfernalColors.textPrimary),
              validator: (v) {
                if (_existingUser == null && (v == null || v.isEmpty)) return 'Required';
                return null;
              },
            ),
            const SizedBox(height: InfernalSpacing.md),
            TextFormField(
              controller: _displayNameCtrl,
              decoration: const InputDecoration(
                labelText: 'Display Name',
                prefixIcon: Icon(Icons.badge),
              ),
              style: const TextStyle(color: InfernalColors.textPrimary),
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: InfernalSpacing.md),
            DropdownButtonFormField<String>(
              initialValue: _selectedRole,
              dropdownColor: InfernalColors.surface,
              decoration: const InputDecoration(
                labelText: 'Access Role',
                prefixIcon: Icon(Icons.admin_panel_settings),
              ),
              items: const [
                DropdownMenuItem(value: 'artist', child: Text('Artist', style: TextStyle(color: InfernalColors.textPrimary))),
                DropdownMenuItem(value: 'admin', child: Text('Administrator', style: TextStyle(color: InfernalColors.textPrimary))),
              ],
              onChanged: (v) => setState(() => _selectedRole = v!),
            ),
            const SizedBox(height: InfernalSpacing.md),
            TextFormField(
              controller: _rateCtrl,
              decoration: const InputDecoration(
                labelText: 'Hourly Rate (\$)',
                prefixIcon: Icon(Icons.attach_money),
              ),
              keyboardType: TextInputType.number,
              style: const TextStyle(color: InfernalColors.textPrimary),
              validator: (v) => v == null || double.tryParse(v) == null ? 'Invalid number' : null,
            ),
          ],
        ),
      ),
    );
  }
}
