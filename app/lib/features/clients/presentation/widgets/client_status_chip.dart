import 'package:flutter/material.dart';
import '../../../../shared/domain/enums.dart';
import '../../../../app/theme/tokens.dart';

class ClientStatusChip extends StatelessWidget {
  final ClientStatus status;
  const ClientStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final colors = _getColors(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(InfernalRadius.sm),
        border: Border.all(color: colors.border),
      ),
      child: Text(
        _getLabel(status).toUpperCase(),
        style: TextStyle(
          color: colors.text,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  String _getLabel(ClientStatus status) {
    switch (status) {
      case ClientStatus.bound:
        return 'Bound';
      case ClientStatus.freshSoul:
        return 'Fresh Soul';
      case ClientStatus.highValue:
        return 'High Value';
      case ClientStatus.void_:
        return 'Void';
    }
  }

  ({Color background, Color border, Color text}) _getColors(
    ClientStatus status,
  ) {
    switch (status) {
      case ClientStatus.bound:
        return (
          background: InfernalColors.success.withValues(alpha: 0.1),
          border: InfernalColors.success.withValues(alpha: 0.5),
          text: InfernalColors.success,
        );
      case ClientStatus.freshSoul:
        return (
          background: InfernalColors.info.withValues(alpha: 0.1),
          border: InfernalColors.info.withValues(alpha: 0.5),
          text: InfernalColors.info,
        );
      case ClientStatus.highValue:
        return (
          background: InfernalColors.gold.withValues(alpha: 0.1),
          border: InfernalColors.gold.withValues(alpha: 0.5),
          text: InfernalColors.gold,
        );
      case ClientStatus.void_:
        return (
          background: InfernalColors.voidColor.withValues(alpha: 0.2),
          border: InfernalColors.voidColor.withValues(alpha: 0.5),
          text: InfernalColors.textMuted,
        );
    }
  }
}
