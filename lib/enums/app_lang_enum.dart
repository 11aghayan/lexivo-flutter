import 'dart:io';

enum AppLang {
  EN,
  DE;

  @override
  String toString() {
    return name.toUpperCase();
  }

  static AppLang getSystemLang() {
    return fromString(Platform.localeName.substring(0, 2).toUpperCase());
  }

  static AppLang fromString(String? langString) {
    return switch (langString) {
      "DE" => DE,
      _ => EN,
    };
  }
}