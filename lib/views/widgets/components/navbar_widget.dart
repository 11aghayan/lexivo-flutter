import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/page_data.dart';
import 'package:lexivo_flutter/enums/app_lang_enum.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({
    super.key,
    required this.pages,
    required this.appLang,
    required this.setPageIndex,
    required this.selectedPageIndex,
  });

  final List<PageData> pages;
  final AppLang appLang;
  final Function(int) setPageIndex;
  final int selectedPageIndex;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: (int newIndex) => setPageIndex(newIndex),
      selectedIndex: selectedPageIndex,
      destinations: List.generate(pages.length, (index) {
        var page = pages[index];
        return NavigationDestination(
          icon: page.icon,
          label: page.getLabel(appLang),
        );
      }),
    );
  }
}
