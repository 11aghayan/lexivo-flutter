import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/data/page_data.dart';
import 'package:lexivo_flutter/db/db.dart';
import 'package:lexivo_flutter/enums/app_lang_enum.dart';
import 'package:lexivo_flutter/schema/dictionary/dictionary.dart';
import 'package:lexivo_flutter/schema/language/language.dart';
import 'package:lexivo_flutter/util/snackbar_util.dart';
import 'package:lexivo_flutter/pages/dictionaries_page.dart';
import 'package:lexivo_flutter/pages/profile_page.dart';
import 'package:lexivo_flutter/views/widgets/components/app_bars/app_bar_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/app_bars/side_app_bar_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/switches/app_lang_switch_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/btns/main_page_fab_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/navbars/navbar_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/navbars/side_navbar_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/switches/theme_switch_widget.dart';

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
              actions: [AppLangSwitchWidget(), ThemeSwitchWidget()],
              leading: false,
            ),
      body: Row(
        children: [
          if (isOrientationLandscape)
            SideAppBarWidget(
              titleWidgets: [
                Text(
                  KStrings.appName,
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
              actions: [AppLangSwitchWidget(), ThemeSwitchWidget()],
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
      // TODO: Uncomment when profile page is implemented
      bottomNavigationBar: null, /* isOrientationLandscape
          ? null
          : NavbarWidget(
              pages: pages,
              appLang: widget.appLang,
              selectedPageIndex: pageIndex,
              setPageIndex: setPageIndex,
            ), */
      floatingActionButton: pageIndex == 0
          ? MainPageFabWidget(
              addDictionary: addDictionary,
              updateState: _updateState,
            )
          : null,
    );
  }

  void setPageIndex(int newPageIndex) {
    pageIndex = newPageIndex;
    _updateState();
  }

  void addDictionary(Dictionary dict) async {
    bool success = Dictionary.addDictionary(dict);
    showOperationResultSnackbar(
      context: context,
      text: success
          ? strings.dictionaryAddedSuccessfully
          : strings.duplicateDictionary,
      isSuccess: success,
    );

    await Db.getDb().dict.addDict(dict);

    if (success) {
      _updateState();
    }
  }

  void updateDictionary(Dictionary dict, Language newLang) async {
    bool success = dict.setLanguage(newLang);
    showOperationResultSnackbar(
      context: context,
      text: success
          ? strings.dictionaryLanguageUpdatedSuccessfully
          : strings.duplicateDictionary,
      isSuccess: success,
    );

    await Db.getDb().dict.updateDict(dict);

    if (success) {
      _updateState();
    }
  }

  void deleteDictionary(Dictionary dict) async {
    dict.delete();
    showOperationResultSnackbar(
      context: context,
      text: strings.dictionaryDeleted,
      isSuccess: true,
    );

    await Db.getDb().dict.deleteDictById(dict.id);

    _updateState();
  }

  void _updateState() {
    if (!mounted) return;
    setState(() {});
  }
}
