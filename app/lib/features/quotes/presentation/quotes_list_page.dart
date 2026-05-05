import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../app/theme/tokens.dart';
import '../data/quotes_provider.dart';

class QuotesListPage extends ConsumerWidget {
  const QuotesListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quotesAsync = ref.watch(filteredQuotesProvider);

    return Scaffold(
      backgroundColor: InfernalColors.background,
      appBar: AppBar(
        title: const Text('Estimates'),
        backgroundColor: InfernalColors.surface,
        foregroundColor: InfernalColors.textPrimary,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: InfernalColors.gold,
        foregroundColor: InfernalColors.textPrimary,
        child: const Icon(Icons.add),
        onPressed: () => context.go('/quotes/new'),
      ),
      body: Column(
        children: [
            Padding(
               padding: const EdgeInsets.all(InfernalSpacing.md),
               child: TextField(
                  style: const TextStyle(color: InfernalColors.textPrimary),
                  decoration: InputDecoration(
                     hintText: 'Search estimates...',
                     hintStyle: const TextStyle(color: InfernalColors.textMuted),
                     prefixIcon: const Icon(Icons.search, color: InfernalColors.textMuted),
                     filled: true,
                     fillColor: InfernalColors.surface,
                     border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(InfernalRadius.md),
                        borderSide: BorderSide.none,
                     ),
                  ),
                  onChanged: (val) => ref.read(quoteSearchQueryProvider.notifier).set(val),
               ),
            ),
            Expanded(
               child: quotesAsync.when(
                  data: (quotes) {
                      if (quotes.isEmpty) return const Center(child: Text('No estimates found.', style: TextStyle(color: InfernalColors.textMuted)));
                      return ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: InfernalSpacing.md),
                          itemCount: quotes.length,
                          separatorBuilder: (_, _) => const SizedBox(height: InfernalSpacing.sm),
                          itemBuilder: (ctx, idx) {
                              final quote = quotes[idx];
                              return Card(
                                  color: InfernalColors.surface,
                                  margin: EdgeInsets.zero,
                                  child: ListTile(
                                      title: Text(
                                        quote.placement.isEmpty ? 'Unknown Placement' : quote.placement, 
                                        style: const TextStyle(color: InfernalColors.textPrimary, fontWeight: FontWeight.bold)
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(quote.style, style: const TextStyle(color: InfernalColors.textSecondary)),
                                          const SizedBox(height: 4),
                                          Text(
                                             "\$${quote.priceLow.toStringAsFixed(0)} - \$${quote.priceHigh.toStringAsFixed(0)}",
                                             style: const TextStyle(color: InfernalColors.gold, fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      trailing: Column(
                                         mainAxisAlignment: MainAxisAlignment.center,
                                         children: [
                                            Text(DateFormat('MMM d').format(quote.createdAt), style: const TextStyle(color: InfernalColors.textMuted)),
                                            const Icon(Icons.chevron_right, color: InfernalColors.textMuted, size: 16),
                                         ],
                                      ),
                                      onTap: () => context.go('/quotes/${quote.id}'),
                                  ),
                              );
                          },
                      );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, s) => Center(child: Text("Error: $e", style: const TextStyle(color: InfernalColors.error))),
               ),
            ),
        ],
      ),
    );
  }
}
