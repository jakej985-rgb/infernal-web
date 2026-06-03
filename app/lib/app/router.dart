/// Application router configuration using go_router
library;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/auth/presentation/login_page.dart';
import '../features/auth/domain/auth_service.dart';
import '../features/auth/domain/auth_state.dart';
import '../features/dashboard/presentation/dashboard_page.dart';
import '../features/appointments/presentation/appointments_list_page.dart';
import '../features/appointments/presentation/appointment_form_page.dart';
import '../features/appointments/presentation/appointment_details_page.dart';
import '../features/clients/presentation/clients_list_page.dart';
import '../features/clients/presentation/client_details_page.dart';
import '../features/clients/presentation/client_form_page.dart';
import '../features/quotes/presentation/quotes_list_page.dart';
import '../features/quotes/presentation/quote_form_page.dart';
import '../features/quotes/presentation/quote_details_page.dart';
import '../features/documents/presentation/documents_list_page.dart';
import '../features/documents/presentation/document_form_page.dart';
import '../features/documents/presentation/document_details_page.dart';
import '../features/settings/presentation/settings_page.dart';
import '../features/admin/presentation/user_list_page.dart';
import '../features/admin/presentation/user_form_page.dart';
import '../features/admin/presentation/system_status_page.dart';
import '../features/reports/presentation/stats_overview_page.dart';
import '../features/tools/presentation/tools_hub_page.dart';
import '../features/tools/presentation/pain_estimator_page.dart';
import '../features/tools/presentation/flash_roulette_page.dart';
import '../features/inventory/presentation/inventory_hub_page.dart';
import '../features/communications/presentation/communications_hub_page.dart';
import '../shared/widgets/app_shell.dart';

/// Route paths as constants
abstract final class AppRoutes {
  static const String login = '/login';
  static const String dashboard = '/home';
  static const String appointments = '/calendar';
  static const String clients = '/contacts';
  static const String quotes = '/quotes';
  static const String documents = '/documents';
  static const String settings = '/settings';
  static const String adminUsers = '/admin/users';
  static const String systemStatus = '/admin/status';
  static const String stats = '/stats';
  static const String tools = '/tools';
  static const String inventory = '/inventory';
  static const String communications = '/communications';
}

/// Global navigation key
final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

