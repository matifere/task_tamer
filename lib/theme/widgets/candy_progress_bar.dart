import 'package:flutter/material.dart';
import '../constants/app_spacing.dart';

class CandyProgressBar extends StatelessWidget {
  final double value; // 0.0 to 1.0
  final Color color;
  final Color? backgroundColor;

  const CandyProgressBar({
    Key? key,
    required this.value,
    required this.color,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bg = backgroundColor ?? theme.colorScheme.surfaceContainerHigh;
    
    final HSLColor hsl = HSLColor.fromColor(color);
    final Color lightColor = hsl.withLightness((hsl.lightness + 0.15).clamp(0.0, 1.0)).toColor();
    final Color darkColor = hsl.withLightness((hsl.lightness - 0.05).clamp(0.0, 1.0)).toColor();

    return Container(
      height: 24,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: AppRadius.circularFull,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
            // Inner shadow representation
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth * value.clamp(0.0, 1.0);
          return Align(
            alignment: Alignment.centerLeft,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutQuart,
              width: width,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: AppRadius.circularFull,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [lightColor, darkColor],
                ),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.5),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Specular Highlight
                  Positioned(
                    top: 2,
                    left: 4,
                    right: 4,
                    height: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: AppRadius.circularFull,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
