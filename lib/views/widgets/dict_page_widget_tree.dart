import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/data/page_data.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/enums/app_lang_enum.dart';
import 'package:lexivo_flutter/schema/dictionary/dictionary.dart';
import 'package:lexivo_flutter/pages/activities_page.dart';
import 'package:lexivo_flutter/pages/grammars_page.dart';
import 'package:lexivo_flutter/pages/words_page.dart';
import 'package:lexivo_flutter/schema/word/word.dart';
import 'package:lexivo_flutter/util/export_import_json.dart';
import 'package:lexivo_flutter/util/snackbar_util.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';
import 'package:lexivo_flutter/views/widgets/components/app_bars/app_bar_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/app_bars/side_app_bar_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/btns/dict_page_fab_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/lang_flag_title.dart';
import 'package:lexivo_flutter/views/widgets/components/navbars/navbar_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/navbars/side_navbar_widget.dart';

class DictPageWidgetTree extends StatefulWidget {
  const DictPageWidgetTree({super.key, required this.dictionary});

  final Dictionary dictionary;

  @override
  State<DictPageWidgetTree> createState() => _DictPageWidgetTreeState();
}

class _DictPageWidgetTreeState extends State<DictPageWidgetTree> {
  final KStrings strings = KStrings.getStringsForLang(appLangNotifier.value);
  int pageIndex = 0;
  bool isScrollUpBtnVisible = false;
  ScrollController scrollController = ScrollController();
  bool areNavbarAndAppBarVisible = true;
  final int animationDuration = 300;

