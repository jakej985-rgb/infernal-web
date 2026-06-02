// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DashboardStatsRepository)
final dashboardStatsRepositoryProvider = DashboardStatsRepositoryProvider._();

final class DashboardStatsRepositoryProvider
    extends $StreamNotifierProvider<DashboardStatsRepository, DashboardStats> {
  DashboardStatsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dashboardStatsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dashboardStatsRepositoryHash();

  @$internal
  @override
  DashboardStatsRepository create() => DashboardStatsRepository();
}

String _$dashboardStatsRepositoryHash() =>
    r'b05268a8617b09ff6dfdc8c71bc6b6f88bf062b1';

abstract class _$DashboardStatsRepository
    extends $StreamNotifier<DashboardStats> {
  Stream<DashboardStats> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<DashboardStats>, DashboardStats>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<DashboardStats>, DashboardStats>,
              AsyncValue<DashboardStats>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
