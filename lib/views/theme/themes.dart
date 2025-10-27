import 'package:flutter/material.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';

abstract class Themes {
  static final double navbarIndicatorBorderRadius = 8.0;

  static ThemeData getTheme(bool isDark) {
    ThemeColors colors = isDark ? ThemeColorsDark() : ThemeColorsLight();
    return ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
      primaryColor: colors.primary,
      canvasColor: colors.canvas,
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
          fontSize: 24,
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
            navbarIndicatorBorderRadius,
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
