import 'package:lexivo_flutter/constants/strings/string_de.dart';
import 'package:lexivo_flutter/constants/strings/strings_en.dart';
import 'package:lexivo_flutter/enums/app_lang_enum.dart';

abstract class KStrings {
  static KStrings? _contentEn;
  static KStrings? _contentDe;

  static final String appName = "Lexivo";
  abstract final String loginSignUp;
  abstract final String settingsPageLabel;
  abstract final String profilePageLabel;
  abstract final String dictionariesPageLabel;
  abstract final String words;
  abstract final String deleteDialogTitle;
  abstract final String addDictDialogTitle;
  abstract final String cancel;
  abstract final String delete;
  abstract final String save;
  abstract final String editDictDialogTitle;
  abstract final String addDictionaryDropdownHint;
  abstract final String noDictSelectedError;
  abstract final String dictionaryAddedSuccessfully;
  abstract final String dictionaryLanguageUpdatedSuccessfully;
  abstract final String duplicateDictionary;
  abstract final String dictionaryDeleted;
  abstract final String noDictionaries;
  abstract final String wordsPageLabel;
  abstract final String grammarsPageLabel;
  abstract final String activitiesPageLabel;
  abstract final String noWords;

  static KStrings getStringsForLang(AppLang appLang) {
    return switch (appLang) {
      AppLang.DE => _contentDe == null ? _initContent(appLang) : _contentDe!,
      _ => _contentEn == null ? _initContent(AppLang.EN) : _contentEn!,
    };
  }

  static KStrings _initContent(AppLang lang) {
    if (lang == AppLang.DE) {
      _contentDe = KStrings_DE();
      return _contentDe!;
    } else {
      _contentEn = KStrings_EN();
      return _contentEn!;
    }
  }

  String operator [](String key) {
    final value = switch (key) {
      "loginSignUp" => loginSignUp,
      "settingsPageLabel" => settingsPageLabel,
      "profilePageLabel" => profilePageLabel,
      "dictionariesPageLabel" => dictionariesPageLabel,
      "wordsPageLabel" => wordsPageLabel,
      "grammarsPageLabel" => grammarsPageLabel,
      "activitiesPageLabel" => activitiesPageLabel,
      _ => "null",
    };
    return value;
  }

  String twoStepDelete(String text);
}
