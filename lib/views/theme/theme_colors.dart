import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeColorsLight extends ThemeColors {
  @override
  final Color primary = Color(0xFF3DA9FC);
  @override
  final Color secondary = Color(0xFF6B7280);
  @override
  final Color contrastPrimary = Color(0xFFF9F9F9);
}

class ThemeColorsDark extends ThemeColors {
  @override
  final Color primary = Color(0xFF002A61);
  @override
  final Color secondary = Color(0xFFA7ABB5);
  @override
  final Color contrastPrimary = Color(0xFFC9C9C9);
}

abstract class ThemeColors {
  static final ThemeColors _themeColorsLight = ThemeColorsLight();
  static final ThemeColors _themeColorsDark = ThemeColorsDark();

  abstract final Color primary;
  abstract final Color secondary;
  abstract final Color contrastPrimary;

  static ThemeColors getThemeColors(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? _themeColorsDark
        : _themeColorsLight;
  }
}
