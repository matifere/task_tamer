import 'package:flutter/material.dart';
import '../constants/app_spacing.dart';

class CandyChip extends StatelessWidget {
  final String label;
  final Color color;

  const CandyChip({
    Key? key,
    required this.label,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HSLColor hsl = HSLColor.fromColor(color);
    final Color lightColor = hsl.withLightness((hsl.lightness + 0.1).clamp(0.0, 1.0)).toColor();
    final Color darkColor = hsl.withLightness((hsl.lightness - 0.05).clamp(0.0, 1.0)).toColor();
    final Color bottomLipColor = hsl.withLightness((hsl.lightness - 0.2).clamp(0.0, 1.0)).withSaturation((hsl.saturation + 0.2).clamp(0.0, 1.0)).toColor();

    return Container(
      decoration: BoxDecoration(
        borderRadius: AppRadius.circularFull,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: bottomLipColor,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          borderRadius: AppRadius.circularFull,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [lightColor, darkColor],
          ),
          border: Border(
            top: BorderSide(
              color: Colors.white.withOpacity(0.4),
              width: 1.0,
            ),
            left: BorderSide(
              color: Colors.white.withOpacity(0.3),
              width: 1.0,
            ),
          ),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
