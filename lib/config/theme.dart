import 'package:flutter/material.dart';
import 'color.dart';

ThemeData theme(BuildContext context) {
  return ThemeData(
    useMaterial3: false,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        disabledBackgroundColor: AppColors.primary.withAlpha(150),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
      ),
    ),
    fontFamily: 'Roboto',
  );
}
