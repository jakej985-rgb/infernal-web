import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infernal_ink_steel/app/app.dart';
import 'package:infernal_ink_steel/features/dashboard/data/stats_repository.dart';
import 'package:infernal_ink_steel/features/dashboard/domain/dashboard_stats.dart';
import 'package:infernal_ink_steel/shared/util/shared_prefs_provider.dart';


import 'package:shared_preferences/shared_preferences.dart';

class MockDashboardStatsRepository extends DashboardStatsRepository {
  @override
  Stream<DashboardStats> build() {
    return Stream.value(const DashboardStats(
      todayRituals: 0,
      boundSouls: 0,
      openScrolls: 0,
      pending: 0,
    ));
  }
}




void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    tester.view.physicalSize = const Size(1080, 1920);
    tester.view.devicePixelRatio = 1.0;

    // Build the app and trigger a frame.
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          dashboardStatsRepositoryProvider.overrideWith(() => MockDashboardStatsRepository()),
          dashboardTodayAppointmentsProvider.overrideWith((ref) => Stream.value([])),
        ],
        child: const InfernalApp(),
      ),
    );

    // Verify the dashboard loads (has "THE ALTAR" text)
    await tester.pumpAndSettle();
    expect(find.text('THE ALTAR'), findsOneWidget);
  });
}
