import 'package:flutter/material.dart';

class ThemeColorsLight extends ThemeColors {
  @override
  final Color primary = Color(0xFF3DA9FC);
  @override
  final Color secondary = Color(0xFF6B7280);
  @override
  final Color contrastPrimary = Color(0xFFF9F9F9);
  @override
  final Color mainText = Color(0xFF2E2E2E);
  @override
  final Color dictionaryIconBtnColor = Color(0xFF4A4A4A);
  @override
  final Color dictionaryIconBtnBorderColor = Color(0xFFD7D7D7);
  @override
  final Color cardBorderColor = Color(0xFF999999);
}

class ThemeColorsDark extends ThemeColors {
  @override
  final Color primary = Color(0xFF002A61);
  @override
  final Color secondary = Color(0xFFA7ABB5);
  @override
  final Color contrastPrimary = Color(0xFFC9C9C9);
  @override
  final Color mainText = Color(0xFFCECECE);
  @override
  final Color dictionaryIconBtnColor = Color(0xFF939393);
  @override
  final Color dictionaryIconBtnBorderColor = Color(0xFF282828);
  @override
  final Color cardBorderColor = Color(0xFF666666);
}

abstract class ThemeColors {
  static final ThemeColors _themeColorsLight = ThemeColorsLight();
  static final ThemeColors _themeColorsDark = ThemeColorsDark();

  abstract final Color primary;
  abstract final Color secondary;
  abstract final Color contrastPrimary;
  abstract final Color mainText;
  abstract final Color cardBorderColor;
  abstract final Color dictionaryIconBtnColor;
  abstract final Color dictionaryIconBtnBorderColor;

  static ThemeColors getThemeColors(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? _themeColorsDark
        : _themeColorsLight;
  }
}
