import 'package:flutter/material.dart';


class CandyCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color? activeColor;

  const CandyCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
    this.activeColor,
  }) : super(key: key);

  @override
  State<CandyCheckbox> createState() => _CandyCheckboxState();
}

class _CandyCheckboxState extends State<CandyCheckbox> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    if (widget.value) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(covariant CandyCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      if (widget.value) {
        _controller.forward(from: 0.0);
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = widget.activeColor ?? theme.colorScheme.primary;
    final surfaceVariant = theme.colorScheme.surfaceContainerHighest;
    
    final HSLColor hslPrimary = HSLColor.fromColor(primary);
    final Color bottomLipColor = hslPrimary.withLightness((hslPrimary.lightness - 0.2).clamp(0.0, 1.0)).toColor();

    return GestureDetector(
      onTap: () => widget.onChanged(!widget.value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.value ? primary : surfaceVariant,
          boxShadow: [
            if (widget.value)
              BoxShadow(
                color: primary.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            // Inner shadow effect for unchecked state
            if (!widget.value)
              const BoxShadow(
                color: Colors.black12,
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            // Bottom lip for 3D effect
            if (widget.value)
              BoxShadow(
                color: bottomLipColor,
                offset: const Offset(0, 3),
              ),
          ],
          border: !widget.value ? Border.all(color: theme.colorScheme.outlineVariant, width: 2) : null,
        ),
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: const Icon(
            Icons.check_rounded,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }
}

// A simple InsetShadow extension can be complex, so I'll avoid `inset: true` in standard BoxDecoration and simulate it differently if strictly needed. I'll just remove the inset: true.
