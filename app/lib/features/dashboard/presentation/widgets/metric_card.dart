import 'package:flutter/material.dart';
import '../../../../app/theme/tokens.dart';
import '../../../../shared/presentation/widgets/neon_plate.dart';

class MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;
  final VoidCallback? onActionTap;
  final IconData? actionIcon;

  const MetricCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    this.onTap,
    this.onActionTap,
    this.actionIcon,
  });

  @override
  Widget build(BuildContext context) {
    return NeonPlate(
      color: color,
      onTap: onTap,
      padding: const EdgeInsets.all(InfernalSpacing.md),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: color, size: InfernalIconSize.lg),
                const SizedBox(height: InfernalSpacing.sm),
                Text(
                  value,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: InfernalColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: InfernalColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          if (onActionTap != null)
            Positioned(
              right: -4,
              bottom: -4,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onActionTap,
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                      border: Border.all(color: color, width: 1.5),
                    ),
                    child: Icon(
                      actionIcon ?? Icons.add,
                      color: color,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
