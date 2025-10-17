import 'package:flutter/material.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/constants/page_data.dart';
import 'package:lexivo_flutter/enums/app_lang_enum.dart';

class MainPageNavbarWidget extends StatelessWidget {
  const MainPageNavbarWidget({super.key, required this.pages});

  final List<PageData> pages;

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
            // TODO: Make lang dynamic
            label: page.getLabel(AppLang.EN),
          );
        }),
      ),
    );
  }
}
