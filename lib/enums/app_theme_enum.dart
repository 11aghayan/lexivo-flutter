enum AppThemeEnum {
  SYSTEM,
  LIGHT,
  DARK;

  AppThemeEnum getNextTheme() {
    return switch(this) {
      SYSTEM => LIGHT,
      LIGHT => DARK,
      DARK => SYSTEM
    };
  }

  @override
  String toString() {
    return switch(this) {
      SYSTEM => "SYSTEM",
      DARK => "DARK",
      LIGHT => "LIGHT"
    };
  }

  static AppThemeEnum fromString(String? theme) {
    return switch(theme) {
      "LIGHT" => LIGHT,
      "DARK" => DARK,
      _ => SYSTEM
    };
  }
}