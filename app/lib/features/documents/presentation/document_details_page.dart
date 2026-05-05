import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../app/theme/tokens.dart';
import '../data/documents_provider.dart';

class DocumentDetailsPage extends ConsumerWidget {
  final String documentId;
  const DocumentDetailsPage({super.key, required this.documentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = int.tryParse(documentId);
    if (id == null) return const Scaffold(body: Center(child: Text('Invalid ID')));

    final docAsync = ref.watch(documentDetailProvider(id));

    return Scaffold(
      backgroundColor: InfernalColors.background,
      appBar: AppBar(
        title: const Text('Document Details'),
        backgroundColor: InfernalColors.surface,
        foregroundColor: InfernalColors.textPrimary,
        actions: [
           IconButton(
             icon: const Icon(Icons.edit),
             onPressed: () => context.go('/documents/$id/edit'),
           ),
           IconButton(
             icon: const Icon(Icons.delete, color: InfernalColors.error),
             onPressed: () => _deleteDoc(context, ref, id),
           ),
        ],
      ),
      body: docAsync.when(
         data: (doc) {
            if (doc == null) return const Center(child: Text('Document not found'));
            return Padding(
               padding: const EdgeInsets.all(InfernalSpacing.md),
               child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(doc.title, style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: InfernalColors.textPrimary)),
                     const SizedBox(height: InfernalSpacing.md),
                     Row(
                        children: [
                           const Icon(Icons.calendar_today, size: 16, color: InfernalColors.textSecondary),
                           const SizedBox(width: 8),
                           Text("Uploaded: ${DateFormat.yMMMd().format(doc.createdAt)}", style: const TextStyle(color: InfernalColors.textSecondary)),
                        ],
                     ),
                     const SizedBox(height: InfernalSpacing.sm),
                     Row(
                        children: [
                           const Icon(Icons.person, size: 16, color: InfernalColors.textSecondary),
                           const SizedBox(width: 8),
                           Text("Client ID: ${doc.clientId}", style: const TextStyle(color: InfernalColors.textSecondary)),
                        ],
                     ),
                     const SizedBox(height: InfernalSpacing.lg),
                     const Divider(color: InfernalColors.divider),
                     const SizedBox(height: InfernalSpacing.lg),
                     
                     // File simulation
                     Container(
                        padding: const EdgeInsets.all(InfernalSpacing.lg),
                        width: double.infinity,
                        decoration: BoxDecoration(
                           color: InfernalColors.surface,
                           borderRadius: BorderRadius.circular(InfernalRadius.md),
                           border: Border.all(color: InfernalColors.border),
                        ),
                        child: Column(
                           children: [
                              const Icon(Icons.insert_drive_file, size: 64, color: InfernalColors.arcane),
                              const SizedBox(height: InfernalSpacing.md),
                              Text(doc.filePath.isEmpty ? 'No file path' : doc.filePath, style: const TextStyle(color: InfernalColors.textMuted), textAlign: TextAlign.center),
                              const SizedBox(height: InfernalSpacing.lg),
                              ElevatedButton.icon(
                                 onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Opening file...")));
                                 },
                                 icon: const Icon(Icons.open_in_new),
                                 label: const Text("Open Document"),
                                 style: ElevatedButton.styleFrom(
                                    backgroundColor: InfernalColors.arcane,
                                    foregroundColor: Colors.white,
                                 ),
                              ),
                           ],
                        ),
                     ),
                  ],
               ),
            );
         },
         loading: () => const Center(child: CircularProgressIndicator()),
         error: (e, s) => Center(child: Text("Error: $e")),
      ),
    );
  }
  
  void _deleteDoc(BuildContext context, WidgetRef ref, int id) {
     showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: InfernalColors.surface,
        title: const Text('Delete Document?', style: TextStyle(color: InfernalColors.textPrimary)),
        content: const Text(
          'This action cannot be undone.',
          style: TextStyle(color: InfernalColors.textSecondary),
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
            child: const Text('Delete', style: TextStyle(color: InfernalColors.error)),
          ),
        ],
      ),
    );
  }
}
