import 'package:flutter/material.dart';

class AppSpacing {
  static const double base = 8.0;
  static const double xs = 4.0;
  static const double sm = 12.0;
  static const double md = 24.0;
  static const double lg = 48.0;
  static const double xl = 80.0;
  
  static const double gutter = 20.0;
  static const double marginMobile = 20.0;
}

class AppRadius {
  static const double sm = 8.0;
  static const double base = 16.0;
  static const double md = 24.0;
  static const double lg = 32.0;
  static const double xl = 48.0;
  static const double full = 9999.0;
  
  static const BorderRadius circularSm = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius circularBase = BorderRadius.all(Radius.circular(base));
  static const BorderRadius circularMd = BorderRadius.all(Radius.circular(md));
  static const BorderRadius circularLg = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius circularXl = BorderRadius.all(Radius.circular(xl));
  static const BorderRadius circularFull = BorderRadius.all(Radius.circular(full));
}

class AppShadows {
  static List<BoxShadow> candyShadow(Color componentColor) {
    return [
      // Outer Glow/Shadow
      BoxShadow(
        color: componentColor.withOpacity(0.2),
        blurRadius: 12,
        offset: const Offset(0, 8),
      ),
    ];
  }
}
