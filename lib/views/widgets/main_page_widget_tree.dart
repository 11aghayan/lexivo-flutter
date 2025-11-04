import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/data/page_data.dart';
import 'package:lexivo_flutter/enums/app_lang_enum.dart';
import 'package:lexivo_flutter/schema/interface/deletable_interface.dart';
import 'package:lexivo_flutter/schema/dictionary/dictionary.dart';
import 'package:lexivo_flutter/schema/language/language.dart';
import 'package:lexivo_flutter/util/snackbar_util.dart';
import 'package:lexivo_flutter/pages/dictionaries_page.dart';
import 'package:lexivo_flutter/pages/profile_page.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';
import 'package:lexivo_flutter/views/widgets/components/app_bars/app_bar_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/app_bars/side_app_bar_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/app_lang_switcher_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/btns/main_page_fab_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/navbars/navbar_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/navbars/side_navbar_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/theme_switcher_widget.dart';

class MainPageWidgetTree extends StatefulWidget {
  const MainPageWidgetTree({super.key, required this.appLang});

  final AppLang appLang;

  @override
  State<MainPageWidgetTree> createState() => _MainPageWidgetTreeState();
}

class _MainPageWidgetTreeState extends State<MainPageWidgetTree> {
  final strings = KStrings.getStringsForLang(appLangNotifier.value);
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<PageData> pages = [
      PageData(
        "dictionariesPageLabel",
        FontAwesomeIcons.book,
        DictionariesPage(
          updateDictionary: updateDictionary,
          deleteDictionary: deleteDictionary,
        ),
      ),
      PageData("profilePageLabel", FontAwesomeIcons.user, ProfilePage()),
    ];

    bool isOrientationLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: isOrientationLandscape
          ? null
          : AppBarWidget(
              titleWidgets: [Text(KStrings.appName)],
              actions: [AppLangSwitcherWidget(), ThemeSwitcherWidget()],
              leading: false,
            ),
      body: Row(
        children: [
          if (isOrientationLandscape)
            SideAppBarWidget(
              titleWidgets: [
                AutoSizeText(
                  KStrings.appName,
                  maxLines: 1,
                  minFontSize: 20,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: ThemeColors.getThemeColors(context).contrastPrimary,
                  ),
                ),
              ],
              actions: [AppLangSwitcherWidget(), ThemeSwitcherWidget()],
              leading: false,
            ),
          Expanded(child: pages[pageIndex].pageWidget),
          if (isOrientationLandscape)
            SideNavbarWidget(
              pages: pages,
              appLang: widget.appLang,
              setPageIndex: setPageIndex,
              selectedPageIndex: pageIndex,
            ),
        ],
      ),
      bottomNavigationBar: isOrientationLandscape
          ? null
          : NavbarWidget(
              pages: pages,
              appLang: widget.appLang,
              selectedPageIndex: pageIndex,
              setPageIndex: setPageIndex,
            ),
      floatingActionButton: pageIndex == 0
          ? MainPageFabWidget(addDictionary: addDictionary)
          : null,
    );
  }

  void setPageIndex(int newPageIndex) {
    setState(() {
      pageIndex = newPageIndex;
    });
  }

  void addDictionary(Dictionary dict) {
    bool success = Dictionary.addDictionary(dict);
    showOperationResultSnackbar(
      context: context,
      text: success
          ? strings.dictionaryAddedSuccessfully
          : strings.duplicateDictionary,
      isSuccess: success,
    );

    if (success) {
      // TODO: Add to DB
      setState(() {});
    }
  }

  void updateDictionary(Dictionary dict, Language newLang) {
    bool success = dict.setLanguage(newLang);
    showOperationResultSnackbar(
      context: context,
      text: success
          ? strings.dictionaryLanguageUpdatedSuccessfully
          : strings.duplicateDictionary,
      isSuccess: success,
    );

    if (success) {
      setState(() {});
      // TODO: Update DB
    }
  }

  void deleteDictionary(Deletable dict) {
    dict.delete();
    showOperationResultSnackbar(
      context: context,
      text: strings.dictionaryDeleted,
      isSuccess: true,
    );
    setState(() {});
    // TODO: Delete from DB
  }
}
