import 'package:infernal_ink_steel/shared/data/org_labels_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../app/theme/tokens.dart';
import '../data/documents_provider.dart';
import '../../../../shared/domain/document.dart';
import '../../../shared/data/infernal_labels_provider.dart';

class DocumentDetailsPage extends ConsumerWidget {
  final String documentId;
  const DocumentDetailsPage({super.key, required this.documentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = int.tryParse(documentId);
    if (id == null) {
      return const Scaffold(body: Center(child: Text('Invalid ID')));
    }

    final docAsync = ref.watch(documentDetailProvider(id));
    final useInfernal = ref.watch(labelModeProvider);
    final customLabels = ref.watch(orgLabelsProvider).value;

    return Scaffold(
      backgroundColor: InfernalColors.background,
      appBar: AppBar(
        title: Text(UiLabels.get('document_details', useInfernal, customLabels)),
        backgroundColor: InfernalColors.surface,
        foregroundColor: InfernalColors.textPrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.go('/documents/$id/edit'),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: InfernalColors.error),
            onPressed: () => _deleteDoc(context, ref, id, useInfernal, customLabels),
          ),
        ],
      ),
      body: docAsync.when(
        data: (doc) {
          if (doc == null) {
            return const Center(child: Text('Document not found'));
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(InfernalSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header card ─────────────────────────────────────────
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(InfernalSpacing.lg),
                  decoration: BoxDecoration(
                    color: InfernalColors.surface,
                    borderRadius: BorderRadius.circular(InfernalRadius.md),
                    border: Border.all(color: InfernalColors.border),
                  ),
                  child: Column(
                    children: [
                      _typeIcon(doc),
                      const SizedBox(height: InfernalSpacing.md),
                      Text(
                        doc.title,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                          color: InfernalColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: InfernalSpacing.sm),
                      Text(
                        'Uploaded ${DateFormat.yMMMd().format(doc.createdAt)}',
                        style: const TextStyle(
                          color: InfernalColors.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: InfernalSpacing.lg),

                // ── File Preview ─────────────────────────────────────────
                _FilePreview(doc: doc),

                const SizedBox(height: InfernalSpacing.lg),

                // ── Open / Download button ────────────────────────────────
                if (doc.filePath.isNotEmpty)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _openFile(context, doc, useInfernal, customLabels),
                      icon: const Icon(Icons.open_in_new),
                      label: Text(UiLabels.get('document_open', useInfernal, customLabels)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: InfernalColors.blood,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: InfernalSpacing.md),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _typeIcon(Document doc) {
    IconData icon;
    Color color;
    switch (doc.title) {
      case 'ID Scan':
        icon = Icons.badge;
        color = Colors.blue.shade400;
        break;
      case 'Consent Form':
        icon = Icons.assignment;
        color = Colors.orange.shade400;
        break;
      case 'Work Pic':
        icon = Icons.photo_camera;
        color = Colors.purple.shade400;
        break;
      default:
        icon = doc.isPdf ? Icons.picture_as_pdf : Icons.insert_drive_file;
        color = InfernalColors.arcane;
    }
    return CircleAvatar(
      radius: 30,
      backgroundColor: color.withValues(alpha: 0.15),
      child: Icon(icon, size: 32, color: color),
    );
  }

  void _openFile(BuildContext context, Document doc, String useInfernal, Map<String, String>? customLabels) {
    if (kIsWeb && doc.filePath.startsWith('http')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Opening: ${doc.filePath}'),
          action: SnackBarAction(label: 'OK', onPressed: () {}),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Opening file…')),
      );
    }
  }

  void _deleteDoc(
      BuildContext context, WidgetRef ref, int id, String useInfernal, Map<String, String>? customLabels) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: InfernalColors.surface,
        title: Text(
          UiLabels.get('document_delete_title', useInfernal, customLabels),
          style: const TextStyle(color: InfernalColors.textPrimary),
        ),
        content: Text(
          UiLabels.get('document_delete_content', useInfernal, customLabels),
          style: const TextStyle(color: InfernalColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await ref.read(documentsServiceProvider).deleteDocument(id);
              if (context.mounted) context.pop();
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: InfernalColors.error),
            ),
          ),
        ],
      ),
    );
  }
}

/// Renders a preview based on file type
class _FilePreview extends StatelessWidget {
  final Document doc;
  const _FilePreview({required this.doc});

  @override
  Widget build(BuildContext context) {
    final hasUrl = doc.filePath.isNotEmpty && doc.filePath.startsWith('http');

    if (!hasUrl) return const _EmptyPreview();

    if (doc.isImage) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(InfernalRadius.md),
        child: Image.network(
          doc.filePath,
          width: double.infinity,
          fit: BoxFit.contain,
          loadingBuilder: (_, child, progress) {
            if (progress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: progress.expectedTotalBytes != null
                    ? progress.cumulativeBytesLoaded /
                        progress.expectedTotalBytes!
                    : null,
              ),
            );
          },
          errorBuilder: (_, e, _) => const _ErrorPreview(),
        ),
      );
    }

    if (doc.isPdf) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(InfernalSpacing.xl),
        decoration: BoxDecoration(
          color: InfernalColors.surface,
          borderRadius: BorderRadius.circular(InfernalRadius.md),
          border: Border.all(color: InfernalColors.border),
        ),
        child: Column(
          children: [
            Icon(Icons.picture_as_pdf, size: 64, color: Colors.red.shade400),
            const SizedBox(height: InfernalSpacing.md),
            const Text(
              'PDF Document',
              style: TextStyle(
                  color: InfernalColors.textPrimary,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'Tap "Open Document" below to view',
              style: TextStyle(
                  color: InfernalColors.textSecondary, fontSize: 12),
            ),
          ],
        ),
      );
    }

    return const _EmptyPreview();
  }
}

class _EmptyPreview extends StatelessWidget {
  const _EmptyPreview();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(InfernalSpacing.xl),
      decoration: BoxDecoration(
        color: InfernalColors.surface,
        borderRadius: BorderRadius.circular(InfernalRadius.md),
        border: Border.all(color: InfernalColors.border),
      ),
      child: const Column(
        children: [
          Icon(Icons.insert_drive_file,
              size: 64, color: InfernalColors.textMuted),
          SizedBox(height: InfernalSpacing.md),
          Text('No file uploaded',
              style: TextStyle(color: InfernalColors.textMuted)),
        ],
      ),
    );
  }
}

class _ErrorPreview extends StatelessWidget {
  const _ErrorPreview();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(InfernalSpacing.xl),
      decoration: BoxDecoration(
        color: InfernalColors.surface,
        borderRadius: BorderRadius.circular(InfernalRadius.md),
        border: Border.all(color: InfernalColors.border),
      ),
      child: const Column(
        children: [
          Icon(Icons.broken_image, size: 64, color: InfernalColors.textMuted),
          SizedBox(height: InfernalSpacing.md),
          Text('Could not load preview',
              style: TextStyle(color: InfernalColors.textMuted)),
        ],
      ),
    );
  }
}
