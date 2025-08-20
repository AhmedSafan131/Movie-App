import 'package:flutter/material.dart';
import 'app_color.dart';
import 'app_style.dart';

/// Application theme configuration.
class AppTheme {
  const AppTheme._();

  static ThemeData get darkTheme {
    final ThemeData base = ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
    );

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.pageBackground,
      primaryColor: AppColors.accentYellow,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.accentYellow,
        secondary: AppColors.successGreen,
        surface: AppColors.primaryBlack,
        error: AppColors.errorRed,
        onPrimary: AppColors.primaryBlack,
        onSecondary: AppColors.white,
        onSurface: AppColors.white,
        onError: AppColors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.accentYellow,
        foregroundColor: AppColors.primaryBlack,
      ),
      textTheme: const TextTheme(
        displayLarge: AppTextStyles.h1,
        displayMedium: AppTextStyles.h2,
        titleLarge: AppTextStyles.title,
        bodyLarge: AppTextStyles.body,
        bodyMedium: AppTextStyles.body2,
        labelLarge: AppTextStyles.button,
      ),
    );
  }
}
