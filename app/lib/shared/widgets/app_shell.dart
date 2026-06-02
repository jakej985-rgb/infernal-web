/// Application shell with navigation (sidebar/bottom nav)
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/router.dart';
import '../../app/theme/tokens.dart';
import '../data/infernal_labels_provider.dart';

/// Navigation item configuration
class NavItem {
  final String id;
  final IconData icon;
  final IconData selectedIcon;
  final String route;

  const NavItem({
    required this.id,
    required this.icon,
    required this.selectedIcon,
    required this.route,
  });
}

/// Dynamic list of navigation items
const navItems = [
  NavItem(
    id: 'home',
    icon: Icons.dashboard_outlined,
    selectedIcon: Icons.dashboard,
    route: AppRoutes.dashboard,
  ),
  NavItem(
    id: 'calendar',
    icon: Icons.calendar_month_outlined,
    selectedIcon: Icons.calendar_month,
    route: AppRoutes.appointments,
  ),
  NavItem(
    id: 'contacts',
    icon: Icons.people_outline,
    selectedIcon: Icons.people,
    route: AppRoutes.clients,
  ),
  NavItem(
    id: 'quotes',
    icon: Icons.request_quote_outlined,
    selectedIcon: Icons.request_quote,
    route: AppRoutes.quotes,
  ),
  NavItem(
    id: 'settings',
    icon: Icons.settings_outlined,
    selectedIcon: Icons.settings,
    route: AppRoutes.settings,
  ),
  NavItem(
    id: 'stats',
    icon: Icons.analytics_outlined,
    selectedIcon: Icons.analytics,
    route: AppRoutes.stats,
  ),
  NavItem(
    id: 'tools',
    icon: Icons.build_outlined,
    selectedIcon: Icons.build,
    route: AppRoutes.tools,
  ),
];

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

class _NavigationRail extends ConsumerWidget {
  const _NavigationRail({required this.currentPath});

  final String currentPath;

  int _selectedIndex() {
    for (int i = 0; i < navItems.length; i++) {
      final route = navItems[i].route;
      if (currentPath == route || currentPath.startsWith('$route/')) {
        return i;
      }
    }
    // Map inventory and communications to Tools (index 6)
    if (currentPath.startsWith(AppRoutes.inventory) ||
        currentPath.startsWith(AppRoutes.communications)) {
      return 6;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useInfernal = ref.watch(useInfernalLabelsProvider);
    final appTitle = UiLabels.get('app_title', useInfernal);

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: NavigationRail(
                backgroundColor: InfernalColors.surface,
                selectedIndex: _selectedIndex(),
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
                          Icons.colorize,
                          color: InfernalColors.blood,
                          size: InfernalIconSize.lg,
                        ),
                      ),
                      const SizedBox(height: InfernalSpacing.sm),
                      Text(
                        appTitle,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: InfernalColors.textMuted,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                destinations: navItems.map((item) {
                  return NavigationRailDestination(
                    icon: Icon(item.icon),
                    selectedIcon: Icon(item.selectedIcon),
                    label: Text(UiLabels.get(item.id, useInfernal)),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  void _navigate(BuildContext context, int index) {
    context.go(navItems[index].route);
  }
}

class _BottomNavBar extends ConsumerWidget {
  const _BottomNavBar({required this.currentPath});

  final String currentPath;

  int _selectedIndex() {
    for (int i = 0; i < navItems.length; i++) {
      final route = navItems[i].route;
      if (currentPath == route || currentPath.startsWith('$route/')) {
        return i;
      }
    }
    if (currentPath.startsWith(AppRoutes.inventory) ||
        currentPath.startsWith(AppRoutes.communications)) {
      return 6;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useInfernal = ref.watch(useInfernalLabelsProvider);

    return BottomNavigationBar(
      currentIndex: _selectedIndex(),
      onTap: (index) => _navigate(context, index),
      type: BottomNavigationBarType.fixed,
      items: navItems.map((item) {
        return BottomNavigationBarItem(
          icon: Icon(item.icon),
          activeIcon: Icon(item.selectedIcon),
          label: UiLabels.get(item.id, useInfernal),
        );
      }).toList(),
    );
  }

  void _navigate(BuildContext context, int index) {
    context.go(navItems[index].route);
  }
}
