import 'package:flutter/material.dart';
import '../../../../shared/domain/client_lifecycle.dart';
import '../../../../app/theme/tokens.dart';

class ClientStatusChip extends StatelessWidget {
  final ClientLifecycleLabel lifecycle;
  const ClientStatusChip({super.key, required this.lifecycle});

  @override
  Widget build(BuildContext context) {
    final colors = _getColors(lifecycle);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(InfernalRadius.sm),
        border: Border.all(color: colors.border),
      ),
      child: Text(
        lifecycle.displayName.toUpperCase(),
        style: TextStyle(
          color: colors.text,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  ({Color background, Color border, Color text}) _getColors(
    ClientLifecycleLabel lifecycle,
  ) {
    switch (lifecycle) {
      case ClientLifecycleLabel.active:
        return (
          background: InfernalColors.success.withValues(alpha: 0.1),
          border: InfernalColors.success.withValues(alpha: 0.5),
          text: InfernalColors.success,
        );
      case ClientLifecycleLabel.newClient:
        return (
          background: InfernalColors.info.withValues(alpha: 0.1),
          border: InfernalColors.info.withValues(alpha: 0.5),
          text: InfernalColors.info,
        );
      case ClientLifecycleLabel.inactive:
        return (
          background: InfernalColors.voidColor.withValues(alpha: 0.2),
          border: InfernalColors.voidColor.withValues(alpha: 0.5),
          text: InfernalColors.textMuted,
        );
    }
  }
}
