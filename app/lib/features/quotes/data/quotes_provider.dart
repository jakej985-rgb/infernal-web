import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../shared/domain/quote.dart' as domain;

part 'quotes_provider.g.dart';

@riverpod
class QuoteSearchQuery extends _$QuoteSearchQuery {
  @override
  String build() => '';
  void set(String query) => state = query;
}

final _quotesList = <domain.Quote>[];
final _quotesStreamController = StreamController<List<domain.Quote>>.broadcast();

@riverpod
Stream<List<domain.Quote>> filteredQuotes(Ref ref) {
  final query = ref.watch(quoteSearchQueryProvider);
  if (!_quotesStreamController.isClosed) {
    _quotesStreamController.add(_quotesList);
  }

  return _quotesStreamController.stream.map((quotes) {
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
  if (!_quotesStreamController.isClosed) {
    _quotesStreamController.add(_quotesList);
  }
  return _quotesStreamController.stream.map((quotes) {
    final match = quotes.where((q) => q.id == id);
    return match.isEmpty ? null : match.first;
  });
}

@riverpod
QuotesService quotesService(Ref ref) {
  return QuotesService();
}

class QuotesService {
  QuotesService();

  Future<void> createQuote(domain.Quote quote) async {
    final newQuote = quote.copyWith(id: _quotesList.length + 1, createdAt: DateTime.now());
    _quotesList.add(newQuote);
    _quotesStreamController.add(_quotesList);
  }

  Future<void> updateQuote(domain.Quote quote) async {
    final idx = _quotesList.indexWhere((q) => q.id == quote.id);
    if (idx != -1) {
      _quotesList[idx] = quote;
      _quotesStreamController.add(_quotesList);
    }
  }

  Future<void> deleteQuote(int id) async {
    _quotesList.removeWhere((q) => q.id == id);
    _quotesStreamController.add(_quotesList);
  }
}
