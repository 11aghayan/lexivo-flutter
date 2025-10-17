import 'package:flutter/cupertino.dart';

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
  abstract final Color primary;
  abstract final Color secondary;
  abstract final Color contrastPrimary;
}