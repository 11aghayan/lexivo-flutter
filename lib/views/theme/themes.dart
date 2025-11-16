import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';

abstract class Themes {
  static ThemeData getTheme(bool isDark) {
    final colors = isDark ? ThemeColorsDark() : ThemeColorsLight();
    return ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
      primaryColor: colors.primary,
      canvasColor: colors.canvas,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colors.mainText,
        selectionColor: colors.primary,
        selectionHandleColor: colors.primary
      ),
      scaffoldBackgroundColor: colors.scaffoldBg,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colors.accent,
        foregroundColor: colors.contrastPrimary
      ),
      appBarTheme: AppBarThemeData(
        backgroundColor: colors.primary,
        titleTextStyle: TextStyle(
          color: colors.contrastPrimary,
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
        actionsIconTheme: IconThemeData(color: colors.contrastPrimary),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colors.primary,
        labelTextStyle: WidgetStatePropertyAll(
          TextStyle(color: colors.contrastPrimary),
        ),
        indicatorColor: colors.contrastPrimary,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(
            Sizes.navbarIndicatorBorderRadius,
          ),
        ),
        iconTheme: WidgetStateMapper({
          WidgetState.selected: IconThemeData(color: colors.primary),
          WidgetState.any: IconThemeData(color: colors.contrastPrimary),
        }),
      ),
      fontFamilyFallback: [
        "NotoSans",
        "NotoSansArabic",
        "NotoSansArmenian",
        "NotoSansEthiopic",
        "NotoSansGeorgian",
        "NotoSansHebrew",
        "NotoSansBengali",
        "NotoSansKr",
        "NotoSansMalayalam",
        "NotoSansNk",
        "NotoSansNewa",
        "NotoSansSc",
        "NotoSansTamil",
        "NotoSansTc",
        "NotoSansTelugu",
        "NotoSansJp",
        "NotoSansThai",
      ],
    );
  }
}
