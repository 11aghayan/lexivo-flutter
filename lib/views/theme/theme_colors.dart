import 'package:flutter/material.dart';
import 'package:lexivo_flutter/schema/enums/word_gender.dart';

class ThemeColorsLight extends ThemeColors {
  @override
  final Color primary = Color.fromRGBO(61, 169, 252, 1);
  @override
  final Color canvas = Color.fromRGBO(247, 251, 255, 1);
  @override
  final Color scaffoldBg = Color.fromRGBO(252, 253, 255, 1);
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
  final Color shadow = Color.fromRGBO(140, 140, 140, 1);
  @override
  final Color failure = Color.fromRGBO(167, 1, 29, 1);
  @override
  final Color deleteBtn = Color.fromRGBO(200, 2, 35, 1);
  @override
  final Color disabledBtn = Color.fromRGBO(171, 171, 171, 1);
  @override
  final Color emptyPageText = Color.fromRGBO(107, 114, 128, 0.7);
  @override
  final Color divider = Color.fromRGBO(196, 198, 203, 1);
  @override
  final Color listItemBg = Color.fromRGBO(221, 224, 227, 1);
  @override
  final Color infoSnackbarBg = Color.fromRGBO(221, 224, 227, 1);
  @override
  final Color searchModeBg = Color.fromRGBO(195, 225, 255, 1);
  @override
  final Color filterNotSelected = Color.fromRGBO(226, 230, 233, 1);
  @override
  final Color searchTextFieldBorder = Color.fromRGBO(215, 215, 215, 1);
}

class ThemeColorsDark extends ThemeColors {
  @override
  final Color primary = Color.fromRGBO(0, 42, 97, 1);
  @override
  final Color canvas = Color.fromRGBO(0, 6, 17, 1);
  @override
  final Color scaffoldBg = Color.fromRGBO(0, 5, 12, 1);
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
  final Color shadow = Color.fromRGBO(72, 72, 72, 1);
  @override
  final Color failure = Color.fromRGBO(131, 1, 23, 1);
  @override
  final Color deleteBtn = Color.fromRGBO(131, 1, 23, 1);
  @override
  final Color disabledBtn = Color.fromRGBO(138, 138, 138, 1);
  @override
  final Color emptyPageText = Color.fromRGBO(167, 171, 181, 0.7);
  @override
  final Color divider = Color.fromRGBO(123, 125, 131, 1);
  @override
  final Color listItemBg = Color.fromRGBO(50, 50, 50, 1);
  @override
  final Color infoSnackbarBg = Color.fromRGBO(50, 50, 50, 1);
  @override
  final Color searchModeBg = Color.fromRGBO(0, 25, 72, 1);
  @override
  final Color filterNotSelected = Color.fromRGBO(0, 31, 88, 1);
  @override
  final Color searchTextFieldBorder = Color.fromRGBO(40, 40, 40, 1);
}

abstract class ThemeColors {
  static final ThemeColors _themeColorsLight = ThemeColorsLight();
  static final ThemeColors _themeColorsDark = ThemeColorsDark();

  abstract final Color primary;
  abstract final Color canvas;
  abstract final Color scaffoldBg;
  abstract final Color accent;
  abstract final Color secondary;
  abstract final Color contrastPrimary;
  abstract final Color mainText;
  abstract final Color shadow;
  abstract final Color dictionaryIconBtn;
  abstract final Color outlinedBtnBorder;
  abstract final Color failure;
  abstract final Color deleteBtn;
  abstract final Color disabledBtn;
  abstract final Color emptyPageText;
  abstract final Color divider;
  abstract final Color listItemBg;
  abstract final Color infoSnackbarBg;
  abstract final Color searchModeBg;
  abstract final Color filterNotSelected;
  abstract final Color searchTextFieldBorder;

  static ThemeColors getThemeColors(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? _themeColorsDark
        : _themeColorsLight;
  }

  static Color getWordGenderColor(WordGender gender) {
    return switch (gender) {
      WordGender.MASCULINE => Color(0xFF3DA9FC),
      WordGender.FEMININE => Color(0xFFFC3DA9),
      WordGender.PERSONAL => Color(0xFF7103C5),
      WordGender.PLURAL => Color(0xFFAA9600),
      _ => Color(0xFF33AA77),
    };
  }
}