/// Router provider for app-wide access
final routerProvider = Provider<GoRouter>((ref) {
  final authStateAsync = ref.watch(authServiceProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.dashboard,
    debugLogDiagnostics: kDebugMode,
    routes: [
      // Redirects for legacy and thematic URLs
      GoRoute(
        path: '/dashboard',
        redirect: (context, state) => AppRoutes.dashboard,
      ),
      GoRoute(
        path: '/appointments',
        redirect: (context, state) {
          final subPath = state.uri.path.substring('/appointments'.length);
          return '${AppRoutes.appointments}$subPath';
        },
      ),
      GoRoute(
        path: '/clients',
        redirect: (context, state) {
          final subPath = state.uri.path.substring('/clients'.length);
          return '${AppRoutes.clients}$subPath';
        },
      ),
      GoRoute(
        path: '/altar',
        redirect: (context, state) => AppRoutes.dashboard,
      ),
      GoRoute(
        path: '/rituals',
        redirect: (context, state) {
          final subPath = state.uri.path.substring('/rituals'.length);
          return '${AppRoutes.appointments}$subPath';
        },
      ),
      GoRoute(
        path: '/souls',
        redirect: (context, state) {
          final subPath = state.uri.path.substring('/souls'.length);
          return '${AppRoutes.clients}$subPath';
        },
      ),

      // Login route (outside shell)
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),

      // Main app shell with navigation
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.dashboard,
            name: 'dashboard',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: DashboardPage()),
          ),
          GoRoute(
            path: AppRoutes.appointments,
            name: 'appointments',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: AppointmentsListPage()),
            routes: [
              GoRoute(
                path: 'new',
                builder: (context, state) => const AppointmentFormPage(),
              ),
              GoRoute(
                path: ':id',
                builder: (context, state) => AppointmentDetailsPage(
                  appointmentId: state.pathParameters['id']!,
                ),
                routes: [
                  GoRoute(
                    path: 'edit',
                    builder: (context, state) => AppointmentFormPage(
                      appointmentId: state.pathParameters['id'],
                    ),
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.clients,
            name: 'clients',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: ClientsListPage()),
            routes: [
              GoRoute(
                path: 'new',
                builder: (context, state) =>
                    const ClientFormPage(clientId: null),
              ),
              GoRoute(
                path: ':id',
                builder: (context, state) =>
                    ClientDetailsPage(clientId: state.pathParameters['id']!),
                routes: [
                  GoRoute(
                    path: 'edit',
                    builder: (context, state) =>
                        ClientFormPage(clientId: state.pathParameters['id']),
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.quotes,
            name: 'quotes',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: QuotesListPage()),
            routes: [
              GoRoute(
                path: 'new',
                builder: (context, state) => const QuoteFormPage(),
              ),
              GoRoute(
                path: ':id',
                builder: (context, state) =>
                    QuoteDetailsPage(quoteId: state.pathParameters['id']!),
                routes: [
                  GoRoute(
                    path: 'edit',
                    builder: (context, state) =>
                        QuoteFormPage(quoteId: state.pathParameters['id']),
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.documents,
            name: 'documents',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: DocumentsListPage()),
            routes: [
              GoRoute(
                path: 'new',
                builder: (context, state) => const DocumentFormPage(),
              ),
              GoRoute(
                path: ':id',
                builder: (context, state) => DocumentDetailsPage(
                  documentId: state.pathParameters['id']!,
                ),
                routes: [
                  GoRoute(
                    path: 'edit',
                    builder: (context, state) => DocumentFormPage(
                      documentId: state.pathParameters['id'],
                    ),
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.settings,
            name: 'settings',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: SettingsPage()),
          ),
          GoRoute(
            path: AppRoutes.adminUsers,
            name: 'adminUsers',
            builder: (context, state) => const UserListPage(),
            routes: [
              GoRoute(
                path: 'new',
                builder: (context, state) => const UserFormPage(),
              ),
              GoRoute(
                path: ':id',
                builder: (context, state) =>
                    UserFormPage(userId: state.pathParameters['id']),
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.systemStatus,
            name: 'systemStatus',
            builder: (context, state) => const SystemStatusPage(),
          ),
          GoRoute(
            path: AppRoutes.stats,
            name: 'stats',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: StatsOverviewPage()),
          ),
          GoRoute(
            path: AppRoutes.tools,
            name: 'tools',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: ToolsHubPage()),
            routes: [
              GoRoute(
                path: 'pain',
                builder: (context, state) => const PainEstimatorPage(),
              ),
              GoRoute(
                path: 'roulette',
                builder: (context, state) => const FlashRoulettePage(),
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.inventory,
            name: 'inventory',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: InventoryHubPage()),
          ),
          GoRoute(
            path: AppRoutes.communications,
            name: 'communications',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: CommunicationsHubPage()),
          ),
        ],
      ),
    ],

    // Redirect logic using authStateAsync
    redirect: (context, state) {
      if (authStateAsync.isLoading) {
        return null;
      }

      final authState = authStateAsync.asData?.value;
      if (authState == null) {
        return null;
      }

      final isLoggedIn = authState.maybeWhen(
        authenticated: (_) => true,
        orElse: () => false,
      );

      final isLoginRoute = state.matchedLocation == AppRoutes.login;

      if (!isLoggedIn && !isLoginRoute) {
        return AppRoutes.login;
      }
      if (isLoggedIn && isLoginRoute) {
        return AppRoutes.dashboard;
      }
      return null;
    },
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Page not found: ${state.uri}'))),
  );
});
