import 'package:flutter/material.dart';

enum AppTheme {
  SYSTEM,
  LIGHT,
  DARK;

  AppTheme getNextTheme() {
    return switch (this) {
      SYSTEM => LIGHT,
      LIGHT => DARK,
      DARK => SYSTEM,
    };
  }

  @override
  String toString() {
    return name.toUpperCase();
  }

  ThemeMode getThemeMode() {
    return switch (this) {
      DARK => ThemeMode.dark,
      LIGHT => ThemeMode.light,
      _ => ThemeMode.system,
    };
  }

  IconData getIcon() {
    return switch (this) {
      LIGHT => Icons.dark_mode_rounded,
      DARK => Icons.brightness_auto_rounded,
      _ => Icons.light_mode_rounded,
    };
  }

  static AppTheme fromString(String? theme) {
    return switch (theme) {
      "LIGHT" => LIGHT,
      "DARK" => DARK,
      _ => SYSTEM,
    };
  }
}
