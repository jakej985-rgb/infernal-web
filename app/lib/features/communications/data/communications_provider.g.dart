// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'communications_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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

String _$communicationsHash() => r'a658116977480228926006027a4c0a8c22d4daf6';

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
    r'7445e885a2018401c8cd3f8e56a8e150c018e956';

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
