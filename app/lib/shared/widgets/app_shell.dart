/// Application shell with navigation (sidebar/bottom nav)
library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/router.dart';
import '../../app/theme/tokens.dart';

/// Main app shell that provides consistent navigation
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width >= 800;

    return Scaffold(
      body: isWide
          ? Row(
              children: [
                _NavigationRail(
                  currentPath: GoRouterState.of(context).matchedLocation,
                ),
                const VerticalDivider(width: 1),
                Expanded(child: child),
              ],
            )
          : child,
      bottomNavigationBar: isWide
          ? null
          : _BottomNavBar(
              currentPath: GoRouterState.of(context).matchedLocation,
            ),
    );
  }
}

class _NavigationRail extends StatelessWidget {
  const _NavigationRail({required this.currentPath});

  final String currentPath;

  int get _selectedIndex {
    switch (currentPath) {
      case AppRoutes.dashboard:
        return 0;
      case AppRoutes.appointments:
        return 1;
      case AppRoutes.clients:
        return 2;
      case AppRoutes.quotes:
        return 3;
      case AppRoutes.settings:
        return 4;
      case AppRoutes.stats:
        return 5;
      case AppRoutes.tools:
      case AppRoutes.inventory:
      case AppRoutes.communications:
        return 6;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: NavigationRail(
                backgroundColor: InfernalColors.surface,
                selectedIndex: _selectedIndex,
                onDestinationSelected: (index) => _navigate(context, index),
                labelType: NavigationRailLabelType.all,
                leading: Padding(
                  padding: const EdgeInsets.symmetric(vertical: InfernalSpacing.lg),
                  child: Column(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: InfernalColors.blood.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(InfernalRadius.md),
                          border: Border.all(color: InfernalColors.blood, width: 2),
                        ),
                        child: const Icon(
                          Icons.local_fire_department,
                          color: InfernalColors.blood,
                          size: InfernalIconSize.lg,
                        ),
                      ),
                      const SizedBox(height: InfernalSpacing.sm),
                      Text(
                        'INFERNAL',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: InfernalColors.textMuted,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.dashboard_outlined),
                    selectedIcon: Icon(Icons.dashboard),
                    label: Text('Altar'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.calendar_month_outlined),
                    selectedIcon: Icon(Icons.calendar_month),
                    label: Text('Rituals'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.people_outline),
                    selectedIcon: Icon(Icons.people),
                    label: Text('Souls'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.request_quote_outlined),
                    selectedIcon: Icon(Icons.request_quote),
                    label: Text('Quotes'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.settings_outlined),
                    selectedIcon: Icon(Icons.settings),
                    label: Text('Config'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.analytics_outlined),
                    selectedIcon: Icon(Icons.analytics),
                    label: Text('Omens'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.build_outlined),
                    selectedIcon: Icon(Icons.build),
                    label: Text('Arsenal'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _navigate(BuildContext context, int index) {
    final routes = [
      AppRoutes.dashboard,
      AppRoutes.appointments,
      AppRoutes.clients,
      AppRoutes.quotes,
      AppRoutes.settings,
      AppRoutes.stats,
      AppRoutes.tools,
    ];
    context.go(routes[index]);
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar({required this.currentPath});

  final String currentPath;

  int get _selectedIndex {
    switch (currentPath) {
      case AppRoutes.dashboard:
        return 0;
      case AppRoutes.appointments:
        return 1;
      case AppRoutes.clients:
        return 2;
      case AppRoutes.quotes:
        return 3;
      case AppRoutes.settings:
        return 4;
      case AppRoutes.stats:
        return 5;
      case AppRoutes.tools:
      case AppRoutes.inventory:
      case AppRoutes.communications:
        return 6;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) => _navigate(context, index),
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard_outlined),
          activeIcon: Icon(Icons.dashboard),
          label: 'Altar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month_outlined),
          activeIcon: Icon(Icons.calendar_month),
          label: 'Rituals',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people_outline),
          activeIcon: Icon(Icons.people),
          label: 'Souls',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.request_quote_outlined),
          activeIcon: Icon(Icons.request_quote),
          label: 'Quotes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_outlined),
          activeIcon: Icon(Icons.settings),
          label: 'Config',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.analytics_outlined),
          activeIcon: Icon(Icons.analytics),
          label: 'Omens',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.build_outlined),
          activeIcon: Icon(Icons.build),
          label: 'Arsenal',
        ),
      ],
    );
  }

  void _navigate(BuildContext context, int index) {
    final routes = [
      AppRoutes.dashboard,
      AppRoutes.appointments,
      AppRoutes.clients,
      AppRoutes.quotes,
      AppRoutes.settings,
      AppRoutes.stats,
      AppRoutes.tools,
    ];
    context.go(routes[index]);
  }
}
