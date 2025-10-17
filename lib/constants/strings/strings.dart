import 'package:lexivo_flutter/constants/strings/string_de.dart';
import 'package:lexivo_flutter/constants/strings/strings_en.dart';
import 'package:lexivo_flutter/enums/app_lang_enum.dart';

abstract class KStrings {
  static KStrings? _contentEn;
  static KStrings? _contentDe;

  final String appName = "Lexivo";
  abstract final String loginSignUp;
  abstract final String settingsPageLabel;
  abstract final String profilePageLabel;
  abstract final String dictionariesPageLabel;

  static KStrings getStringsForLang(AppLang lang) {
     return switch(lang) {
      AppLang.DE => _contentDe == null ? _initContent(lang) : _contentDe!,
      _ => _contentEn == null ? _initContent(AppLang.EN) : _contentEn!
     };
  }

  static KStrings _initContent(AppLang lang) {
    if (lang == AppLang.DE) {
      _contentDe = KStrings_DE();
      return _contentDe!;
    }
    else {
      _contentEn = KStrings_EN();
      return _contentEn!;
    }
  }

  String operator [](String key) {
    final value = switch (key) {
      'loginSignUp' => loginSignUp,
      'settingsPageLabel' => settingsPageLabel,
      'profilePageLabel' => profilePageLabel,
      'dictionariesPageLabel' => dictionariesPageLabel,
      _ => "null",
    };
    return value;
  }
}