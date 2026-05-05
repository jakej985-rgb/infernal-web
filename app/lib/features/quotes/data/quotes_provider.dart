import 'package:drift/drift.dart' show Value;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../shared/domain/quote.dart' as domain;
import '../../../../shared/persistence/database.dart';

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
  final dao = ref.watch(databaseProvider).quotesDao;

  return dao.watchAllQuotes().map((rows) {
     final quotes = rows.map((row) => _mapToDomain(row)).toList();
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
  final dao = ref.watch(databaseProvider).quotesDao;
  return dao.watchQuoteById(id).map((row) => row == null ? null : _mapToDomain(row));
}

@riverpod
QuotesService quotesService(Ref ref) {
  return QuotesService(ref);
}

class QuotesService {
  final Ref _ref;
  QuotesService(this._ref);

  Future<void> createQuote(domain.Quote quote) async {
    final dao = _ref.read(databaseProvider).quotesDao;
    await dao.insertQuote(
       QuotesCompanion(
          clientId: Value(quote.clientId),
          artistId: Value(quote.artistId),
          placement: Value(quote.placement),
          style: Value(quote.style),
          isCoverUp: Value(quote.isCoverUp),
          width: Value(quote.width),
          height: Value(quote.height),
          coverageLevel: Value(quote.coverageLevel),
          lineComplexity: Value(quote.lineComplexity),
          shadingComplexity: Value(quote.shadingComplexity),
          colorComplexity: Value(quote.colorComplexity),
          difficulty: Value(quote.difficulty),
          estimatedHoursLow: Value(quote.estimatedHoursLow),
          estimatedHoursHigh: Value(quote.estimatedHoursHigh),
          priceLow: Value(quote.priceLow),
          priceHigh: Value(quote.priceHigh),
          shopMinimum: Value(quote.shopMinimum),
          recommendedDeposit: Value(quote.recommendedDeposit),
          confidenceScore: Value(quote.confidenceScore),
          similarJobsCount: Value(quote.similarJobsCount),
          notes: Value(quote.notes),
          photoPath: Value(quote.photoPath),
          createdAt: Value(DateTime.now()),
       ),
    );
  }

  Future<void> updateQuote(domain.Quote quote) async {
    final dao = _ref.read(databaseProvider).quotesDao;
    final row = Quote(
          id: quote.id,
          clientId: quote.clientId,
          artistId: quote.artistId,
          placement: quote.placement,
          style: quote.style,
          isCoverUp: quote.isCoverUp,
          width: quote.width,
          height: quote.height,
          coverageLevel: quote.coverageLevel,
          lineComplexity: quote.lineComplexity,
          shadingComplexity: quote.shadingComplexity,
          colorComplexity: quote.colorComplexity,
          difficulty: quote.difficulty,
          estimatedHoursLow: quote.estimatedHoursLow,
          estimatedHoursHigh: quote.estimatedHoursHigh,
          priceLow: quote.priceLow,
          priceHigh: quote.priceHigh,
          shopMinimum: quote.shopMinimum,
          recommendedDeposit: quote.recommendedDeposit,
          confidenceScore: quote.confidenceScore,
          similarJobsCount: quote.similarJobsCount,
          notes: quote.notes,
          photoPath: quote.photoPath,
          createdAt: quote.createdAt, 
    );
    await dao.updateQuote(row);
  }

  Future<void> deleteQuote(int id) async {
    final dao = _ref.read(databaseProvider).quotesDao;
    await dao.deleteQuote(id);
  }
}

domain.Quote _mapToDomain(Quote row) {
  return domain.Quote(
    id: row.id,
    clientId: row.clientId,
    artistId: row.artistId,
    placement: row.placement,
    style: row.style,
    isCoverUp: row.isCoverUp,
    width: row.width,
    height: row.height,
    coverageLevel: row.coverageLevel,
    lineComplexity: row.lineComplexity,
    shadingComplexity: row.shadingComplexity,
    colorComplexity: row.colorComplexity,
    difficulty: row.difficulty,
    estimatedHoursLow: row.estimatedHoursLow,
    estimatedHoursHigh: row.estimatedHoursHigh,
    priceLow: row.priceLow,
    priceHigh: row.priceHigh,
    shopMinimum: row.shopMinimum,
    recommendedDeposit: row.recommendedDeposit,
    confidenceScore: row.confidenceScore,
    similarJobsCount: row.similarJobsCount,
    notes: row.notes,
    photoPath: row.photoPath,
    createdAt: row.createdAt,
  );
}
