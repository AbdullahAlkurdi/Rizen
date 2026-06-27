import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_typography.dart';

abstract final class AppTheme {
  static const borderRadius = 16.0;
  static const cardRadius = BorderRadius.all(Radius.circular(borderRadius));

  static ThemeData light({bool isArabic = false}) {
    final textTheme = AppTypography.textTheme(isArabic: isArabic, brightness: Brightness.light);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppLightColors.background,
      colorScheme: const ColorScheme.light(
        primary: AppLightColors.primary,
        onPrimary: AppLightColors.onPrimary,
        secondary: AppLightColors.card,
        onSecondary: AppLightColors.textPrimary,
        surface: AppLightColors.surface,
        onSurface: AppLightColors.textPrimary,
        error: AppLightColors.accent,
        outline: AppLightColors.border,
      ),
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: textTheme.titleLarge,
        iconTheme: const IconThemeData(color: AppLightColors.textPrimary),
      ),
      cardTheme: const CardThemeData(
        color: AppLightColors.card,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: cardRadius),
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppLightColors.glassFill,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: cardRadius,
          borderSide: const BorderSide(color: AppLightColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: cardRadius,
          borderSide: const BorderSide(color: AppLightColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: cardRadius,
          borderSide: const BorderSide(color: AppLightColors.accent, width: 1.5),
        ),
        hintStyle: textTheme.bodyMedium?.copyWith(color: AppLightColors.textMuted),
        labelStyle: textTheme.labelMedium,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppLightColors.primary,
          foregroundColor: AppLightColors.onPrimary,
          elevation: 0,
          minimumSize: const Size(double.infinity, 56),
          shape: const RoundedRectangleBorder(borderRadius: cardRadius),
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppLightColors.textPrimary,
          minimumSize: const Size(double.infinity, 56),
          side: const BorderSide(color: AppLightColors.border),
          shape: const RoundedRectangleBorder(borderRadius: cardRadius),
          textStyle: textTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppLightColors.accent,
          textStyle: textTheme.labelLarge,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppLightColors.border,
        thickness: 1,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppLightColors.surface,
        selectedItemColor: AppLightColors.accent,
        unselectedItemColor: AppLightColors.textMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: textTheme.labelSmall,
        unselectedLabelStyle: textTheme.labelSmall,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppLightColors.accent,
        foregroundColor: AppLightColors.onPrimary,
        elevation: 8,
        shape: CircleBorder(),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppLightColors.card,
        contentTextStyle: textTheme.bodyMedium,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: cardRadius),
      ),
    );
  }

  static ThemeData dark({bool isArabic = false}) {
    final textTheme = AppTypography.textTheme(isArabic: isArabic, brightness: Brightness.dark);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppDarkColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AppDarkColors.accent,
        onPrimary: AppDarkColors.textPrimary,
        secondary: AppDarkColors.card,
        onSecondary: AppDarkColors.textPrimary,
        surface: AppDarkColors.surface,
        onSurface: AppDarkColors.textPrimary,
        error: AppDarkColors.accent,
        outline: AppDarkColors.border,
      ),
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: textTheme.titleLarge,
        iconTheme: const IconThemeData(color: AppDarkColors.textPrimary),
      ),
      cardTheme: const CardThemeData(
        color: AppDarkColors.card,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: cardRadius),
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppDarkColors.glassFill,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: cardRadius,
          borderSide: const BorderSide(color: AppDarkColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: cardRadius,
          borderSide: const BorderSide(color: AppDarkColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: cardRadius,
          borderSide: const BorderSide(color: AppDarkColors.accent, width: 1.5),
        ),
        hintStyle: textTheme.bodyMedium?.copyWith(color: AppDarkColors.textMuted),
        labelStyle: textTheme.labelMedium,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppDarkColors.accent,
          foregroundColor: AppDarkColors.textPrimary,
          elevation: 0,
          minimumSize: const Size(double.infinity, 56),
          shape: const RoundedRectangleBorder(borderRadius: cardRadius),
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppDarkColors.textPrimary,
          minimumSize: const Size(double.infinity, 56),
          side: const BorderSide(color: AppDarkColors.border),
          shape: const RoundedRectangleBorder(borderRadius: cardRadius),
          textStyle: textTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppDarkColors.accent,
          textStyle: textTheme.labelLarge,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppDarkColors.border,
        thickness: 1,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppDarkColors.surface,
        selectedItemColor: AppDarkColors.accent,
        unselectedItemColor: AppDarkColors.textMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: textTheme.labelSmall,
        unselectedLabelStyle: textTheme.labelSmall,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppDarkColors.accent,
        foregroundColor: AppDarkColors.textPrimary,
        elevation: 8,
        shape: CircleBorder(),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppDarkColors.card,
        contentTextStyle: textTheme.bodyMedium,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: cardRadius),
      ),
    );
  }
}
