import 'package:flutter/foundation.dart';
import 'package:lexivo_flutter/enums/app_theme_enum.dart';
import 'package:lexivo_flutter/enums/app_lang_enum.dart';

ValueNotifier<AppTheme> appThemeNotifier = ValueNotifier(AppTheme.SYSTEM);
ValueNotifier<AppLang> appLangNotifier = ValueNotifier(AppLang.getSystemLang());