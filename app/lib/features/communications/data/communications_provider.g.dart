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

String _$communicationsHash() => r'69fb1b73d8d7b6b565c42bf5e3e6e9f67c120e8a';

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
    r'4575b4924e2e0af54a64faab4f712abf6417ce84';

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
