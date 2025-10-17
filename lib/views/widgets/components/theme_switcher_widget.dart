import 'package:flutter/material.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/data/shared_pref_keys.dart';
import 'package:lexivo_flutter/enums/app_theme_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeSwitcherWidget extends StatelessWidget {
  const ThemeSwitcherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: appThemeNotifier,
      builder: (context, theme, child) {
        return IconButton(
          onPressed: () async {
            appThemeNotifier.value = theme.getNextTheme();
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString(keyAppTheme, appThemeNotifier.value.toString());
          },
          icon: Icon(theme.getIcon()),
        );
      },
    );
  }
}
