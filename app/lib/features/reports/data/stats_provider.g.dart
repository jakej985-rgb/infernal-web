// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(shopOverviewStats)
final shopOverviewStatsProvider = ShopOverviewStatsProvider._();

final class ShopOverviewStatsProvider
    extends
        $FunctionalProvider<
          AsyncValue<ShopOverviewStats>,
          ShopOverviewStats,
          Stream<ShopOverviewStats>
        >
    with
        $FutureModifier<ShopOverviewStats>,
        $StreamProvider<ShopOverviewStats> {
  ShopOverviewStatsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shopOverviewStatsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shopOverviewStatsHash();

  @$internal
  @override
  $StreamProviderElement<ShopOverviewStats> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<ShopOverviewStats> create(Ref ref) {
    return shopOverviewStats(ref);
  }
}

String _$shopOverviewStatsHash() => r'3821c280d2d02cfca7f55704e22b2fed7898a44a';
