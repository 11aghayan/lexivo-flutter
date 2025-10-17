import 'package:flutter/foundation.dart';
import 'package:lexivo_flutter/enums/app_theme_enum.dart';

ValueNotifier<int> mainPageIndexNotifier = ValueNotifier(0);
ValueNotifier<AppThemeEnum> appThemeNotifier = ValueNotifier(AppThemeEnum.SYSTEM);