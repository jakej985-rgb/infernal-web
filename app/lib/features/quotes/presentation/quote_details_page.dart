import 'package:infernal_ink_steel/shared/data/org_labels_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../app/theme/tokens.dart';
import '../data/quotes_provider.dart';
import '../../../app/router.dart';
import '../../../shared/data/infernal_labels_provider.dart';

class QuoteDetailsPage extends ConsumerWidget {
  final String quoteId;

  const QuoteDetailsPage({super.key, required this.quoteId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useInfernal = ref.watch(labelModeProvider);
    final customLabels = ref.watch(orgLabelsProvider).value;
    final id = int.tryParse(quoteId);
    if (id == null) {
      return const Scaffold(body: Center(child: Text('Invalid ID')));
    }

    final quoteAsync = ref.watch(quoteDetailProvider(id));

    return Scaffold(
      backgroundColor: InfernalColors.background,
      appBar: AppBar(
        title: Text(UiLabels.get('quote_details', useInfernal, customLabels)),
        backgroundColor: InfernalColors.surface,
        foregroundColor: InfernalColors.textPrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.go('${AppRoutes.quotes}/$id/edit'),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: InfernalColors.error),
            onPressed: () => _deleteQuote(context, ref, id, useInfernal, customLabels),
          ),
        ],
      ),
      body: quoteAsync.when(
        data: (quote) {
          if (quote == null) {
            return Center(
              child: Text(UiLabels.get('quote_not_found', useInfernal, customLabels)),
            );
          }
          return ListView(
            padding: const EdgeInsets.all(InfernalSpacing.md),
            children: [
              // Header Card
              Container(
                padding: const EdgeInsets.all(InfernalSpacing.lg),
                decoration: BoxDecoration(
                  color: InfernalColors.surface,
                  borderRadius: BorderRadius.circular(InfernalRadius.md),
                  border: Border.all(color: InfernalColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            quote.placement,
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  color: InfernalColors.textPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        if (quote.isCoverUp)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: InfernalColors.voidColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'COVER-UP',
                              style: TextStyle(
                                color: InfernalColors.blood,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      quote.style,
                      style: const TextStyle(
                        color: InfernalColors.textSecondary,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: InfernalSpacing.md),
                    Row(
                      children: [
                        _Badge(
                          icon: Icons.aspect_ratio,
                          label: '${quote.width}" x ${quote.height}"',
                        ),
                        const SizedBox(width: InfernalSpacing.md),
                        _Badge(
                          icon: Icons.calendar_today,
                          label: DateFormat('MM/dd/yy').format(quote.createdAt),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: InfernalSpacing.lg),

              // Estimate Box
              Container(
                padding: const EdgeInsets.all(InfernalSpacing.lg),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      InfernalColors.surface,
                      InfernalColors.surfaceElevated,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(InfernalRadius.md),
                  border: Border.all(
                    color: InfernalColors.gold.withValues(alpha: 0.3),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: InfernalColors.gold.withValues(alpha: 0.05),
                      blurRadius: 10,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'ESTIMATED PRICE',
                      style: TextStyle(
                        color: InfernalColors.gold,
                        letterSpacing: 1.5,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: InfernalSpacing.sm),
                    Text(
                      '\$${quote.priceLow.toStringAsFixed(0)} - \$${quote.priceHigh.toStringAsFixed(0)}',
                      style: const TextStyle(
                        color: InfernalColors.textPrimary,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: InfernalSpacing.xs),
                    Text(
                      '(${quote.estimatedHoursLow}-${quote.estimatedHoursHigh} hours)',
                      style: const TextStyle(
                        color: InfernalColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: InfernalSpacing.md),
                    const Divider(color: InfernalColors.border),
                    const SizedBox(height: InfernalSpacing.md),
                    Text(
                      'Recommended Deposit: \$${quote.recommendedDeposit.toStringAsFixed(0)}',
                      style: const TextStyle(color: InfernalColors.textMuted),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: InfernalSpacing.lg),

              // Factors Grid
              const Text(
                "Complexity Factors",
                style: TextStyle(
                  color: InfernalColors.textSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: InfernalSpacing.sm),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                childAspectRatio: 3,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _Factor('Coverage', quote.coverageLevel),
                  _Factor('Line Work', quote.lineComplexity),
                  _Factor('Shading', quote.shadingComplexity),
                  _Factor('Color', quote.colorComplexity),
                  _Factor('Difficulty', quote.difficulty),
                ],
              ),

              if (quote.notes != null && quote.notes!.isNotEmpty) ...[
                const SizedBox(height: InfernalSpacing.lg),
                const Text(
                  "Notes",
                  style: TextStyle(
                    color: InfernalColors.textSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: InfernalSpacing.sm),
                Container(
                  padding: const EdgeInsets.all(InfernalSpacing.md),
                  color: InfernalColors.surface,
                  width: double.infinity,
                  child: Text(
                    quote.notes!,
                    style: const TextStyle(color: InfernalColors.textPrimary),
                  ),
                ),
              ],
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
    );
  }

  void _deleteQuote(
    BuildContext context,
    WidgetRef ref,
    int id,
    String useInfernal, Map<String, String>? customLabels,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: InfernalColors.surface,
        title: Text(
          UiLabels.get('delete_quote_title', useInfernal, customLabels),
          style: const TextStyle(color: InfernalColors.textPrimary),
        ),
        content: Text(
          UiLabels.get('delete_quote_content', useInfernal, customLabels),
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
              await ref.read(quotesServiceProvider).deleteQuote(id);
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

class _Badge extends StatelessWidget {
  final IconData icon;
  final String label;
  const _Badge({required this.icon, required this.label});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: InfernalColors.textSecondary),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(color: InfernalColors.textPrimary)),
      ],
    );
  }
}

class _Factor extends StatelessWidget {
  final String label;
  final int value;
  const _Factor(this.label, this.value);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(color: InfernalColors.textMuted),
          ),
        ),
        Container(
          width: 30,
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: InfernalColors.surfaceElevated,
            border: Border.all(
              color: value > 3 ? InfernalColors.blood : InfernalColors.border,
            ),
          ),
          child: Text(
            value.toString(),
            style: TextStyle(
              color: value > 3
                  ? InfernalColors.blood
                  : InfernalColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
