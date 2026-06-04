import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../shared/core/services/quote_service.dart' as srv;
import '../../../../shared/domain/quote.dart' as domain;

part 'quotes_provider.g.dart';

@riverpod
class QuoteSearchQuery extends _$QuoteSearchQuery {
  @override
  String build() => '';
  void set(String query) => state = query;
}

@riverpod
Stream<List<domain.Quote>> filteredQuotes(Ref ref) {
  final query = ref.watch(quoteSearchQueryProvider);
  final quoteService = ref.watch(srv.quoteServiceProvider);

  return quoteService.watchQuotes().map((quotes) {
    if (query.isEmpty) return quotes;
    final lowerQ = query.toLowerCase();
    return quotes.where((q) {
      return q.placement.toLowerCase().contains(lowerQ) ||
          q.style.toLowerCase().contains(lowerQ) ||
          (q.notes ?? '').toLowerCase().contains(lowerQ);
    }).toList();
  });
}

@riverpod
Stream<domain.Quote?> quoteDetail(Ref ref, int id) {
  final quoteService = ref.watch(srv.quoteServiceProvider);
  return quoteService.watchQuoteById(id);
}

@riverpod
QuotesService quotesService(Ref ref) {
  return QuotesService(ref);
}

class QuotesService {
  final Ref _ref;
  QuotesService(this._ref);

  srv.QuoteService get _service => _ref.read(srv.quoteServiceProvider);

  Future<void> createQuote(domain.Quote quote) async {
    await _service.createQuote(quote);
  }

  Future<void> updateQuote(domain.Quote quote) async {
    await _service.updateQuote(quote);
  }

  Future<void> deleteQuote(int id) async {
    await _service.deleteQuote(id);
  }
}
