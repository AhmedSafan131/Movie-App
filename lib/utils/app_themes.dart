import 'package:flutter/material.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_styles.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.white,
    iconTheme: IconThemeData(color: AppColors.yellowColor),

    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      iconTheme: IconThemeData(color: AppColors.primaryBlack),
      centerTitle: true,
    ), // AppBarTheme
    textTheme: TextTheme(
      labelLarge: AppStyles.bold16Black,
      labelMedium: AppStyles.medium14Black,
      headlineMedium: AppStyles.medium24Black,
      headlineLarge: AppStyles.medium20Black,
      bodyMedium: AppStyles.medium14White,
    ),
    tabBarTheme: TabBarTheme(indicatorColor: AppColors.primaryBlack) 
    // TabBarThemeData(indicatorColor: AppColors.primaryBlack),
  ); // TextTheme, ThemeData

  static final ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primaryBlack,
    scaffoldBackgroundColor: AppColors.primaryBlack,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColors.primaryBlack,
      iconTheme: IconThemeData(color: AppColors.yellowColor),
    ), // AppBarTheme
    textTheme: TextTheme(
      labelLarge: AppStyles.bold16White,
      labelMedium: AppStyles.medium14White,
      headlineMedium: AppStyles.medium24White,
      headlineLarge: AppStyles.medium20White,
      bodyMedium: AppStyles.medium14Black,
    ),
    tabBarTheme: TabBarTheme(indicatorColor: AppColors.white) 
    // TabBarThemeData(indicatorColor: AppColors.white),
  ); // TextTheme, ThemeData
}
