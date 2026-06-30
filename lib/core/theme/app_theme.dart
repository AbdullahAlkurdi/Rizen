import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_typography.dart';

abstract final class AppTheme {
  static const borderRadius = 16.0;
  static const cardRadius = BorderRadius.all(Radius.circular(borderRadius));

  static ThemeData light({bool isArabic = false}) {
    final textTheme = AppTypography.textTheme(isArabic: isArabic, brightness: Brightness.dark);
    return _buildDarkTheme(textTheme);
  }

  static ThemeData dark({bool isArabic = false}) {
    final textTheme = AppTypography.textTheme(isArabic: isArabic, brightness: Brightness.dark);
    return _buildDarkTheme(textTheme);
  }

  static ThemeData _buildDarkTheme(TextTheme textTheme) {
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

  static const cupertinoDarkTheme = CupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryBackground,
    scaffoldBackgroundColor: AppColors.primaryBackground,
    barBackgroundColor: AppColors.secondaryBackground,
    textTheme: CupertinoTextThemeData(
      primaryColor: AppColors.textPrimary,
    ),
  );
}

class PlatformAwareTheme extends StatelessWidget {
  final Widget child;
  const PlatformAwareTheme({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;
    final isApple = platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;

    if (isApple) {
      return CupertinoTheme(
        data: AppTheme.cupertinoDarkTheme,
        child: child,
      );
    }

    return Theme(
      data: AppTheme.dark(),
      child: child,
    );
  }
}
