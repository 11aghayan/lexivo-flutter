import 'package:flutter/material.dart';
import 'package:lexivo_flutter/data/page_data.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/enums/app_lang_enum.dart';
import 'package:lexivo_flutter/schema/dictionary.dart';
import 'package:lexivo_flutter/pages/activities_page.dart';
import 'package:lexivo_flutter/pages/grammars_page.dart';
import 'package:lexivo_flutter/pages/words_page.dart';
import 'package:lexivo_flutter/schema/enums/word_gender.dart';
import 'package:lexivo_flutter/schema/enums/word_level.dart';
import 'package:lexivo_flutter/schema/enums/word_type.dart';
import 'package:lexivo_flutter/schema/word.dart';
import 'package:lexivo_flutter/views/widgets/components/app_bar_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/btns/dict_page_fab_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/navbar_widget.dart';

class DictPageWidgetTree extends StatefulWidget {
  const DictPageWidgetTree({super.key, required this.dictionary});

  final Dictionary dictionary;

  @override
  State<DictPageWidgetTree> createState() => _DictPageWidgetTreeState();
}

class _DictPageWidgetTreeState extends State<DictPageWidgetTree> {
  int pageIndex = 0;
  bool isScrollUpBtnVisible = false;
  ScrollController scrollController = ScrollController();
  bool areNavbarAndAppBarVisible = true;
  double lastScrollOffset = 0;
  final int animationDuration = 300;

  @override
  void initState() {
    controlNavbarVisibilityOnScroll();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  // TODO: Add import, export btn for each page

  @override
  Widget build(BuildContext context) {
    // TODO: remove
    if (widget.dictionary.allWordsCount == 0) {
      widget.dictionary.addWords([
        Word(
          WordType.NOUN,
          WordLevel.A1,
          WordGender.MASCULINE,
          "der Zug",
          null,
          "die Züge",
          null,
          null,
          "train",
          null,
        ),
        Word(
          WordType.NOUN,
          WordLevel.A2,
          WordGender.PLURAL,
          null,
          null,
          "die Ämter",
          null,
          null,
          "authorities",
          null,
        ),
        Word(
          WordType.VERB,
          WordLevel.A2,
          null,
          "erinnern",
          "etw Akk",
          null,
          "erinnerte",
          "haben erinnert",
          "to remember",
          "sth.",
        ),
        Word(
          WordType.ADJ_ADV,
          WordLevel.A1,
          null,
          "schön",
          null,
          null,
          null,
          null,
          "nice, beautiful",
          null,
        ),
        Word(
          WordType.NOUN,
          WordLevel.A1,
          WordGender.MASCULINE,
          "der Zug",
          null,
          "die Züge",
          null,
          null,
          "train",
          null,
        ),
        Word(
          WordType.NOUN,
          WordLevel.A2,
          WordGender.PLURAL,
          null,
          null,
          "die Ämter",
          null,
          null,
          "authorities",
          null,
        ),
        Word(
          WordType.VERB,
          WordLevel.A2,
          null,
          "erinnern",
          "etw Akk",
          null,
          "erinnerte",
          "haben erinnert",
          "to remember",
          "sth.",
        ),
        Word(
          WordType.ADJ_ADV,
          WordLevel.A1,
          null,
          "schön",
          null,
          null,
          null,
          null,
          "nice, beautiful",
          null,
        ),
      ]);
    }

    List<PageData> pages = [
      PageData(
        "wordsPageLabel",
        Icon(Icons.abc),
        WordsPage(
          dictionary: widget.dictionary,
          isScrollUpBtnVisible: isScrollUpBtnVisible,
          scrollController: scrollController,
        ),
      ),
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
            Text(currentPageData.getLabel(appLang)),
          ],
        ),
        isVisible: areNavbarAndAppBarVisible,
        animationDuration: animationDuration,
      ),
      floatingActionButton: DictPageFabWidget(
        scrollUp: () {
          scrollController.animateTo(
            scrollController.position.minScrollExtent,
            duration: Duration(milliseconds: 200),
            curve: Curves.decelerate,
          );
        },
        pageIndex: pageIndex,
        scrollUpBtnVisible: isScrollUpBtnVisible,
      ),
      body: SafeArea(child: currentPageData.pageWidget),
      bottomNavigationBar: AnimatedContainer(
        duration: Duration(milliseconds: animationDuration),
        height: areNavbarAndAppBarVisible ? 104 : 0,
        child: NavbarWidget(
          pages: pages,
          appLang: appLang,
          setPageIndex: setPageIndex,
          selectedPageIndex: pageIndex,
        ),
      ),
    );
  }

  void setPageIndex(int newPageIndex) {
    setState(() {
      pageIndex = newPageIndex;
    });
  }

  void setScrollUpBtnVisibility(bool isVisible) {
    if (!mounted) return;
    setState(() {
      isScrollUpBtnVisible = isVisible;
    });
  }

  void controlNavbarVisibilityOnScroll() {
    scrollController.addListener(() {
      if (pageIndex != 0) return;
      
      double offset = scrollController.offset;

      // scroll down → hide navbar
      if (offset > 30 && lastScrollOffset < offset) {
        setState(() {
          setScrollUpBtnVisibility(true);
          areNavbarAndAppBarVisible = false;
        });
      }
      // scroll up → show navbar
      else if ((offset < lastScrollOffset - 20) || (offset < 10)) {
        setState(() {
          setScrollUpBtnVisibility(false);
          areNavbarAndAppBarVisible = true;
        });
      }

      lastScrollOffset = offset;
    });
  }
}
