import 'package:flutter/material.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/data/shared_pref_keys.dart';
import 'package:lexivo_flutter/enums/app_lang_enum.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLangSwitchWidget extends StatelessWidget {
  const AppLangSwitchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: appThemeNotifier,
      builder: (context, appTheme, child) {
        return ValueListenableBuilder(
          valueListenable: appLangNotifier,
          builder: (context, appLang, child) {
            return DropdownButton(
              icon: SizedBox(width: 10,),
              underline: SizedBox(),
              dropdownColor: ThemeColors.getThemeColors(context).primary,
              onChanged: (newLang) async {
                appLangNotifier.value = newLang!;
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString(keyAppLang, appLangNotifier.value.toString());
              },
              value: appLang,
              items: List.generate(AppLang.values.length, (index) {
                AppLang lang = AppLang.values[index];
                return DropdownMenuItem(
                  value: lang,
                  child: Text(
                    lang.toString(),
                    style: TextStyle(
                      color: ThemeColors.getThemeColors(context).contrastPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              },)
            );
          }
        );
      },
    );
  }
}
