import 'package:flutter/material.dart';

import 'app_colors.dart';

// ! If primary color was modified, make sure to change also the color -
// ! in flutter native splash & flutter launcher icon in pubspec.yml
final lightColorScheme = ColorScheme.light(
  brightness: Brightness.light,
  background: Colors.grey.shade300,
  primary: AppColors.lightPrimary,
  primaryContainer: Colors.white,
  secondary: Colors.grey.shade100,
  tertiary: Colors.white,
  tertiaryContainer: Colors.white,
  onTertiaryContainer: Colors.black87,
  inversePrimary: Colors.grey.shade700,
);

final darkColorScheme = ColorScheme.dark(
  brightness: Brightness.dark,
  background: Colors.grey.shade900,
  primary: AppColors.darkPrimary,
  primaryContainer: Colors.grey.shade800,
  secondary: Colors.grey.shade800,
  tertiary: Colors.white,
  tertiaryContainer: Colors.black87,
  onTertiaryContainer: Colors.white,
  inversePrimary: Colors.grey.shade300,
);
