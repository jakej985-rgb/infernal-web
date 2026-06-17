import 'package:infernal_ink_steel/shared/data/org_labels_provider.dart';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:infernal_ink_steel/features/auth/domain/auth_state.dart';
import '../../../app/theme/tokens.dart';
import '../../../../shared/domain/client.dart';
import '../../../../shared/domain/document.dart';
import '../../auth/domain/auth_service.dart';
import '../../appointments/presentation/widgets/client_selection_modal.dart';
import '../data/documents_provider.dart';
import '../../clients/data/clients_provider.dart';
import '../../../../shared/domain/enums.dart';
import '../../../shared/presentation/labels/infernal_labels.dart';
import '../../../shared/data/infernal_labels_provider.dart';

/// Document type options — admins also get "Other / Custom"
const _kStandardTypes = ['ID Scan', 'Consent Form', 'Work Pic'];

/// Icon per type
IconData _iconForType(String? type) {
  switch (type) {
    case 'ID Scan':
      return Icons.badge;
    case 'Consent Form':
      return Icons.assignment;
    case 'Work Pic':
      return Icons.photo_camera;
    default:
      return Icons.insert_drive_file;
  }
}

class DocumentFormPage extends ConsumerStatefulWidget {
  final String? documentId;
  final int? preSelectedClientId;
  const DocumentFormPage({super.key, this.documentId, this.preSelectedClientId});

  @override
  ConsumerState<DocumentFormPage> createState() => _DocumentFormPageState();
}

