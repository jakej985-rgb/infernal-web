import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/tokens.dart';
import '../data/documents_provider.dart';

class DocumentsListPage extends ConsumerWidget {
  const DocumentsListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final docsAsync = ref.watch(filteredDocumentsProvider);

    return Scaffold(
      backgroundColor: InfernalColors.background,
      appBar: AppBar(
        title: const Text('Scrolls & Pacts'),
        backgroundColor: InfernalColors.surface,
        foregroundColor: InfernalColors.textPrimary,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: InfernalColors.arcane,
        foregroundColor: InfernalColors.textPrimary,
        child: const Icon(Icons.upload_file),
        onPressed: () => context.go('/documents/new'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(InfernalSpacing.md),
            child: TextField(
              style: const TextStyle(color: InfernalColors.textPrimary),
              decoration: InputDecoration(
                hintText: 'Search documents...',
                hintStyle: const TextStyle(color: InfernalColors.textMuted),
                prefixIcon: const Icon(
                  Icons.search,
                  color: InfernalColors.textMuted,
                ),
                filled: true,
                fillColor: InfernalColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(InfernalRadius.md),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (val) =>
                  ref.read(documentSearchQueryProvider.notifier).set(val),
            ),
          ),
          Expanded(
            child: docsAsync.when(
              data: (docs) {
                if (docs.isEmpty) {
                  return const Center(
                    child: Text(
                      'No documents found.',
                      style: TextStyle(color: InfernalColors.textMuted),
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: InfernalSpacing.md,
                  ),
                  itemCount: docs.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: InfernalSpacing.sm),
                  itemBuilder: (ctx, idx) {
                    final doc = docs[idx];
                    return Card(
                      color: InfernalColors.surface,
                      margin: EdgeInsets.zero,
                      child: ListTile(
                        leading: const Icon(
                          Icons.description,
                          color: InfernalColors.arcane,
                        ),
                        title: Text(
                          doc.title,
                          style: const TextStyle(
                            color: InfernalColors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          doc.filePath,
                          style: const TextStyle(
                            color: InfernalColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.chevron_right,
                          color: InfernalColors.textMuted,
                        ),
                        onTap: () => context.go('/documents/${doc.id}'),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, s) => Center(child: Text('Error: $e')),
            ),
          ),
        ],
      ),
    );
  }
}
