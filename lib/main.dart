import 'package:flutter/material.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/data/shared_pref_keys.dart';
import 'package:lexivo_flutter/enums/app_lang_enum.dart';
import 'package:lexivo_flutter/enums/app_theme_enum.dart';
import 'package:lexivo_flutter/schema/dictionary.dart';
import 'package:lexivo_flutter/schema/language.dart';
import 'package:lexivo_flutter/schema/word.dart';
import 'package:lexivo_flutter/views/theme/themes.dart';
import 'package:lexivo_flutter/views/widgets/main_page_widget_tree.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    initTheme();
    initAppLang();
    initLanguages();
    initDictionaries();
    super.initState();
  }

  void initTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    AppTheme theme = AppTheme.fromString(prefs.getString(keyAppTheme));
    appThemeNotifier.value = theme;
  }

  void initAppLang() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    AppLang lang = AppLang.fromString(prefs.getString(keyAppLang));
    appLangNotifier.value = lang;
  }

  void initLanguages() {
    Language.init();
  }

  void initDictionaries() {
    // var dicts = [
    //   Dictionary.existing(Language.english, List.filled(4022, Word())),
    //   Dictionary.existing(Language.german, List.filled(1973, Word())),
    //   Dictionary(Language.russian),
    //   Dictionary(Language.french),
    //   Dictionary(Language.spanish),
    //   Dictionary(Language.italian),
    // ];
    // Dictionary.setAllDictionaries(dicts);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: appThemeNotifier,
      builder: (context, theme, child) {
        return ValueListenableBuilder(
          valueListenable: appLangNotifier,
          builder: (context, appLang, child) {
            return MaterialApp(
              themeMode: theme.getThemeMode(),
              theme: Themes.getTheme(false),
              darkTheme: Themes.getTheme(true),
              home: MainPageWidgetTree(appLang: appLang),
            );
          },
        );
      },
    );
  }
}
