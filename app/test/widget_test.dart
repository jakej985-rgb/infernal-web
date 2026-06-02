import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infernal_ink_steel/app/app.dart';
import 'package:infernal_ink_steel/features/auth/domain/auth_service.dart';
import 'package:infernal_ink_steel/features/auth/domain/auth_state.dart';
import 'package:infernal_ink_steel/shared/domain/user.dart';
import 'package:infernal_ink_steel/shared/domain/enums.dart';
import 'package:infernal_ink_steel/features/dashboard/data/stats_repository.dart';
import 'package:infernal_ink_steel/features/dashboard/domain/dashboard_stats.dart';
import 'package:infernal_ink_steel/shared/util/shared_prefs_provider.dart';
import 'package:infernal_ink_steel/shared/util/websocket_client.dart';

import 'package:shared_preferences/shared_preferences.dart';

class MockWebSocketClient extends WebSocketClient {
  @override
  Stream<Map<String, dynamic>> build() {
    return const Stream.empty();
  }
}

class MockAuthService extends AuthService {
  @override
  FutureOr<AuthState> build() {
    return AuthState.authenticated(
      User(
        id: 1,
        username: 'admin',
        displayName: 'Admin User',
        role: UserRole.admin,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
  }
}

class MockDashboardStatsRepository extends DashboardStatsRepository {
  @override
  Stream<DashboardStats> build() {
    return Stream.value(
      const DashboardStats(
        todayRituals: 0,
        boundSouls: 0,
        openScrolls: 0,
        pending: 0,
      ),
    );
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
          authServiceProvider.overrideWith(() => MockAuthService()),
          webSocketClientProvider.overrideWith(() => MockWebSocketClient()),
          dashboardStatsRepositoryProvider.overrideWith(
            () => MockDashboardStatsRepository(),
          ),
          dashboardTodayAppointmentsProvider.overrideWith(
            (ref) => const AsyncValue.data([]),
          ),
        ],
        child: const InfernalApp(),
      ),
    );

    // Verify the dashboard loads (has "DASHBOARD" text)
    await tester.pumpAndSettle();
    expect(find.text('DASHBOARD'), findsOneWidget);
  });
}
