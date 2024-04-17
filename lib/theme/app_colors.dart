import 'package:flutter/material.dart';

/// * Static colors that can be implemented across the app
class AppColors {
  AppColors._();

  static Color lightPrimary = const Color(0xFFe9c348);
  static Color darkPrimary = const Color(0xFFe9c348);

  static const greyColor = Color(0xFFf4f4f4);
  static const greyColorVariant = Color(0xFFf5f5f7);
  static const bottomNavGreyLight = Color(0xFFdedede);
  static const bottomNavGreyDark = Color(0xFF434548);

  static Color getGreyVariant(ThemeData theme) {
    final isDarkMode = theme.brightness == Brightness.dark;

    if (isDarkMode) {
      return theme.colorScheme.surfaceVariant;
    }

    return AppColors.greyColorVariant;
  }

  static Color disabledBackgroundColor(ThemeData theme) {
    return theme.colorScheme.onSurface.withOpacity(0.12);
  }

  static Color disabledForegroundColor(ThemeData theme) {
    return theme.colorScheme.onSurface.withOpacity(0.38);
  }
}
