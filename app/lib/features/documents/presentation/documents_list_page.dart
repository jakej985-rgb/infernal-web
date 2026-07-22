import 'package:infernal_ink_steel/shared/data/org_labels_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/tokens.dart';
import '../data/documents_provider.dart';
import '../../../../shared/domain/document.dart';
import '../../../shared/data/infernal_labels_provider.dart';

/// Icon per document type/title
IconData _iconForDoc(Document doc) {
  switch (doc.title) {
    case 'ID Scan':
      return Icons.badge;
    case 'Consent Form':
      return Icons.assignment;
    case 'Work Pic':
      return Icons.photo_camera;
    default:
      if (doc.isPdf) return Icons.picture_as_pdf;
      if (doc.isImage) return Icons.image;
      return Icons.description;
  }
}

Color _colorForDoc(Document doc) {
  switch (doc.title) {
    case 'ID Scan':
      return Colors.blue.shade400;
    case 'Consent Form':
      return Colors.orange.shade400;
    case 'Work Pic':
      return Colors.purple.shade400;
    default:
      return InfernalColors.arcane;
  }
}

class DocumentsListPage extends ConsumerWidget {
  const DocumentsListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final docsAsync = ref.watch(filteredDocumentsProvider);
    final useInfernal = ref.watch(labelModeProvider);
    final customLabels = ref.watch(orgLabelsProvider).value;

    return Scaffold(
      backgroundColor: InfernalColors.background,
      appBar: AppBar(
        title: Text(UiLabels.get('documents_title', useInfernal, customLabels)),
        backgroundColor: InfernalColors.surface,
        foregroundColor: InfernalColors.textPrimary,
        leading: MediaQuery.sizeOf(context).width < 800
            ? IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              )
            : null,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: InfernalColors.blood,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.upload_file),
        label: Text(UiLabels.get('documents_upload', useInfernal, customLabels)),
        onPressed: () => context.go('/documents/new'),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(InfernalSpacing.md),
            child: TextField(
              style: const TextStyle(color: InfernalColors.textPrimary),
              decoration: InputDecoration(
                hintText: UiLabels.get('documents_search', useInfernal, customLabels),
                hintStyle: const TextStyle(color: InfernalColors.textMuted),
                prefixIcon:
                    const Icon(Icons.search, color: InfernalColors.textMuted),
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

          // Type filter chips
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: InfernalSpacing.md),
            child: _TypeFilterChips(ref: ref),
          ),

          const SizedBox(height: InfernalSpacing.sm),

          Expanded(
            child: docsAsync.when(
              data: (docs) {
                if (docs.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.folder_open,
                          size: 64,
                          color: InfernalColors.textMuted.withValues(alpha: 0.4),
                        ),
                        const SizedBox(height: InfernalSpacing.md),
                        Text(
                          UiLabels.get('documents_empty', useInfernal, customLabels),
                          style:
                              const TextStyle(color: InfernalColors.textMuted),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: InfernalSpacing.md,
                    vertical: InfernalSpacing.sm,
                  ),
                  itemCount: docs.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: InfernalSpacing.sm),
                  itemBuilder: (ctx, idx) {
                    final doc = docs[idx];
                    final docColor = _colorForDoc(doc);
                    return Card(
                      color: InfernalColors.surface,
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(InfernalRadius.md),
                        side: const BorderSide(
                          color: InfernalColors.border,
                          width: 1,
                        ),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: InfernalSpacing.md,
                          vertical: InfernalSpacing.sm,
                        ),
                        leading: CircleAvatar(
                          backgroundColor: docColor.withValues(alpha: 0.15),
                          child: Icon(_iconForDoc(doc), color: docColor, size: 22),
                        ),
                        title: Text(
                          doc.title,
                          style: const TextStyle(
                            color: InfernalColors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          doc.filePath.isNotEmpty
                              ? _shortenPath(doc.filePath)
                              : 'No file',
                          style: const TextStyle(
                            color: InfernalColors.textSecondary,
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, s) => Center(child: Text('Error: $e')),
            ),
          ),
        ],
      ),
    );
  }

  String _shortenPath(String path) {
    if (path.startsWith('http')) {
      final uri = Uri.tryParse(path);
      if (uri != null) {
        final segments = uri.pathSegments;
        if (segments.isNotEmpty) return Uri.decodeComponent(segments.last);
      }
    }
    return path;
  }
}

/// Quick filter chips: All / ID Scan / Consent Form / Work Pic
class _TypeFilterChips extends StatefulWidget {
  final WidgetRef ref;
  const _TypeFilterChips({required this.ref});

  @override
  State<_TypeFilterChips> createState() => _TypeFilterChipsState();
}

class _TypeFilterChipsState extends State<_TypeFilterChips> {
  String _active = 'All';

  @override
  Widget build(BuildContext context) {
    final types = ['All', 'ID Scan', 'Consent Form', 'Work Pic'];
    return SizedBox(
      height: 36,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: types.map((t) {
          final selected = _active == t;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(t),
              selected: selected,
              selectedColor: InfernalColors.blood,
              backgroundColor: InfernalColors.surface,
              labelStyle: TextStyle(
                color: selected
                    ? Colors.white
                    : InfernalColors.textSecondary,
                fontSize: 12,
              ),
              onSelected: (_) {
                setState(() => _active = t);
                widget.ref
                    .read(documentSearchQueryProvider.notifier)
                    .set(t == 'All' ? '' : t);
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
