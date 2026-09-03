import 'package:flutter/material.dart';
import 'package:news_c19/ui/utils/app_colors.dart';

abstract final class AppTheme {
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: AppColors.white,
      brightness: Brightness.light,
      primaryColor: Colors.white,
      colorScheme: ColorScheme.light(
        primary: AppColors.white,
        secondary: AppColors.black,
        brightness: Brightness.light
      ),
      iconTheme: IconThemeData(size: 24, color: AppColors.white),
      dividerTheme: DividerThemeData(
        color: AppColors.white,
        thickness: 1,
      ),
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: AppColors.black),
          titleTextStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: AppColors.black)),
      textTheme: TextTheme(
          titleLarge: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w500,
              color: AppColors.white),
          titleMedium: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: AppColors.black),
          titleSmall: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.black),
          bodyLarge: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.white),
          bodyMedium: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.black),
          bodySmall: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.black),
          displayLarge: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.white),
          displayMedium: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.grey)),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.black
      ));

  static ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: AppColors.black,
      brightness: Brightness.dark,
      primaryColor: Colors.black,
      iconTheme: IconThemeData(size: 24, color: AppColors.white),
      dividerTheme: DividerThemeData(
        color: AppColors.white,
        thickness: 1,
      ),
      colorScheme: ColorScheme.light(
        primary: AppColors.black,
        secondary: AppColors.white,
          brightness: Brightness.dark
      ),
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: AppColors.white),
          titleTextStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: AppColors.white)),
      textTheme: TextTheme(
          titleLarge: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w500,
              color: AppColors.black),
          titleMedium: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: AppColors.white),
          titleSmall: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.white),
          bodyLarge: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.black),
          bodyMedium: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.white),
          bodySmall: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.white),
          displayLarge: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.black),
          displayMedium: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.grey)), progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColors.white
  ));
}
