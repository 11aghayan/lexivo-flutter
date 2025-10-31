import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/enums/app_lang_enum.dart';
import 'package:lexivo_flutter/schema/interface/localized_to_string_interface.dart';

enum WordGender implements LocalizedToStringInterface {
  MASCULINE,
  FEMININE,
  NEUTER,
  PERSONAL,
  PLURAL,
  NO_GENDER;

  @override
  String toLocalizedString(AppLang appLang) {
    return KStrings.getStringsForLang(appLang).wordGenderToString(this);
  }

  @override
  String toString() {
    return name;
  }
}
