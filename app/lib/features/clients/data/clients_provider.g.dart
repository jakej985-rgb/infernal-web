// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clients_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ClientSearchQuery)
final clientSearchQueryProvider = ClientSearchQueryProvider._();

final class ClientSearchQueryProvider
    extends $NotifierProvider<ClientSearchQuery, String> {
  ClientSearchQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clientSearchQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clientSearchQueryHash();

  @$internal
  @override
  ClientSearchQuery create() => ClientSearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$clientSearchQueryHash() => r'865b9e892bd1bfaed2a8e7afd1e0ca30d9a6dc49';

abstract class _$ClientSearchQuery extends $Notifier<String> {
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

@ProviderFor(filteredClients)
final filteredClientsProvider = FilteredClientsProvider._();

final class FilteredClientsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<domain.Client>>,
          List<domain.Client>,
          Stream<List<domain.Client>>
        >
    with
        $FutureModifier<List<domain.Client>>,
        $StreamProvider<List<domain.Client>> {
  FilteredClientsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filteredClientsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filteredClientsHash();

  @$internal
  @override
  $StreamProviderElement<List<domain.Client>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<domain.Client>> create(Ref ref) {
    return filteredClients(ref);
  }
}

String _$filteredClientsHash() => r'3538a0692514e80e1ded315b1eef9c17feea352b';

@ProviderFor(clientDetail)
final clientDetailProvider = ClientDetailFamily._();

final class ClientDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<domain.Client?>,
          domain.Client?,
          Stream<domain.Client?>
        >
    with $FutureModifier<domain.Client?>, $StreamProvider<domain.Client?> {
  ClientDetailProvider._({
    required ClientDetailFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'clientDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$clientDetailHash();

  @override
  String toString() {
    return r'clientDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<domain.Client?> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<domain.Client?> create(Ref ref) {
    final argument = this.argument as int;
    return clientDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ClientDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$clientDetailHash() => r'56d39c80dd1bbaa08b7758c6738b911cbeed1446';

final class ClientDetailFamily extends $Family
    with $FunctionalFamilyOverride<Stream<domain.Client?>, int> {
  ClientDetailFamily._()
    : super(
        retry: null,
        name: r'clientDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ClientDetailProvider call(int id) =>
      ClientDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'clientDetailProvider';
}

@ProviderFor(clientsService)
final clientsServiceProvider = ClientsServiceProvider._();

final class ClientsServiceProvider
    extends $FunctionalProvider<ClientsService, ClientsService, ClientsService>
    with $Provider<ClientsService> {
  ClientsServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clientsServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clientsServiceHash();

  @$internal
  @override
  $ProviderElement<ClientsService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ClientsService create(Ref ref) {
    return clientsService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ClientsService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ClientsService>(value),
    );
  }
}

String _$clientsServiceHash() => r'6f2125f56d0408e1d47ab05e8adf290cd6fad191';
