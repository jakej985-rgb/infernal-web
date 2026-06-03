// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quotes_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(QuoteSearchQuery)
final quoteSearchQueryProvider = QuoteSearchQueryProvider._();

final class QuoteSearchQueryProvider
    extends $NotifierProvider<QuoteSearchQuery, String> {
  QuoteSearchQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'quoteSearchQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$quoteSearchQueryHash();

  @$internal
  @override
  QuoteSearchQuery create() => QuoteSearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$quoteSearchQueryHash() => r'cf84044b3ca0d268f2732ef5a5d89cad5144541c';

abstract class _$QuoteSearchQuery extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(filteredQuotes)
final filteredQuotesProvider = FilteredQuotesProvider._();

final class FilteredQuotesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<domain.Quote>>,
          List<domain.Quote>,
          Stream<List<domain.Quote>>
        >
    with
        $FutureModifier<List<domain.Quote>>,
        $StreamProvider<List<domain.Quote>> {
  FilteredQuotesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filteredQuotesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filteredQuotesHash();

  @$internal
  @override
  $StreamProviderElement<List<domain.Quote>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<domain.Quote>> create(Ref ref) {
    return filteredQuotes(ref);
  }
}

String _$filteredQuotesHash() => r'924d9af8ae8458b2da4efaf00be0f586923ae9a8';

@ProviderFor(quoteDetail)
final quoteDetailProvider = QuoteDetailFamily._();

final class QuoteDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<domain.Quote?>,
          domain.Quote?,
          Stream<domain.Quote?>
        >
    with $FutureModifier<domain.Quote?>, $StreamProvider<domain.Quote?> {
  QuoteDetailProvider._({
    required QuoteDetailFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'quoteDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$quoteDetailHash();

  @override
  String toString() {
    return r'quoteDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<domain.Quote?> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<domain.Quote?> create(Ref ref) {
    final argument = this.argument as int;
    return quoteDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is QuoteDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$quoteDetailHash() => r'2e203264af5fc7feecb3f1cde30d6d729c0adf63';

final class QuoteDetailFamily extends $Family
    with $FunctionalFamilyOverride<Stream<domain.Quote?>, int> {
  QuoteDetailFamily._()
    : super(
        retry: null,
        name: r'quoteDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  QuoteDetailProvider call(int id) =>
      QuoteDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'quoteDetailProvider';
}

@ProviderFor(quotesService)
final quotesServiceProvider = QuotesServiceProvider._();

final class QuotesServiceProvider
    extends $FunctionalProvider<QuotesService, QuotesService, QuotesService>
    with $Provider<QuotesService> {
  QuotesServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'quotesServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$quotesServiceHash();

  @$internal
  @override
  $ProviderElement<QuotesService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  QuotesService create(Ref ref) {
    return quotesService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(QuotesService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<QuotesService>(value),
    );
  }
}

String _$quotesServiceHash() => r'ce2ca63d4b3f33db543151d5544641d720c1267b';
