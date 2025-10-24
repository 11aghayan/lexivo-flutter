import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/constants/page_data.dart';
import 'package:lexivo_flutter/enums/app_lang_enum.dart';
import 'package:lexivo_flutter/schema/deletable_interface.dart';
import 'package:lexivo_flutter/schema/dictionary.dart';
import 'package:lexivo_flutter/schema/language.dart';
import 'package:lexivo_flutter/util/snackbar_util.dart';
import 'package:lexivo_flutter/pages/dictionaries_page.dart';
import 'package:lexivo_flutter/pages/profile_page.dart';
import 'package:lexivo_flutter/views/widgets/components/app_bar_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/app_lang_switcher_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/btns/main_page_floating_action_btn_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/navbar_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/theme_switcher_widget.dart';

class MainPageWidgetTree extends StatefulWidget {
  const MainPageWidgetTree({super.key, required this.appLang});

  final AppLang appLang;

  @override
  State<MainPageWidgetTree> createState() => _MainPageWidgetTreeState();
}

class _MainPageWidgetTreeState extends State<MainPageWidgetTree> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<PageData> pages = [
      PageData(
        "dictionariesPageLabel",
        Icon(Icons.menu_book_rounded),
        DictionariesPage(
          updateDictionary: updateDictionary,
          deleteDictionary: deleteDictionary,
        ),
      ),
      PageData("profilePageLabel", Icon(Icons.account_circle), ProfilePage()),
    ];

    return Scaffold(
      appBar: AppBarWidget(
        title: Text(KStrings.appName),
        actions: [AppLangSwitcherWidget(), ThemeSwitcherWidget()],
        leading: false,
      ),
      body: pages[pageIndex].pageWidget,
      bottomNavigationBar: NavbarWidget(
        pages: pages,
        appLang: widget.appLang,
        selectedPageIndex: pageIndex,
        setPageIndex: setPageIndex,
      ),
      floatingActionButton: MainPageFloatingActionBtnWidget(
        pageIndex: pageIndex,
        addDictionary: addDictionary,
      ),
    );
  }

  void setPageIndex(int newPageIndex) {
    setState(() {
      pageIndex = newPageIndex;
    });
  }

  void addDictionary(Dictionary dict) {
    bool success = Dictionary.addDictionary(dict);
    KStrings strings = KStrings.getStringsForLang(appLangNotifier.value);
    showOperationResultSnackbar(
      context,
      success
          ? strings.dictionaryAddedSuccessfully
          : strings.duplicateDictionary,
      success,
    );

    if (success) {
      // TODO: Add to DB
      setState(() {});
    }
  }

  void updateDictionary(Dictionary dict, Language newLang) {
    bool success = dict.setLanguage(newLang);
    KStrings strings = KStrings.getStringsForLang(appLangNotifier.value);
    showOperationResultSnackbar(
      context,
      success
          ? strings.dictionaryLanguageUpdatedSuccessfully
          : strings.duplicateDictionary,
      success,
    );

    if (success) {
      setState(() {});
      // TODO: Update DB
    }
  }

  void deleteDictionary(Deletable dict) {
    dict.delete();
    showOperationResultSnackbar(
      context,
      KStrings.getStringsForLang(appLangNotifier.value).dictionaryDeleted,
      true,
    );
    setState(() {});
    // TODO: Delete from DB
  }
}
