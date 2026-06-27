import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

abstract final class AppTypography {
  static TextTheme textTheme({required bool isArabic, Brightness? brightness}) {
    final base = isArabic
        ? GoogleFonts.cairoTextTheme()
        : GoogleFonts.interTextTheme();

    final isLight = brightness == Brightness.light;

    return base.copyWith(
      displayLarge: base.displayLarge?.copyWith(
        color: isLight ? AppLightColors.textPrimary : AppDarkColors.textPrimary,
        fontWeight: FontWeight.w700,
        letterSpacing: -1.2,
      ),
      displayMedium: base.displayMedium?.copyWith(
        color: isLight ? AppLightColors.textPrimary : AppDarkColors.textPrimary,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.8,
      ),
      headlineLarge: base.headlineLarge?.copyWith(
        color: isLight ? AppLightColors.textPrimary : AppDarkColors.textPrimary,
        fontWeight: FontWeight.w700,
      ),
      headlineMedium: base.headlineMedium?.copyWith(
        color: isLight ? AppLightColors.textPrimary : AppDarkColors.textPrimary,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: base.headlineSmall?.copyWith(
        color: isLight ? AppLightColors.textPrimary : AppDarkColors.textPrimary,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: base.titleLarge?.copyWith(
        color: isLight ? AppLightColors.textPrimary : AppDarkColors.textPrimary,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: base.titleMedium?.copyWith(
        color: isLight ? AppLightColors.textPrimary : AppDarkColors.textPrimary,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: base.titleSmall?.copyWith(
        color: isLight ? AppLightColors.textSecondary : AppDarkColors.textSecondary,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: base.bodyLarge?.copyWith(
        color: isLight ? AppLightColors.textPrimary : AppDarkColors.textPrimary,
        height: 1.5,
      ),
      bodyMedium: base.bodyMedium?.copyWith(
        color: isLight ? AppLightColors.textSecondary : AppDarkColors.textSecondary,
        height: 1.45,
      ),
      bodySmall: base.bodySmall?.copyWith(
        color: isLight ? AppLightColors.textMuted : AppDarkColors.textMuted,
        height: 1.4,
      ),
      labelLarge: base.labelLarge?.copyWith(
        color: isLight ? AppLightColors.textPrimary : AppDarkColors.textPrimary,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      ),
      labelMedium: base.labelMedium?.copyWith(
        color: isLight ? AppLightColors.textSecondary : AppDarkColors.textSecondary,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: base.labelSmall?.copyWith(
        color: isLight ? AppLightColors.textMuted : AppDarkColors.textMuted,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.4,
      ),
    );
  }
}
