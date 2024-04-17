import 'package:flutter/material.dart';

import 'app_colors.dart';

// ! If primary color was modified, make sure to change also the color -
// ! in flutter native splash & flutter launcher icon in pubspec.yml
final lightColorScheme = ColorScheme.light(
  brightness: Brightness.light,
  background: Colors.grey.shade300,
  primary: AppColors.lightPrimary,
  secondary: Colors.grey.shade100,
  tertiary: Colors.white,
  inversePrimary: Colors.grey.shade700,
);

final darkColorScheme = ColorScheme.dark(
  brightness: Brightness.dark,
  background: Colors.grey.shade900,
  primary: AppColors.darkPrimary,
  secondary: Colors.grey.shade800,
  tertiary: Colors.white,
  inversePrimary: Colors.grey.shade300,
);