class _DocumentFormPageState extends ConsumerState<DocumentFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  double? _uploadProgress;

  final _customTitleCtrl = TextEditingController();
  Client? _selectedClient;
  int? _originalClientId;
  bool _isInit = true;

  String? _selectedType;
  bool _showCustomTitleField = false;

  // File picker state
  Uint8List? _fileBytes;
  String? _fileName;
  String? _contentType;
  String? _existingFilePath;

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
    _customTitleCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    if (widget.preSelectedClientId != null) {
      final client =
          await ref.read(clientDetailProvider(widget.preSelectedClientId!).future);
      if (client != null) {
        setState(() => _selectedClient = client);
      }
    }

    if (widget.documentId != null) {
      final id = int.tryParse(widget.documentId!);
      if (id != null) {
        final doc = await ref.read(documentDetailProvider(id).future);
        if (doc != null) {
          setState(() {
            _existingFilePath = doc.filePath.isNotEmpty ? doc.filePath : null;
            _originalClientId = doc.clientId;
            if (_kStandardTypes.contains(doc.title)) {
              _selectedType = doc.title;
              _showCustomTitleField = false;
            } else {
              _selectedType = 'Other / Custom';
              _showCustomTitleField = true;
              _customTitleCtrl.text = doc.title;
            }
          });
        }
      }
    } else {
      setState(() {
        _selectedType = _kStandardTypes.first;
        _showCustomTitleField = false;
      });
    }
  }

  Future<void> _selectClient() async {
    final result = await showModalBottomSheet<Client>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, controller) => ClientSelectionModal(),
      ),
    );
    if (result != null) setState(() => _selectedClient = result);
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'webp', 'heic'],
      withData: true, // get bytes for web
    );

    if (result == null || result.files.isEmpty) return;

    final file = result.files.first;
    if (file.bytes == null) return;

    // Determine MIME type from extension
    final ext = (file.extension ?? '').toLowerCase();
    final mimeMap = {
      'jpg': 'image/jpeg',
      'jpeg': 'image/jpeg',
      'png': 'image/png',
      'webp': 'image/webp',
      'heic': 'image/heic',
      'pdf': 'application/pdf',
    };

    setState(() {
      _fileBytes = file.bytes;
      _fileName = file.name;
      _contentType = mimeMap[ext];
    });
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final clientId = _selectedClient?.id ?? _originalClientId;
    if (clientId == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Select a client')));
      return;
    }

    // Require a file on new documents
    if (widget.documentId == null && _fileBytes == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Please select a file to upload')));
      return;
    }

    final docTitle = _selectedType == 'Other / Custom'
        ? _customTitleCtrl.text.trim()
        : (_selectedType ?? 'Consent Form');

    if (docTitle.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Enter a document title')));
      return;
    }

    setState(() {
      _isLoading = true;
      _uploadProgress = _fileBytes != null ? 0.0 : null;
    });

    try {
      final authVal = ref.read(authServiceProvider).value;
      final userId =
          authVal?.maybeMap(authenticated: (s) => s.user.id, orElse: () => 1) ?? 1;

      final doc = Document(
        id: widget.documentId == null ? 0 : int.parse(widget.documentId!),
        syncId: '',
        uploadedByUserId: userId,
        clientId: clientId,
        title: docTitle,
        filePath: _existingFilePath ?? '',
        createdAt: DateTime.now(),
        lastModifiedUtc: DateTime.now(),
        lastModifiedBy: 'App',
        isDeleted: false,
      );

      final service = ref.read(documentsServiceProvider);
      if (widget.documentId != null) {
        await service.updateDocument(
          doc,
          bytes: _fileBytes,
          fileName: _fileName,
          contentType: _contentType,
        );
      } else {
        await service.createDocument(
          doc,
          bytes: _fileBytes,
          fileName: _fileName,
          contentType: _contentType,
        );
      }

      if (!mounted) return;
      context.pop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) {
        setState(() {
        _isLoading = false;
        _uploadProgress = null;
      });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final useInfernal = ref.watch(labelModeProvider);
    final customLabels = ref.watch(orgLabelsProvider).value;

    final authVal = ref.watch(authServiceProvider).value;
    final isAdmin = authVal?.maybeMap(
          authenticated: (s) => s.user.role == UserRole.admin,
          orElse: () => false,
        ) ??
        false;

    final options = [..._kStandardTypes];
    if (isAdmin) options.add('Other / Custom');

    // Ensure current value is in list
    if (_selectedType != null && !options.contains(_selectedType)) {
      options.add(_selectedType!);
    }

    final hasFile = _fileBytes != null;
    final hasExisting = _existingFilePath != null && _existingFilePath!.isNotEmpty;

    return Scaffold(
      backgroundColor: InfernalColors.background,
      appBar: AppBar(
        title: Text(
          widget.documentId == null
              ? UiLabels.get('documents_upload', useInfernal, customLabels)
              : UiLabels.get('documents_edit', useInfernal, customLabels),
        ),
        backgroundColor: InfernalColors.surface,
        foregroundColor: InfernalColors.textPrimary,
        actions: [
          IconButton(
            icon: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.check),
            onPressed: _isLoading ? null : _save,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(InfernalSpacing.md),
          children: [
            // ── Upload progress bar ──────────────────────────────────────
            if (_isLoading && _uploadProgress != null)
              Padding(
                padding: const EdgeInsets.only(bottom: InfernalSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Uploading…',
                      style: TextStyle(color: InfernalColors.textSecondary, fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    LinearProgressIndicator(
                      value: _uploadProgress,
                      backgroundColor: InfernalColors.surface,
                      color: InfernalColors.blood,
                    ),
                  ],
                ),
              ),

            // ── Client Picker ─────────────────────────────────────────────
            InkWell(
              onTap: _selectClient,
              borderRadius: BorderRadius.circular(InfernalRadius.md),
              child: Container(
                padding: const EdgeInsets.all(InfernalSpacing.md),
                decoration: BoxDecoration(
                  color: InfernalColors.surface,
                  border: Border.all(color: InfernalColors.border),
                  borderRadius: BorderRadius.circular(InfernalRadius.md),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.person, color: InfernalColors.textSecondary),
                    const SizedBox(width: InfernalSpacing.md),
                    Expanded(
                      child: Text(
                        _selectedClient?.fullName ??
                            (_originalClientId != null
                                ? '${AppLabels.client(useInfernal, customLabels)} #$_originalClientId (tap to change)'
                                : 'Select ${AppLabels.client(useInfernal, customLabels)}'),
                        style: TextStyle(
                          color: (_selectedClient != null || _originalClientId != null)
                              ? InfernalColors.textPrimary
                              : InfernalColors.textMuted,
                        ),
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: InfernalColors.textMuted),
                  ],
                ),
              ),
            ),

            const SizedBox(height: InfernalSpacing.lg),

            // ── Document Type Dropdown ────────────────────────────────────
            DropdownButtonFormField<String>(
              initialValue: _selectedType,
              style: const TextStyle(color: InfernalColors.textPrimary),
              dropdownColor: InfernalColors.surface,
              decoration: const InputDecoration(
                labelText: 'Document Type',
                filled: true,
                fillColor: InfernalColors.surface,
                border: OutlineInputBorder(),
              ),
              items: options.map((opt) {
                return DropdownMenuItem<String>(
                  value: opt,
                  child: Row(
                    children: [
                      Icon(_iconForType(opt),
                          size: 18, color: InfernalColors.textSecondary),
                      const SizedBox(width: 8),
                      Text(opt),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (val) {
                setState(() {
                  _selectedType = val;
                  _showCustomTitleField = val == 'Other / Custom';
                });
              },
              validator: (v) => v == null || v.isEmpty ? 'Select a type' : null,
            ),

            // ── Custom Title field (admin only) ───────────────────────────
            if (_showCustomTitleField) ...[
              const SizedBox(height: InfernalSpacing.md),
              TextFormField(
                controller: _customTitleCtrl,
                style: const TextStyle(color: InfernalColors.textPrimary),
                decoration: const InputDecoration(
                  labelText: 'Custom Title',
                  filled: true,
                  fillColor: InfernalColors.surface,
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
              ),
            ],

            const SizedBox(height: InfernalSpacing.lg),

            // ── File Picker Area ──────────────────────────────────────────
            GestureDetector(
              onTap: _isLoading ? null : _pickFile,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: double.infinity,
                padding: const EdgeInsets.all(InfernalSpacing.xl),
                decoration: BoxDecoration(
                  color: hasFile
                      ? InfernalColors.blood.withValues(alpha: 0.08)
                      : InfernalColors.surface,
                  border: Border.all(
                    color: hasFile ? InfernalColors.blood : InfernalColors.border,
                    width: hasFile ? 2 : 1,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(InfernalRadius.md),
                ),
                child: Column(
                  children: [
                    Icon(
                      hasFile
                          ? (_contentType?.startsWith('image') == true
                              ? Icons.image
                              : Icons.picture_as_pdf)
                          : Icons.upload_file,
                      size: 48,
                      color: hasFile ? InfernalColors.blood : InfernalColors.textMuted,
                    ),
                    const SizedBox(height: InfernalSpacing.md),
                    if (hasFile) ...[
                      Text(
                        _fileName ?? 'File selected',
                        style: const TextStyle(
                          color: InfernalColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${(_fileBytes!.length / 1024).toStringAsFixed(1)} KB  •  tap to change',
                        style: const TextStyle(
                          color: InfernalColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ] else if (hasExisting) ...[
                      const Text(
                        'File already uploaded',
                        style: TextStyle(color: InfernalColors.textSecondary),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Tap to replace',
                        style: TextStyle(
                          color: InfernalColors.textMuted,
                          fontSize: 12,
                        ),
                      ),
                    ] else ...[
                      const Text(
                        'Tap to select a file',
                        style: TextStyle(color: InfernalColors.textMuted),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Accepted: JPG, PNG, PDF, WEBP',
                        style: TextStyle(
                          color: InfernalColors.textMuted,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
