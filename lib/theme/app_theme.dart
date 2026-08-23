import 'package:flutter/material.dart';
import 'constants/app_colors.dart';
import 'constants/app_typography.dart';
import 'constants/app_spacing.dart';

class AppTheme {
  static ThemeData get lightTheme {
    final colorScheme = AppColors.colorScheme;
    final textTheme = AppTypography.getTextTheme();

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: colorScheme.surface,
      extensions: const [
        CandyColors.light,
      ],
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: textTheme.displaySmall,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadius.circularFull,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          textStyle: textTheme.labelLarge,
          elevation: 0, // Shadows handled manually in custom widgets
        ),
      ),
      cardTheme: CardThemeData(
        color: colorScheme.surfaceContainerLowest,
        shape: const RoundedRectangleBorder(
          borderRadius: AppRadius.circularXl,
        ),
        elevation: 0,
        margin: const EdgeInsets.all(AppSpacing.md),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: const CircleBorder(),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return colorScheme.surfaceContainerHighest;
        }),
        checkColor: WidgetStateProperty.all(colorScheme.onPrimary),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerLow,
        border: const OutlineInputBorder(
          borderRadius: AppRadius.circularFull,
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
      ),
    );
  }
}
