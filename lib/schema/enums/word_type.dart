import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/enums/app_lang_enum.dart';
import 'package:lexivo_flutter/schema/interface/localized_to_string_interface.dart';

enum WordType implements LocalizedToStringInterface {
  NOUN,
  ADJ_ADV,
  VERB,
  PRON_PREP,
  QUESTION_WORD,
  NUMERAL,
  PHRASE;

  @override
  String toLocalizedString(AppLang appLang) {
    return KStrings.getStringsForLang(appLang).wordTypeToString(this);
  }

  @override
  String toString() {
    return name;
  }
}
