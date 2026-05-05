// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'communications_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(communicationsDao)
final communicationsDaoProvider = CommunicationsDaoProvider._();

final class CommunicationsDaoProvider
    extends
        $FunctionalProvider<
          CommunicationsDao,
          CommunicationsDao,
          CommunicationsDao
        >
    with $Provider<CommunicationsDao> {
  CommunicationsDaoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'communicationsDaoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$communicationsDaoHash();

  @$internal
  @override
  $ProviderElement<CommunicationsDao> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CommunicationsDao create(Ref ref) {
    return communicationsDao(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CommunicationsDao value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CommunicationsDao>(value),
    );
  }
}

String _$communicationsDaoHash() => r'2d20fa55095e0d3783f961b7785602b4a832a71b';

@ProviderFor(communications)
final communicationsProvider = CommunicationsProvider._();

final class CommunicationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CommunicationRitual>>,
          List<CommunicationRitual>,
          Stream<List<CommunicationRitual>>
        >
    with
        $FutureModifier<List<CommunicationRitual>>,
        $StreamProvider<List<CommunicationRitual>> {
  CommunicationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'communicationsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$communicationsHash();

  @$internal
  @override
  $StreamProviderElement<List<CommunicationRitual>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<CommunicationRitual>> create(Ref ref) {
    return communications(ref);
  }
}

String _$communicationsHash() => r'77f2e7d2e5f96ea8ae200acb110ab371348a3fce';

@ProviderFor(CommunicationsService)
final communicationsServiceProvider = CommunicationsServiceProvider._();

final class CommunicationsServiceProvider
    extends $AsyncNotifierProvider<CommunicationsService, void> {
  CommunicationsServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'communicationsServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$communicationsServiceHash();

  @$internal
  @override
  CommunicationsService create() => CommunicationsService();
}

String _$communicationsServiceHash() =>
    r'0edf918abc089cfd769d4d5ea24113e29fc2ebbb';

abstract class _$CommunicationsService extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
