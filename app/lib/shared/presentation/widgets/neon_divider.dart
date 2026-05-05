import 'package:flutter/material.dart';
import '../../../app/theme/tokens.dart';

class NeonDivider extends StatelessWidget {
  final Color color;
  final double height;
  final double thickness;
  final double blurRadius;

  const NeonDivider({
    super.key,
    this.color = InfernalColors.blood,
    this.height = InfernalSpacing.lg,
    this.thickness = 1.0,
    this.blurRadius = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // The Glow
          Container(
            height: thickness + (blurRadius * 2),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.5),
                  blurRadius: blurRadius,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
          // The Line
          Divider(
            color: color,
            height: thickness,
            thickness: thickness,
          ),
        ],
      ),
    );
  }
}
