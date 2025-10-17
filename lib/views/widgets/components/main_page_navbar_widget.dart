import 'package:flutter/material.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/constants/page_data.dart';
import 'package:lexivo_flutter/enums/app_lang_enum.dart';

class MainPageNavbarWidget extends StatelessWidget {
  const MainPageNavbarWidget({super.key, required this.pages, required this.appLang});

  final List<PageData> pages;
  final AppLang appLang;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: mainPageIndexNotifier,
      builder: (context, selectedPageIndex, child) => NavigationBar(
        onDestinationSelected: (int newIndex) => mainPageIndexNotifier.value = newIndex,
        selectedIndex: selectedPageIndex,
        destinations: List.generate(pages.length, (index) {
          var page = pages[index];
          return NavigationDestination(
            icon: page.icon,
            label: page.getLabel(appLang),
          );
        }),
      ),
    );
  }
}
