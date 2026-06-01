// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'id_mapper.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(idMapper)
final idMapperProvider = IdMapperProvider._();

final class IdMapperProvider
    extends $FunctionalProvider<IdMapper, IdMapper, IdMapper>
    with $Provider<IdMapper> {
  IdMapperProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'idMapperProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$idMapperHash();

  @$internal
  @override
  $ProviderElement<IdMapper> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  IdMapper create(Ref ref) {
    return idMapper(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IdMapper value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IdMapper>(value),
    );
  }
}

String _$idMapperHash() => r'b8926554d0f30a9c2472033a72b9e3b629ad7861';
