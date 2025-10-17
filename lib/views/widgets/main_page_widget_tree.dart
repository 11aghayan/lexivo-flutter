import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/constants/page_data.dart';
import 'package:lexivo_flutter/enums/app_lang_enum.dart';
import 'package:lexivo_flutter/views/pages/dictionaries_page.dart';
import 'package:lexivo_flutter/views/pages/profile_page.dart';
import 'package:lexivo_flutter/views/widgets/components/app_bar_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/app_lang_switcher_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/main_page_navbar_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/theme_switcher_widget.dart';

final List<PageData> pages = [
  PageData(
    "dictionariesPageLabel",
    Icon(Icons.menu_book_rounded),
    DictionariesPage(),
  ),
  PageData("profilePageLabel", Icon(Icons.account_circle), ProfilePage())
];

class MainPageWidgetTree extends StatefulWidget {
  const MainPageWidgetTree({super.key, required this.appLang});

  final AppLang appLang;

  @override
  State<MainPageWidgetTree> createState() => _MainPageWidgetTreeState();
}

class _MainPageWidgetTreeState extends State<MainPageWidgetTree> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: mainPageIndexNotifier,
      builder: (context, pageIndex, child) {
        return Scaffold(
          appBar: AppBarWidget(
            title: KStrings.appName,
            actions: [
              AppLangSwitcherWidget(),
              ThemeSwitcherWidget()
            ],
          ),
          body: pages[pageIndex].pageWidget,
          bottomNavigationBar: MainPageNavbarWidget(pages: pages, appLang: widget.appLang,),
        );
      },
    );
  }
}