  @override
  void initState() {
    scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<PageData> pages = [
      PageData(
        "wordsPageLabel",
        Icons.abc,
        WordsPage(
          dictionary: widget.dictionary,
          isScrollUpBtnVisible: isScrollUpBtnVisible,
          scrollController: scrollController,
        ),
      ),
      PageData("grammarsPageLabel", Icons.fork_left_rounded, GrammarsPage()),
      PageData("activitiesPageLabel", Icons.task_rounded, ActivitiesPage()),
    ];

    bool isOrientationLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    PageData currentPageData = pages[pageIndex];
    AppLang appLang = appLangNotifier.value;

    return Scaffold(
      appBar: isOrientationLandscape
          ? null
          : AppBarWidget(
              titleWidgets: [
                LangFlagTitle(photoPath: widget.dictionary.language.photoPath),
                Text(currentPageData.getLabel(appLang)),
              ],
              actions: appBarActions(pageIndex),
            ),
      floatingActionButton: pageIndex != 0 ? null : DictPageFabWidget(
        dictionary: widget.dictionary,
        updateState: () {
          setState(() {});
          // TODO: Pass a function that will update state and run applyFilter function from words page
        },
        scrollUp: () {
          scrollController.animateTo(
            scrollController.position.minScrollExtent,
            duration: Duration(milliseconds: 200),
            curve: Curves.decelerate,
          );
        },
        scrollUpBtnVisible: isScrollUpBtnVisible,
      ),
      body: Row(
        children: [
          if (isOrientationLandscape)
            SideAppBarWidget(
              titleWidgets: [
                LangFlagTitle(
                  photoPath: widget.dictionary.language.photoPath,
                  height: 50,
                  width: 50,
                ),
                AutoSizeText(
                  maxLines: 1,
                  minFontSize: 12,
                  wrapWords: true,
                  currentPageData.getLabel(appLang),
                  style: TextStyle(
                    color: ThemeColors.getThemeColors(context).contrastPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
              actions: appBarActions(pageIndex, size: 32),
            ),
          Expanded(child: currentPageData.pageWidget),
          if (isOrientationLandscape)
            SideNavbarWidget(
              appLang: appLang,
              pages: pages,
              selectedPageIndex: pageIndex,
              setPageIndex: setPageIndex,
            ),
        ],
      ),

      bottomNavigationBar: isOrientationLandscape
          ? null
          : NavbarWidget(
              pages: pages,
              appLang: appLang,
              setPageIndex: setPageIndex,
              selectedPageIndex: pageIndex,
            ),
    );
  }

  // appBar actions' methods

  List<Widget> appBarActions(int pageIndex, {double? size}) {
    Map<String, Map<int, Function()>> methods = {
      "import": {0: importWords, 1: importGrammar},
      "export": {0: exportWords, 1: exportGrammar},
    };

    return pageIndex == 2
        ? []
        : [
            IconButton(
              onPressed: methods["import"]![pageIndex],
              icon: Icon(Icons.download_rounded, size: size),
              color: ThemeColors.getThemeColors(context).contrastPrimary,
            ),
            IconButton(
              onPressed: methods["export"]![pageIndex],
              icon: Icon(Icons.upload_rounded, size: size),
              color: ThemeColors.getThemeColors(context).contrastPrimary,
            ),
          ];
  }

  void importWords() async {
    try {
      List<dynamic>? data = await importJsonData();
      if (data != null) {
        List<Word> words = data.map((e) => Word.fromJson(e)).toList();
        setState(() {
          widget.dictionary.addWords(words);
        });

        if (mounted) {
          showOperationResultSnackbar(
            context: context,
            text: strings.wordsImportedSuccessfully,
            isSuccess: true,
          );
        }
      }
    } catch (e) {
      print(e);
      if (mounted) {
        showOperationResultSnackbar(
          context: context,
          text: strings.wordsCouldNotBeImported,
          isSuccess: false,
        );
      }
    }
  }

  void exportWords() async {
    bool canceled = await exportJsonData(
      data: widget.dictionary.allWords,
      filename:
          "${strings.words.toLowerCase()}_lexivo_${widget.dictionary.language.name}",
    );
    if (!canceled && mounted) {
      showOperationResultSnackbar(
        context: context,
        text: strings.wordsExportedSuccessfully,
        isSuccess: true,
      );
    }
  }

  void importGrammar() {
    print("Grammar Imported");
    // TODO: implement
  }

  void exportGrammar() {
    print("Grammar Exported");
    // TODO: implement
  }

  // Scroll control methods
  void setScrollUpBtnVisibility(bool isVisible) {
    if (!mounted) return;
    isScrollUpBtnVisible = isVisible;
  }

  void _onScroll() {
    if (pageIndex != 0) return;

    double offset = scrollController.offset;
    int offsetLimit = 30;

    // scroll down → hide navbar
    if (!isScrollUpBtnVisible && offset > offsetLimit) {
      _scheduleSafeSetState(() {
        setScrollUpBtnVisibility(true);
      });
    }
    // scroll up → show navbar
    else if (isScrollUpBtnVisible && offset < offsetLimit) {
      _scheduleSafeSetState(() {
        setScrollUpBtnVisibility(false);
      });
    }
  }

  void _scheduleSafeSetState(VoidCallback fn) {
    if (!mounted) return;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      try {
        setState(fn);
      } catch (_) {}
    });
  }

  //

  void setPageIndex(int newPageIndex) {
    setState(() {
      pageIndex = newPageIndex;
    });
  }

  //   Widget generateNavigationItem(BuildContext context, int index) {
  //     var colors = ThemeColors.getThemeColors(context);
  //     bool isSelected = pageIndex == index;
  //     PageData page = pages[index];
  //     return CustomFilledButtonWidget(
  //       onPressed: () {
  //         if (setPageIndex != null) {
  //           setPageIndex!(index);
  //         }
  //       },
  //       backgroundColor: isSelected ? colors.contrastPrimary : colors.primary,
  //       // height: 20,
  //       child: Icon(
  //         page.icon,
  //         // size: 24,
  //         color: isSelected ? colors.primary : colors.contrastPrimary,
  //       ),
  //     );
  //   }
}
