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
import '../../../shared/presentation/labels/infernal_labels.dart';

class DocumentFormPage extends ConsumerStatefulWidget {
  final String? documentId;
  const DocumentFormPage({super.key, this.documentId});

  @override
  ConsumerState<DocumentFormPage> createState() => _DocumentFormPageState();
}

class _DocumentFormPageState extends ConsumerState<DocumentFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final _titleCtrl = TextEditingController();
  final _pathCtrl = TextEditingController();
  Client? _selectedClient;
  int? _originalClientId; // To preserve on edit
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
    _titleCtrl.dispose();
    _pathCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    if (widget.documentId != null) {
      final id = int.tryParse(widget.documentId!);
      if (id != null) {
        final doc = await ref.read(documentDetailProvider(id).future);
        if (doc != null) {
          setState(() {
            _titleCtrl.text = doc.title;
            _pathCtrl.text = doc.filePath;
            _originalClientId = doc.clientId;
            // Client name not loaded
          });
        }
      }
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
        builder: (_, _) => ClientSelectionModal(),
      ),
    );

    if (result != null) {
      setState(() => _selectedClient = result);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final clientId = _selectedClient?.id ?? _originalClientId;
    if (clientId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Select a client")));
      return;
    }

    setState(() => _isLoading = true);
    try {
      final authVal = ref.read(authServiceProvider).value;
      final userId =
          authVal?.maybeMap(authenticated: (s) => s.user.id, orElse: () => 1) ??
          1;

      final doc = Document(
        id: widget.documentId == null ? 0 : int.parse(widget.documentId!),
        syncId: '',
        uploadedByUserId: userId,
        clientId: clientId,
        title: _titleCtrl.text,
        filePath: _pathCtrl.text,
        createdAt: DateTime.now(),
        lastModifiedUtc: DateTime.now(),
        lastModifiedBy: 'App',
        isDeleted: false,
      );

      final service = ref.read(documentsServiceProvider);
      if (widget.documentId != null) {
        await service.updateDocument(doc);
      } else {
        await service.createDocument(doc);
      }

      if (!mounted) return;
      context.pop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final useInfernal = ref.watch(useInfernalLabelsProvider);
    return Scaffold(
      backgroundColor: InfernalColors.background,
      appBar: AppBar(
        title: Text(
          widget.documentId == null ? 'New Document' : 'Edit Document',
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
                    const Icon(
                      Icons.person,
                      color: InfernalColors.textSecondary,
                    ),
                    const SizedBox(width: InfernalSpacing.md),
                    Expanded(
                      child: Text(
                        _selectedClient?.fullName ??
                            (_originalClientId != null
                                ? '${AppLabels.client(useInfernal)} ID: $_originalClientId (Tap to Change)'
                                : 'Select ${AppLabels.client(useInfernal)}'),
                        style: TextStyle(
                          color:
                              (_selectedClient != null ||
                                  _originalClientId != null)
                              ? InfernalColors.textPrimary
                              : InfernalColors.textMuted,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: InfernalSpacing.lg),
            TextFormField(
              controller: _titleCtrl,
              style: const TextStyle(color: InfernalColors.textPrimary),
              decoration: const InputDecoration(
                labelText: 'Title',
                filled: true,
                fillColor: InfernalColors.surface,
                border: OutlineInputBorder(),
              ),
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: InfernalSpacing.md),
            TextFormField(
              controller: _pathCtrl,
              style: const TextStyle(color: InfernalColors.textPrimary),
              decoration: const InputDecoration(
                labelText: 'File Path / URL',
                filled: true,
                fillColor: InfernalColors.surface,
                border: OutlineInputBorder(),
                suffixIcon: Icon(
                  Icons.attach_file,
                  color: InfernalColors.textSecondary,
                ),
              ),
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
          ],
        ),
      ),
    );
  }
}
