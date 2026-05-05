import 'package:flutter/material.dart';
import '../../../../app/theme/tokens.dart';

class AppointmentStatusChip extends StatelessWidget {
  final String statusString;

  const AppointmentStatusChip({super.key, required this.statusString});

  @override
  Widget build(BuildContext context) {
    final colors = _getColors(statusString);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(InfernalRadius.sm),
        border: Border.all(color: colors.border),
      ),
      child: Text(
        statusString.toUpperCase(),
        style: TextStyle(
          color: colors.text,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  ({Color background, Color border, Color text}) _getColors(String status) {
    status = status.toLowerCase();
    if (status.contains('scheduled')) {
      return (
        background: InfernalColors.arcane.withValues(alpha: 0.1),
        border: InfernalColors.arcane,
        text: InfernalColors.arcane
      );
    } else if (status.contains('progress')) {
      return (
        background: InfernalColors.ember.withValues(alpha: 0.1),
        border: InfernalColors.ember,
        text: InfernalColors.ember
      );
    } else if (status.contains('completed')) {
      return (
        background: InfernalColors.success.withValues(alpha: 0.1),
        border: InfernalColors.success,
        text: InfernalColors.success
      );
    } else if (status.contains('cancel')) {
      return (
        background: InfernalColors.error.withValues(alpha: 0.1),
        border: InfernalColors.error,
        text: InfernalColors.error
      );
    } else if (status.contains('show') || status.contains('warning')) {
      return (
        background: InfernalColors.warning.withValues(alpha: 0.1),
        border: InfernalColors.warning,
        text: InfernalColors.warning
      );
    } else {
      return (
        background: InfernalColors.voidColor.withValues(alpha: 0.1),
        border: InfernalColors.voidColor,
        text: InfernalColors.textMuted
      );
    }
  }
}
