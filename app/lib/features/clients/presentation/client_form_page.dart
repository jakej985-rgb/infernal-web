import 'dart:io' as io;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../app/theme/tokens.dart';
import '../../../shared/domain/client.dart';
import '../../../shared/domain/enums.dart';
import '../data/clients_provider.dart';
import '../../../shared/data/infernal_labels_provider.dart';

class ClientFormPage extends ConsumerStatefulWidget {
  final String? clientId; 

  const ClientFormPage({super.key, this.clientId});

  @override
  ConsumerState<ClientFormPage> createState() => _ClientFormPageState();
}

class _ClientFormPageState extends ConsumerState<ClientFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  ClientStatus _status = ClientStatus.bound;
  
  XFile? _avatarFile;
  String? _existingPhotoPath;

  bool _initialized = false;
  bool _isSaving = false;

  bool get _isEdit => widget.clientId != null;

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isEdit) {
      final id = int.tryParse(widget.clientId!);
      if (id == null) {
        return const Scaffold(body: Center(child: Text("Invalid ID")));
      }

      final clientAsync = ref.watch(clientDetailProvider(id));
      return clientAsync.when(
        data: (client) {
          if (client == null) {
            return const Scaffold(
              body: Center(child: Text("Client not found")),
            );
          }

          if (!_initialized) {
            _firstNameCtrl.text = client.firstName;
            _lastNameCtrl.text = client.lastName;
            _emailCtrl.text = client.email;
            _phoneCtrl.text = client.phone;
            _notesCtrl.text = client.notes;
            _status = client.status;
            _existingPhotoPath = client.photoPath;
            _initialized = true;
          }
          return _buildScaffold(context);
        },
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (e, st) => Scaffold(body: Center(child: Text("Error: $e"))),
      );
    } else {
      return _buildScaffold(context);
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _avatarFile = pickedFile;
      });
    }
  }

  Widget _buildScaffold(BuildContext context) {
    final useInfernal = ref.watch(useInfernalLabelsProvider);

    return Scaffold(
      backgroundColor: InfernalColors.background,
      appBar: AppBar(
        title: Text(_isEdit
            ? UiLabels.get('edit_client', useInfernal)
            : UiLabels.get('add_client', useInfernal)),
        backgroundColor: InfernalColors.surface,
        foregroundColor: InfernalColors.textPrimary,
        actions: [
          IconButton(
            icon: _isSaving
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.check),
            onPressed: _isSaving ? null : _save,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(InfernalSpacing.md),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Avatar Picker
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Stack(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: InfernalColors.surface,
                          shape: BoxShape.circle,
                          border: Border.all(color: InfernalColors.blood, width: 2),
                          image: _avatarFile != null
                              ? DecorationImage(
                                  image: kIsWeb 
                                      ? NetworkImage(_avatarFile!.path)
                                      : FileImage(io.File(_avatarFile!.path)), 
                                  fit: BoxFit.cover)
                              : (_existingPhotoPath != null && _existingPhotoPath!.isNotEmpty)
                                  ? DecorationImage(
                                      image: kIsWeb 
                                          ? NetworkImage(_existingPhotoPath!)
                                          : FileImage(io.File(_existingPhotoPath!)), 
                                      fit: BoxFit.cover)
                                  : null,
                        ),
                        child: (_avatarFile == null && (_existingPhotoPath == null || _existingPhotoPath!.isEmpty))
                            ? const Icon(Icons.person_outline, size: 50, color: InfernalColors.textMuted)
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(color: InfernalColors.blood, shape: BoxShape.circle),
                          child: const Icon(Icons.camera_alt, size: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: InfernalSpacing.xl),
              _buildTextField("First Name", _firstNameCtrl, required: true),
              const SizedBox(height: InfernalSpacing.md),
              _buildTextField("Last Name", _lastNameCtrl, required: true),
              const SizedBox(height: InfernalSpacing.md),
              _buildTextField(
                "Email",
                _emailCtrl,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: InfernalSpacing.md),
              _buildTextField(
                "Phone",
                _phoneCtrl,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: InfernalSpacing.md),
              DropdownButtonFormField<ClientStatus>(
                initialValue: _status,
                dropdownColor: InfernalColors.surfaceElevated,
                style: const TextStyle(color: InfernalColors.textPrimary),
                decoration: _inputDecoration("Status"),
                items: ClientStatus.values
                    .map(
                      (s) => DropdownMenuItem(
                        value: s,
                        child: Text(s.name.toUpperCase()),
                      ),
                    )
                    .toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _status = val);
                },
              ),
              const SizedBox(height: InfernalSpacing.md),
              _buildTextField("Notes", _notesCtrl, maxLines: 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController ctrl, {
    bool required = false,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: ctrl,
      style: const TextStyle(color: InfernalColors.textPrimary),
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: required
          ? (val) => val == null || val.isEmpty ? "Required" : null
          : null,
      decoration: _inputDecoration(label),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: InfernalColors.textSecondary),
      filled: true,
      fillColor: InfernalColors.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(InfernalRadius.sm),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(InfernalRadius.sm),
        borderSide: const BorderSide(color: InfernalColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(InfernalRadius.sm),
        borderSide: const BorderSide(color: InfernalColors.blood),
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      final service = ref.read(clientServiceProvider);
      String photoPath = _existingPhotoPath ?? '';

      // Save new image if picked
      if (_avatarFile != null) {
        photoPath = await service.saveAvatar(_avatarFile!);
      }

      if (_isEdit) {
        final id = int.parse(widget.clientId!);
        final existing = await ref.read(clientDetailProvider(id).future);

        if (existing == null) throw Exception("Client not found");

        final updated = existing.copyWith(
          firstName: _firstNameCtrl.text,
          lastName: _lastNameCtrl.text,
          email: _emailCtrl.text,
          phone: _phoneCtrl.text,
          notes: _notesCtrl.text,
          status: _status,
          photoPath: photoPath,
        );
        await service.updateClient(updated);
      } else {
        // Create
        final newClient = Client(
          id: 0, 
          syncId: '', 
          firstName: _firstNameCtrl.text,
          lastName: _lastNameCtrl.text,
          email: _emailCtrl.text,
          phone: _phoneCtrl.text,
          notes: _notesCtrl.text,
          status: _status,
          visits: 0,
          photoPath: photoPath,
          lastModifiedUtc: DateTime.now(),
          lastModifiedBy: 'user',
          isDeleted: false,
        );
        await service.createClient(newClient);
      }

      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: $e"),
            backgroundColor: InfernalColors.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }
}
