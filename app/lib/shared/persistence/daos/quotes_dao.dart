import 'package:drift/drift.dart';

import '../database.dart';
import '../tables/quotes_table.dart';

part 'quotes_dao.g.dart';

/// Data Access Object for Quotes table
@DriftAccessor(tables: [Quotes])
class QuotesDao extends DatabaseAccessor<AppDatabase> with _$QuotesDaoMixin {
  QuotesDao(super.db);

  /// Get all quotes ordered by creation date (newest first)
  Future<List<Quote>> getAllQuotes() {
    return (select(
      quotes,
    )..orderBy([(q) => OrderingTerm.desc(q.createdAt)])).get();
  }

  /// Watch all quotes
  Stream<List<Quote>> watchAllQuotes() {
    return (select(
      quotes,
    )..orderBy([(q) => OrderingTerm.desc(q.createdAt)])).watch();
  }

  /// Get quote by ID
  Future<Quote?> getQuoteById(int id) {
    return (select(quotes)..where((q) => q.id.equals(id))).getSingleOrNull();
  }

  /// Watch quote by ID
  Stream<Quote?> watchQuoteById(int id) {
    return (select(quotes)..where((q) => q.id.equals(id))).watchSingleOrNull();
  }

  /// Get quotes by artist
  Future<List<Quote>> getQuotesByArtist(int artistId) {
    return (select(quotes)
          ..where((q) => q.artistId.equals(artistId))
          ..orderBy([(q) => OrderingTerm.desc(q.createdAt)]))
        .get();
  }

  /// Get quotes by client
  Future<List<Quote>> getQuotesByClient(int clientId) {
    return (select(quotes)
          ..where((q) => q.clientId.equals(clientId))
          ..orderBy([(q) => OrderingTerm.desc(q.createdAt)]))
        .get();
  }

  /// Get recent quotes (last N days)
  Future<List<Quote>> getRecentQuotes({int days = 30}) {
    final cutoff = DateTime.now().subtract(Duration(days: days));
    return (select(quotes)
          ..where((q) => q.createdAt.isBiggerOrEqualValue(cutoff))
          ..orderBy([(q) => OrderingTerm.desc(q.createdAt)]))
        .get();
  }

  /// Insert a new quote
  Future<int> insertQuote(QuotesCompanion quote) {
    return into(quotes).insert(quote);
  }

  /// Update an existing quote
  Future<bool> updateQuote(Quote quote) {
    return update(quotes).replace(quote);
  }

  /// Delete a quote
  Future<int> deleteQuote(int id) {
    return (delete(quotes)..where((q) => q.id.equals(id))).go();
  }

  /// Count open quotes (created but not yet converted to appointment)
  /// For now, we count all quotes from the last 30 days as "open"
  Future<int> countOpenQuotes() async {
    final recent = await getRecentQuotes(days: 30);
    return recent.length;
  }

  /// Find similar quotes for confidence scoring
  Future<List<Quote>> findSimilarQuotes({
    required String placement,
    required String style,
    double? minArea,
    double? maxArea,
    int limit = 10,
  }) {
    var query = select(quotes)
      ..where(
        (q) => q.placement.like('%$placement%') | q.style.like('%$style%'),
      );

    if (minArea != null && maxArea != null) {
      query = query
        ..where(
          (q) =>
              (q.width * q.height).isBiggerOrEqualValue(minArea) &
              (q.width * q.height).isSmallerOrEqualValue(maxArea),
        );
    }

    return (query
          ..orderBy([(q) => OrderingTerm.desc(q.createdAt)])
          ..limit(limit))
        .get();
  }
}
