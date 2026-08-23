import 'package:flutter/material.dart';
import '../constants/app_spacing.dart';


class PolkaDotPainter extends CustomPainter {
  final Color color;
  final double spacing;
  final double radius;

  PolkaDotPainter({
    required this.color,
    this.spacing = 16.0,
    this.radius = 2.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    for (double i = 0; i < size.width; i += spacing) {
      for (double j = 0; j < size.height; j += spacing) {
        canvas.drawCircle(Offset(i, j), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant PolkaDotPainter oldDelegate) {
    return color != oldDelegate.color ||
        spacing != oldDelegate.spacing ||
        radius != oldDelegate.radius;
  }
}

class CandyCard extends StatelessWidget {
  final Widget child;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const CandyCard({
    Key? key,
    required this.child,
    this.color,
    this.padding,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardColor = color ?? theme.colorScheme.surfaceContainerLowest;
    final dotColor = theme.colorScheme.primary.withOpacity(0.05);

    return Container(
      margin: margin ?? const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: AppRadius.circularXl,
        boxShadow: AppShadows.candyShadow(theme.colorScheme.onSurface.withOpacity(0.05)),
      ),
      child: ClipRRect(
        borderRadius: AppRadius.circularXl,
        child: Stack(
          children: [
            // Polka dot pattern
            Positioned.fill(
              child: CustomPaint(
                painter: PolkaDotPainter(color: dotColor),
              ),
            ),
            // Content
            Padding(
              padding: padding ?? const EdgeInsets.all(AppSpacing.md),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
