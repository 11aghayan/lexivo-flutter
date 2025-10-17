import 'package:flutter/material.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/data/shared_pref_keys.dart';
import 'package:lexivo_flutter/enums/app_theme_enum.dart';
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
    super.initState();
  }

  void initTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    AppThemeEnum theme = AppThemeEnum.fromString(prefs.getString(keyAppTheme));
    appThemeNotifier.value = theme;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: appThemeNotifier,
      builder: (context, theme, child) {
        return MaterialApp(
          themeMode: theme == AppThemeEnum.SYSTEM
              ? ThemeMode.system
              : theme == AppThemeEnum.LIGHT
              ? ThemeMode.light
              : ThemeMode.dark,
          theme: Themes.getTheme(false),
          darkTheme: Themes.getTheme(true),
          home: MainPageWidgetTree(),
        );
      },
    );
  }
}
