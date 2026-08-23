import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  static TextTheme getTextTheme() {
    return TextTheme(
      displayLarge: GoogleFonts.quicksand(
        fontSize: 48,
        fontWeight: FontWeight.w700,
        height: 1.1,
        letterSpacing: -0.03 * 48,
        color: AppColors.onSurface,
      ),
      displayMedium: GoogleFonts.quicksand(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 1.2,
        color: AppColors.onSurface,
      ),
      displaySmall: GoogleFonts.quicksand(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        height: 1.2,
        color: AppColors.onSurface,
      ),
      headlineMedium: GoogleFonts.quicksand(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 1.3,
        color: AppColors.onSurface,
      ),
      bodyLarge: GoogleFonts.nunitoSans(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.5,
        color: AppColors.onSurface,
      ),
      bodyMedium: GoogleFonts.nunitoSans(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.5,
        color: AppColors.onSurface,
      ),
      labelLarge: GoogleFonts.quicksand(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        height: 1.0,
        color: AppColors.onSurface,
      ),
      labelMedium: GoogleFonts.quicksand(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        height: 1.0,
        color: AppColors.onSurface,
      ),
      labelSmall: GoogleFonts.quicksand(
        fontSize: 12,
        fontWeight: FontWeight.w800,
        height: 1.0,
        letterSpacing: 0.02 * 12,
        color: AppColors.onSurface,
      ),
    );
  }
}
