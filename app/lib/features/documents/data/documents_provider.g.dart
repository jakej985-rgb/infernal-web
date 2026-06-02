// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'documents_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DocumentSearchQuery)
final documentSearchQueryProvider = DocumentSearchQueryProvider._();

final class DocumentSearchQueryProvider
    extends $NotifierProvider<DocumentSearchQuery, String> {
  DocumentSearchQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'documentSearchQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$documentSearchQueryHash();

  @$internal
  @override
  DocumentSearchQuery create() => DocumentSearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$documentSearchQueryHash() =>
    r'ec3717821e69bfc2db1905bc9b1fd1adaa59a851';

abstract class _$DocumentSearchQuery extends $Notifier<String> {
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

@ProviderFor(filteredDocuments)
final filteredDocumentsProvider = FilteredDocumentsProvider._();

final class FilteredDocumentsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<domain.Document>>,
          List<domain.Document>,
          Stream<List<domain.Document>>
        >
    with
        $FutureModifier<List<domain.Document>>,
        $StreamProvider<List<domain.Document>> {
  FilteredDocumentsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filteredDocumentsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filteredDocumentsHash();

  @$internal
  @override
  $StreamProviderElement<List<domain.Document>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<domain.Document>> create(Ref ref) {
    return filteredDocuments(ref);
  }
}

String _$filteredDocumentsHash() => r'0ad334ecc6567836d0d9a930604cbbb298f01917';

@ProviderFor(documentDetail)
final documentDetailProvider = DocumentDetailFamily._();

final class DocumentDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<domain.Document?>,
          domain.Document?,
          Stream<domain.Document?>
        >
    with $FutureModifier<domain.Document?>, $StreamProvider<domain.Document?> {
  DocumentDetailProvider._({
    required DocumentDetailFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'documentDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$documentDetailHash();

  @override
  String toString() {
    return r'documentDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<domain.Document?> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<domain.Document?> create(Ref ref) {
    final argument = this.argument as int;
    return documentDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is DocumentDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$documentDetailHash() => r'0ed217eec1116e44e138082bd196289d03431e11';

final class DocumentDetailFamily extends $Family
    with $FunctionalFamilyOverride<Stream<domain.Document?>, int> {
  DocumentDetailFamily._()
    : super(
        retry: null,
        name: r'documentDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  DocumentDetailProvider call(int id) =>
      DocumentDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'documentDetailProvider';
}

@ProviderFor(documentsService)
final documentsServiceProvider = DocumentsServiceProvider._();

final class DocumentsServiceProvider
    extends
        $FunctionalProvider<
          DocumentsService,
          DocumentsService,
          DocumentsService
        >
    with $Provider<DocumentsService> {
  DocumentsServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'documentsServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$documentsServiceHash();

  @$internal
  @override
  $ProviderElement<DocumentsService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DocumentsService create(Ref ref) {
    return documentsService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DocumentsService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DocumentsService>(value),
    );
  }
}

String _$documentsServiceHash() => r'571aba6ba755957974fef80e0cc7b870d94a4adf';
