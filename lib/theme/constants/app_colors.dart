import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFFAC2471);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFFFF69B4);
  static const Color onPrimaryContainer = Color(0xFF6E0044);
  static const Color secondary = Color(0xFF006875);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFF00E3FD);
  static const Color onSecondaryContainer = Color(0xFF00616D);
  static const Color tertiary = Color(0xFF705D00);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFFBB9D00);
  static const Color onTertiaryContainer = Color(0xFF413500);
  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF93000A);
  static const Color background = Color(0xFFF6FAFE);
  static const Color onBackground = Color(0xFF171C1F);
  static const Color surface = Color(0xFFF6FAFE);
  static const Color onSurface = Color(0xFF171C1F);
  static const Color surfaceVariant = Color(0xFFDFE3E7);
  static const Color onSurfaceVariant = Color(0xFF564149);
  static const Color outline = Color(0xFF897179);
  static const Color outlineVariant = Color(0xFFDCBFC9);
  
  static const Color candyPink = Color(0xFFFF69B4);
  static const Color sunnyYellow = Color(0xFFFFD700);
  static const Color vibrantTurquoise = Color(0xFF00E5FF);
  static const Color limeGreen = Color(0xFF32CD32);
  static const Color bubbleShadow = Color(0xFF2D3E50);
  
  static const Color surfaceDim = Color(0xFFD6DADE);
  static const Color surfaceBright = Color(0xFFF6FAFE);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF0F4F8);
  static const Color surfaceContainer = Color(0xFFEAEEF2);
  static const Color surfaceContainerHigh = Color(0xFFE4E9ED);
  static const Color surfaceContainerHighest = Color(0xFFDFE3E7);

  static const Color inverseSurface = Color(0xFF2C3134);
  static const Color inverseOnSurface = Color(0xFFEDF1F5);
  static const Color inversePrimary = Color(0xFFFFB0D0);
  static const Color surfaceTint = Color(0xFFAC2471);

  static ColorScheme get colorScheme => const ColorScheme(
        brightness: Brightness.light,
        primary: primary,
        onPrimary: onPrimary,
        primaryContainer: primaryContainer,
        onPrimaryContainer: onPrimaryContainer,
        secondary: secondary,
        onSecondary: onSecondary,
        secondaryContainer: secondaryContainer,
        onSecondaryContainer: onSecondaryContainer,
        tertiary: tertiary,
        onTertiary: onTertiary,
        tertiaryContainer: tertiaryContainer,
        onTertiaryContainer: onTertiaryContainer,
        error: error,
        onError: onError,
        errorContainer: errorContainer,
        onErrorContainer: onErrorContainer,
        surface: surface,
        onSurface: onSurface,
        surfaceContainerHighest: surfaceVariant,
        onSurfaceVariant: onSurfaceVariant,
        outline: outline,
        outlineVariant: outlineVariant,
        inverseSurface: inverseSurface,
        onInverseSurface: inverseOnSurface,
        inversePrimary: inversePrimary,
        surfaceTint: surfaceTint,
      );
}

class CandyColors extends ThemeExtension<CandyColors> {
  final Color candyPink;
  final Color sunnyYellow;
  final Color vibrantTurquoise;
  final Color limeGreen;
  final Color bubbleShadow;

  const CandyColors({
    required this.candyPink,
    required this.sunnyYellow,
    required this.vibrantTurquoise,
    required this.limeGreen,
    required this.bubbleShadow,
  });

  @override
  CandyColors copyWith({
    Color? candyPink,
    Color? sunnyYellow,
    Color? vibrantTurquoise,
    Color? limeGreen,
    Color? bubbleShadow,
  }) {
    return CandyColors(
      candyPink: candyPink ?? this.candyPink,
      sunnyYellow: sunnyYellow ?? this.sunnyYellow,
      vibrantTurquoise: vibrantTurquoise ?? this.vibrantTurquoise,
      limeGreen: limeGreen ?? this.limeGreen,
      bubbleShadow: bubbleShadow ?? this.bubbleShadow,
    );
  }

  @override
  CandyColors lerp(ThemeExtension<CandyColors>? other, double t) {
    if (other is! CandyColors) return this;
    return CandyColors(
      candyPink: Color.lerp(candyPink, other.candyPink, t) ?? candyPink,
      sunnyYellow: Color.lerp(sunnyYellow, other.sunnyYellow, t) ?? sunnyYellow,
      vibrantTurquoise: Color.lerp(vibrantTurquoise, other.vibrantTurquoise, t) ?? vibrantTurquoise,
      limeGreen: Color.lerp(limeGreen, other.limeGreen, t) ?? limeGreen,
      bubbleShadow: Color.lerp(bubbleShadow, other.bubbleShadow, t) ?? bubbleShadow,
    );
  }

  static const light = CandyColors(
    candyPink: AppColors.candyPink,
    sunnyYellow: AppColors.sunnyYellow,
    vibrantTurquoise: AppColors.vibrantTurquoise,
    limeGreen: AppColors.limeGreen,
    bubbleShadow: AppColors.bubbleShadow,
  );
}
