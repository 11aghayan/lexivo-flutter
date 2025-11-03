import 'package:lexivo_flutter/constants/strings/string_de.dart';
import 'package:lexivo_flutter/constants/strings/strings_en.dart';
import 'package:lexivo_flutter/enums/app_lang_enum.dart';
import 'package:lexivo_flutter/schema/enums/word_gender.dart';
import 'package:lexivo_flutter/schema/enums/word_type.dart';

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
  abstract final String practicePageLabel;
  abstract final String noWords;
  abstract final String search;
  abstract final String level;
  abstract final String gender;
  abstract final String type;
  abstract final String filters;
  abstract final String wordsExportedSuccessfully;
  abstract final String wordsImportedSuccessfully;
  abstract final String wordsCouldNotBeImported;
  abstract final String wordAddedSuccessfully;
  abstract final String wordCouldNotBeAdded;
  abstract final String wordUpdatedSuccessfully;
  abstract final String wordCouldNotBeUpdated;
  abstract final String addWordPageLabel;
  abstract final String updateWordPageLabel;
  abstract final String word;
  abstract final String wordDetails;
  abstract final String plural;
  abstract final String past;
  abstract final String desc;
  abstract final String descDetails;
  abstract final String optional;
  abstract final String emptyTextFieldError;
  

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
      "activitiesPageLabel" => practicePageLabel,
      _ => "null",
    };
    return value;
  }

  String wordTypeToString(WordType wordType);
  String wordGenderToString(WordGender wordGender);

  String twoStepDelete(String text);
}
