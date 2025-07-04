import 'package:flutter/material.dart';
import 'package:glowup/Styles/app_colors.dart';

class ThemeManager with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  get themeMode => _themeMode;

  toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.goldenPeach,
  scaffoldBackgroundColor: AppColors.background,
  cardColor: AppColors.white,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.darkText),
    bodyMedium: TextStyle(color: AppColors.darkText),
  ),
  iconTheme: const IconThemeData(color: AppColors.darkText),
  useMaterial3: false,
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.goldenPeachDark,
  scaffoldBackgroundColor: AppColors.backgroundDark,
  cardColor: AppColors.cardDark,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.white),
    bodyMedium: TextStyle(color: AppColors.darkText),
  ),
  iconTheme: const IconThemeData(color: AppColors.lightTextDark),
  useMaterial3: false,
);
