import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/quotes_provider.dart';
import '../../../../shared/domain/quote.dart';

final quoteControllerProvider = Provider((ref) {
  return QuoteController(ref);
});

class QuoteController {
  final Ref ref;
  QuoteController(this.ref);

  Future<void> createQuote(Quote quote) async {
    final service = ref.read(quotesServiceProvider);
    await service.createQuote(quote);
  }

  Future<void> updateQuote(Quote quote) async {
    final service = ref.read(quotesServiceProvider);
    await service.updateQuote(quote);
  }

  Future<void> deleteQuote(int id) async {
    final service = ref.read(quotesServiceProvider);
    await service.deleteQuote(id);
  }
}
