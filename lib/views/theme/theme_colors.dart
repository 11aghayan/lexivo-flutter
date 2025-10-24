import 'package:flutter/material.dart';

class ThemeColorsLight extends ThemeColors {
  @override
  final Color primary = Color.fromRGBO(61, 169, 252, 1);
  @override
  final Color accent = Color.fromRGBO(249, 87, 56, 1);
  @override
  final Color secondary = Color.fromRGBO(107, 114, 128, 1);
  @override
  final Color contrastPrimary = Color.fromRGBO(249, 249, 249, 1);
  @override
  final Color mainText = Color.fromRGBO(46, 46, 46, 1);
  @override
  final Color dictionaryIconBtn = Color.fromRGBO(74, 74, 74, 1);
  @override
  final Color outlinedBtnBorder = Color.fromRGBO(215, 215, 215, 1);
  @override
  final Color cardBorder = Color.fromRGBO(153, 153, 153, 1);
  @override
  final Color success = Color.fromRGBO(46, 158, 109, 1);
  @override
  final Color failure = Color.fromRGBO(167, 1, 29, 1);
  @override
  final Color deleteBtn = Color.fromRGBO(167, 1, 29, 1);
  @override
  final Color disabledBtn = Color.fromRGBO(171, 171, 171, 1);
  @override
  final Color emptyPageText = Color.fromRGBO(107, 114, 128, 0.7);
  @override
  final Color dividerColor = Color.fromRGBO(196, 198, 203, 1);
}

class ThemeColorsDark extends ThemeColors {
  @override
  final Color primary = Color.fromRGBO(0, 42, 97, 1);
  @override
  final Color accent = Color.fromRGBO(158, 56, 35, 1);
  @override
  final Color secondary = Color.fromRGBO(167, 171, 181, 1);
  @override
  final Color contrastPrimary = Color.fromRGBO(201, 201, 201, 1);
  @override
  final Color mainText = Color.fromRGBO(206, 206, 206, 1);
  @override
  final Color dictionaryIconBtn = Color.fromRGBO(147, 147, 147, 1);
  @override
  final Color outlinedBtnBorder = Color.fromRGBO(40, 40, 40, 1);
  @override
  final Color cardBorder = Color.fromRGBO(102, 102, 102, 1);
  @override
  final Color success = Color.fromRGBO(32, 109, 76, 1);
  @override
  final Color failure = Color.fromRGBO(131, 1, 23, 1);
  @override
  final Color deleteBtn = Color.fromRGBO(131, 1, 23, 1);
  @override
  final Color disabledBtn = Color.fromRGBO(138, 138, 138, 1);
  @override
  final Color emptyPageText = Color.fromRGBO(167, 171, 181, 0.7);
  @override
  final Color dividerColor = Color.fromRGBO(123, 125, 131, 1);
}

abstract class ThemeColors {
  static final ThemeColors _themeColorsLight = ThemeColorsLight();
  static final ThemeColors _themeColorsDark = ThemeColorsDark();

  abstract final Color primary;
  abstract final Color accent;
  abstract final Color secondary;
  abstract final Color contrastPrimary;
  abstract final Color mainText;
  abstract final Color cardBorder;
  abstract final Color dictionaryIconBtn;
  abstract final Color outlinedBtnBorder;
  abstract final Color success;
  abstract final Color failure;
  abstract final Color deleteBtn;
  abstract final Color disabledBtn;
  abstract final Color emptyPageText;
  abstract final Color dividerColor;

  static ThemeColors getThemeColors(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? _themeColorsDark
        : _themeColorsLight;
  }
}
