import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/tokens.dart';
import '../../../app/router.dart';
import '../../../shared/presentation/widgets/neon_plate.dart';

class ToolsHubPage extends StatelessWidget {
  const ToolsHubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: InfernalColors.background,
      appBar: AppBar(
        title: const Text('ARSENAL // Tools'),
        backgroundColor: InfernalColors.surface,
        foregroundColor: InfernalColors.textPrimary,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(InfernalSpacing.lg),
        child: Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: _ToolCard(
                      title: 'Pain Estimator',
                      subtitle: 'Foresee your suffering',
                      icon: Icons.personal_injury,
                      color: InfernalColors.blood,
                      onTap: () => context.go('${AppRoutes.tools}/pain'),
                    ),
                  ),
                  const SizedBox(width: InfernalSpacing.lg),
                  Expanded(
                    child: _ToolCard(
                      title: 'Flash Roulette',
                      subtitle: 'Fate chooses the ink',
                      icon: Icons.casino,
                      color: InfernalColors.gold,
                      onTap: () => context.go('${AppRoutes.tools}/roulette'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: InfernalSpacing.lg),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: _ToolCard(
                      title: 'Supply (Inventory)',
                      subtitle: 'Manage the alchemical stores',
                      icon: Icons.inventory_2_outlined,
                      color: Colors.blue,
                      onTap: () => context.go(AppRoutes.inventory),
                    ),
                  ),
                  const SizedBox(width: InfernalSpacing.lg),
                  Expanded(
                    child: _ToolCard(
                      title: 'Invocations (Messages)',
                      subtitle: 'Spirit communications hub',
                      icon: Icons.chat_bubble_outline,
                      color: Colors.purple,
                      onTap: () => context.go(AppRoutes.communications),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ToolCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ToolCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return NeonPlate(
      color: color,
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 48),
          const SizedBox(height: InfernalSpacing.md),
          Text(
            title,
            style: const TextStyle(
              color: InfernalColors.textPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              color: InfernalColors.textMuted,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
