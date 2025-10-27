import 'package:lexivo_flutter/enums/app_lang_enum.dart';
import 'package:lexivo_flutter/schema/enums/localized_to_string.dart';

enum WordLevel implements LocalizedToString {
  A1,
  A2,
  B1,
  B2,
  C1,
  C2;

  @override
  String toLocalizedString(AppLang _) {
    return name.toUpperCase();
  }
}
