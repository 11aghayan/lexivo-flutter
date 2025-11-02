import 'package:lexivo_flutter/enums/app_lang_enum.dart';
import 'package:lexivo_flutter/schema/interface/localized_to_string_interface.dart';

enum WordLevel implements LocalizedToStringInterface {
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

  @override
  String toString() {
    return name;
  }

  static WordLevel fromString(String stringValue) {
    return values.firstWhere(
      (wt) => wt.toString() == stringValue.toUpperCase(),
      orElse: () => B1,
    );
  }
}
