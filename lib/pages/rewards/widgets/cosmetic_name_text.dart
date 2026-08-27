import 'package:flutter/material.dart';

class CosmeticNameText extends StatelessWidget {
  final String text;
  final String styleId;
  final TextStyle? baseStyle;

  const CosmeticNameText({
    super.key,
    required this.text,
    required this.styleId,
    this.baseStyle,
  });

  @override
  Widget build(BuildContext context) {
    final style = baseStyle ?? const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    switch (styleId) {
      case 'gold':
        return ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: isDark 
                ? [const Color(0xFFFFDF00), const Color(0xFFD4AF37), const Color(0xFFFFDF00)]
                : [Colors.orange.shade400, Colors.amber.shade800, Colors.orange.shade600], // Más oscuro para contrastar
            stops: const [0.0, 0.5, 1.0],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: Text(
            text,
            style: style.copyWith(
              color: Colors.white, 
              fontWeight: FontWeight.w900,
              shadows: isDark ? [] : [
                Shadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 2, offset: const Offset(1, 1))
              ],
            ),
          ),
        );

      case 'neon':
        final neonColor = isDark ? Colors.cyanAccent : Colors.deepPurpleAccent;
        return Text(
          text,
          style: style.copyWith(
            color: isDark ? Colors.white : neonColor.shade700,
            fontWeight: FontWeight.w900,
            shadows: [
              Shadow(color: neonColor, blurRadius: isDark ? 10 : 4),
              Shadow(color: neonColor, blurRadius: isDark ? 20 : 8),
              if (!isDark) Shadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 2, offset: const Offset(1, 1)),
            ],
          ),
        );

      case 'fire':
        return ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              isDark ? Colors.yellow : Colors.orange.shade400, 
              Colors.orange.shade700, 
              Colors.red.shade900
            ],
            stops: const [0.0, 0.5, 1.0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ).createShader(bounds),
          child: Text(
            text,
            style: style.copyWith(
              color: Colors.white, 
              fontWeight: FontWeight.w900,
              shadows: isDark ? [] : [
                Shadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 2, offset: const Offset(1, 1))
              ],
            ),
          ),
        );

      case 'hacker':
        return Text(
          text,
          style: style.copyWith(
            color: isDark ? Colors.greenAccent.shade400 : Colors.green.shade800,
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
          ),
        );

      case 'ocean':
        return ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: isDark 
                ? [Colors.blue.shade300, Colors.teal.shade300, Colors.blue.shade300]
                : [Colors.blue.shade700, Colors.teal.shade700, Colors.blue.shade800],
            stops: const [0.0, 0.5, 1.0],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: Text(
            text,
            style: style.copyWith(
              color: Colors.white, 
              fontWeight: FontWeight.w900,
              shadows: isDark ? [] : [Shadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 2, offset: const Offset(1, 1))],
            ),
          ),
        );

      case 'rainbow':
        return ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.red, Colors.orange, Colors.yellow, Colors.green, Colors.blue, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: Text(
            text,
            style: style.copyWith(
              color: Colors.white, 
              fontWeight: FontWeight.w900,
              shadows: isDark ? [] : [Shadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 2, offset: const Offset(1, 1))],
            ),
          ),
        );

      case 'glitch':
        return Text(
          text,
          style: style.copyWith(
            color: isDark ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w900,
            shadows: [
              const Shadow(color: Colors.redAccent, offset: Offset(-1.5, 0)),
              const Shadow(color: Colors.cyanAccent, offset: Offset(1.5, 0)),
            ],
          ),
        );

      case 'bubblegum':
        return ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: isDark 
                ? [Colors.pinkAccent, Colors.lightBlueAccent]
                : [Colors.pink.shade600, Colors.blue.shade600],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ).createShader(bounds),
          child: Text(
            text,
            style: style.copyWith(
              color: Colors.white, 
              fontWeight: FontWeight.w900,
              shadows: isDark ? [] : [Shadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 2, offset: const Offset(1, 1))],
            ),
          ),
        );

      case 'ice':
        return ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: isDark 
                ? [Colors.white, Colors.lightBlue.shade100, Colors.lightBlueAccent]
                : [Colors.lightBlue.shade300, Colors.blue.shade700, Colors.indigo.shade900],
            stops: const [0.0, 0.4, 1.0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ).createShader(bounds),
          child: Text(
            text,
            style: style.copyWith(
              color: Colors.white, 
              fontWeight: FontWeight.w900,
              shadows: isDark 
                  ? [const Shadow(color: Colors.lightBlueAccent, blurRadius: 8)] 
                  : [Shadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 2, offset: const Offset(1, 1))],
            ),
          ),
        );

      default:
        return Text(text, style: style);
    }
  }
}