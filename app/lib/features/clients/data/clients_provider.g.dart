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

@ProviderFor(clientService)
final clientServiceProvider = ClientServiceProvider._();

final class ClientServiceProvider
    extends $FunctionalProvider<ClientService, ClientService, ClientService>
    with $Provider<ClientService> {
  ClientServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clientServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clientServiceHash();

  @$internal
  @override
  $ProviderElement<ClientService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ClientService create(Ref ref) {
    return clientService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ClientService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ClientService>(value),
    );
  }
}

String _$clientServiceHash() => r'a69c6bcc1e4b1a4ec68742b4a0670d5f6e49cc28';

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

String _$filteredClientsHash() => r'f1aaa0bbaf76ff0948291e9bcc4c221d2240a630';

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

String _$clientDetailHash() => r'8d1e0ebc6092317ae239991b44c258a3dd829dfa';

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

@ProviderFor(filteredClientsWithLifecycle)
final filteredClientsWithLifecycleProvider =
    FilteredClientsWithLifecycleProvider._();

final class FilteredClientsWithLifecycleProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ClientLifecycleEntry>>,
          List<ClientLifecycleEntry>,
          Stream<List<ClientLifecycleEntry>>
        >
    with
        $FutureModifier<List<ClientLifecycleEntry>>,
        $StreamProvider<List<ClientLifecycleEntry>> {
  FilteredClientsWithLifecycleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filteredClientsWithLifecycleProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filteredClientsWithLifecycleHash();

  @$internal
  @override
  $StreamProviderElement<List<ClientLifecycleEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<ClientLifecycleEntry>> create(Ref ref) {
    return filteredClientsWithLifecycle(ref);
  }
}

String _$filteredClientsWithLifecycleHash() =>
    r'75c7a29436b2ec89874ba5b902a7842585856433';

@ProviderFor(clientLifecycle)
final clientLifecycleProvider = ClientLifecycleFamily._();

final class ClientLifecycleProvider
    extends
        $FunctionalProvider<
          AsyncValue<ClientLifecycleLabel?>,
          ClientLifecycleLabel?,
          Stream<ClientLifecycleLabel?>
        >
    with
        $FutureModifier<ClientLifecycleLabel?>,
        $StreamProvider<ClientLifecycleLabel?> {
  ClientLifecycleProvider._({
    required ClientLifecycleFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'clientLifecycleProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$clientLifecycleHash();

  @override
  String toString() {
    return r'clientLifecycleProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<ClientLifecycleLabel?> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<ClientLifecycleLabel?> create(Ref ref) {
    final argument = this.argument as int;
    return clientLifecycle(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ClientLifecycleProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$clientLifecycleHash() => r'b645bece7c5e92fc3b4a9297aa9b5c5a52e9f992';

final class ClientLifecycleFamily extends $Family
    with $FunctionalFamilyOverride<Stream<ClientLifecycleLabel?>, int> {
  ClientLifecycleFamily._()
    : super(
        retry: null,
        name: r'clientLifecycleProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ClientLifecycleProvider call(int id) =>
      ClientLifecycleProvider._(argument: id, from: this);

  @override
  String toString() => r'clientLifecycleProvider';
}
