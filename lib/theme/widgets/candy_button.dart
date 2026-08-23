import 'package:flutter/material.dart';

import '../constants/app_spacing.dart';

class CandyButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? color;
  final Color? shadowColor;
  final Widget? icon;

  const CandyButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.color,
    this.shadowColor,
    this.icon,
  }) : super(key: key);

  @override
  State<CandyButton> createState() => _CandyButtonState();
}

class _CandyButtonState extends State<CandyButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _depthAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      reverseDuration: const Duration(milliseconds: 150),
    );
    
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutQuad),
    );
    
    _depthAnimation = Tween<double>(begin: 4.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutQuad),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
    _controller.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    _controller.reverse();
    widget.onPressed();
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final baseColor = widget.color ?? Theme.of(context).colorScheme.primary;
    final sColor = widget.shadowColor ?? Theme.of(context).colorScheme.primary.withOpacity(0.4);
    
    // Create a slightly lighter and darker version for the gradient
    final HSLColor hsl = HSLColor.fromColor(baseColor);
    final Color lightColor = hsl.withLightness((hsl.lightness + 0.1).clamp(0.0, 1.0)).toColor();
    final Color darkColor = hsl.withLightness((hsl.lightness - 0.05).clamp(0.0, 1.0)).toColor();
    
    // Deep saturated shadow for bottom lip
    final Color bottomLipColor = hsl.withLightness((hsl.lightness - 0.2).clamp(0.0, 1.0)).withSaturation((hsl.saturation + 0.2).clamp(0.0, 1.0)).toColor();

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              margin: EdgeInsets.only(top: 4.0 - _depthAnimation.value),
              decoration: BoxDecoration(
                borderRadius: AppRadius.circularFull,
                boxShadow: [
                  // Outer Glow
                  if (!_isPressed)
                    BoxShadow(
                      color: sColor,
                      blurRadius: 12,
                      offset: const Offset(0, 8),
                    ),
                  // Bottom Bevel (Lip)
                  BoxShadow(
                    color: bottomLipColor,
                    offset: Offset(0, _depthAnimation.value),
                  ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  borderRadius: AppRadius.circularFull,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [lightColor, darkColor],
                  ),
                  // Specular Highlight on top-left edge
                  border: Border(
                    top: BorderSide(
                      color: Colors.white.withOpacity(0.4),
                      width: 1.5,
                    ),
                    left: BorderSide(
                      color: Colors.white.withOpacity(0.3),
                      width: 1.5,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.icon != null) ...[
                      widget.icon!,
                      const SizedBox(width: AppSpacing.sm),
                    ],
                    Text(
                      widget.text,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
