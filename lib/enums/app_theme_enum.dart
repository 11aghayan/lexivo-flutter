import 'package:flutter/material.dart';

enum AppThemeEnum {
  SYSTEM,
  LIGHT,
  DARK;

  AppThemeEnum getNextTheme() {
    return switch (this) {
      SYSTEM => LIGHT,
      LIGHT => DARK,
      DARK => SYSTEM,
    };
  }

  @override
  String toString() {
    return switch (this) {
      SYSTEM => "SYSTEM",
      DARK => "DARK",
      LIGHT => "LIGHT",
    };
  }

  ThemeMode getThemeMode() {
    return switch (this) {
      AppThemeEnum.DARK => ThemeMode.dark,
      AppThemeEnum.LIGHT => ThemeMode.light,
      _ => ThemeMode.dark,
    };
  }

  IconData getIcon() {
    return switch (this) {
      AppThemeEnum.LIGHT => Icons.dark_mode_rounded,
      AppThemeEnum.DARK => Icons.brightness_auto_rounded,
      _ => Icons.light_mode_rounded,
    };
  }

  static AppThemeEnum fromString(String? theme) {
    return switch (theme) {
      "LIGHT" => LIGHT,
      "DARK" => DARK,
      _ => SYSTEM,
    };
  }
}
