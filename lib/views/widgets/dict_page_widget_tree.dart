import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/page_data.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/enums/app_lang_enum.dart';
import 'package:lexivo_flutter/schema/dictionary.dart';
import 'package:lexivo_flutter/pages/activities_page.dart';
import 'package:lexivo_flutter/pages/grammars_page.dart';
import 'package:lexivo_flutter/pages/words_page.dart';
import 'package:lexivo_flutter/schema/word.dart';
import 'package:lexivo_flutter/views/widgets/components/app_bar_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/navbar_widget.dart';

class DictPageWidgetTree extends StatefulWidget {
  const DictPageWidgetTree({super.key, required this.dictionary});

  final Dictionary dictionary;

  @override
  State<DictPageWidgetTree> createState() => _DictPageWidgetTreeState();
}

class _DictPageWidgetTreeState extends State<DictPageWidgetTree> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<PageData> pages = [
      PageData("wordsPageLabel", Icon(Icons.abc), WordsPage(words: [Word(), Word()],)),
      PageData(
        "grammarsPageLabel",
        Icon(Icons.fork_left_rounded),
        GrammarsPage(),
      ),
      PageData(
        "activitiesPageLabel",
        Icon(Icons.task_rounded),
        ActivitiesPage(),
      ),
    ];

    PageData currentPageData = pages[pageIndex];
    AppLang appLang = appLangNotifier.value;

    return Scaffold(
      appBar: AppBarWidget(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            Image.asset(
              widget.dictionary.language.photoPath,
              fit: BoxFit.contain,
              height: 40,
              width: 40,
            ),
            Text(
              currentPageData.getLabel(appLang),
            ),
          ],
        ),
        leading: true,
      ),
      body: currentPageData.pageWidget,
      bottomNavigationBar: NavbarWidget(
        pages: pages,
        appLang: appLang,
        setPageIndex: setPageIndex,
        selectedPageIndex: pageIndex,
      ),
    );
  }

  void setPageIndex(int newPageIndex) {
    setState(() {
      pageIndex = newPageIndex;
    });
  }
}
