import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/data/filter_data.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/schema/dictionary.dart';
import 'package:lexivo_flutter/schema/enums/localized_to_string.dart';
import 'package:lexivo_flutter/schema/enums/word_gender.dart';
import 'package:lexivo_flutter/schema/enums/word_level.dart';
import 'package:lexivo_flutter/schema/enums/word_type.dart';
import 'package:lexivo_flutter/schema/word.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';
import 'package:lexivo_flutter/views/widgets/components/btns/custom_outlined_button_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/text_field/search_words_text_field_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/word_card/word_card_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/word_filters/filters_container_widget.dart';
import 'package:visibility_detector/visibility_detector.dart';

class WordsPage extends StatefulWidget {
  const WordsPage({
    super.key,
    required this.dictionary,
    required this.isScrollUpBtnVisible,
    required this.setScrollUpBtnVisibility,
    required this.scrollController,
  });

  final Dictionary dictionary;
  final Function(bool) setScrollUpBtnVisibility;
  final bool isScrollUpBtnVisible;
  final ScrollController scrollController;

  @override
  State<WordsPage> createState() => _WordsPageState();
}

class _WordsPageState extends State<WordsPage> {
  TextEditingController textEditingController = TextEditingController(text: "");
  late List<Word> filteredWords;
  late List<Word> searchedWords;
  bool isSearchStrict = false;
  late List<FilterData> levelFilters;
  late List<FilterData> typeFilters;
  late List<FilterData> genderFilters;
  bool isFiltersContainerExpanded = false;

  @override
  void initState() {
    filteredWords = widget.dictionary.allWords;
    searchedWords = filteredWords;
    levelFilters = getFilterDataFromEnumValues(WordLevel.values);
    typeFilters = getFilterDataFromEnumValues(WordType.values);
    genderFilters = getFilterDataFromEnumValues(WordGender.values);
    super.initState();
  }

// TODO: Add grid layout
  @override
  Widget build(BuildContext context) {
    return widget.dictionary.allWordsCount == 0
        ? noWordsWidget()
        : SingleChildScrollView(
            controller: widget.scrollController,
            padding: EdgeInsets.all(Sizes.mainPaddingMobile),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: Sizes.wordsPageVerticalSpacing,
              children: [
                // Search input
                SearchWordsTextFieldWidget(
                  toggleSearchMode: toggleSearchMode,
                  isSearchStrict: isSearchStrict,
                  textEditingController: textEditingController,
                  clearSearch: clearSearch,
                  onSearchTextChange: onSearchTextChange,
                ),

                // Open/hide filters btn
                VisibilityDetector(
                  key: Key("vd_scroll_up_btn_dict_page"),
                  onVisibilityChanged: (info) {
                    if (widget.isScrollUpBtnVisible &&
                        info.visibleFraction > 0) {
                      widget.setScrollUpBtnVisibility(false);
                    } else if (!widget.isScrollUpBtnVisible &&
                        info.visibleFraction <= 0) {
                      widget.setScrollUpBtnVisibility(true);
                    }
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: CustomOutlinedButtonWidget(
                      padding: 4,
                      onPressed: () {
                        setState(() {
                          isFiltersContainerExpanded =
                              !isFiltersContainerExpanded;
                        });
                      },
                      child: Icon(
                        isFiltersContainerExpanded
                            ? Icons.arrow_drop_up_rounded
                            : Icons.arrow_drop_down_rounded,
                      ),
                    ),
                  ),
                ),

                // Filters container
                FiltersContainerWidget(
                  levelFilters: levelFilters,
                  typeFilters: typeFilters,
                  genderFilters: genderFilters,
                  isExpanded: isFiltersContainerExpanded,
                ),

                // If no results are there
                if (searchedWords.isEmpty) noWordsWidget(),

                // Words list
                ...List.generate(searchedWords.length, (index) {
                  Word word = searchedWords[index];
                  return WordCardWidget(
                    word: word,
                    onDelete: () {
                      setState(() {
                        widget.dictionary.deleteWord(word);
                        filteredWords.remove(word);
                        searchedWords.remove(word);
                      });
                    },
                  );
                }),
              ],
            ),
          );
  }

  // Filter methods
  void filterWords() {
    applyFilters();
    search();
  }

  void applyFilters() {
    var iterable = widget.dictionary.allWords.nonNulls;
    List<WordType> selectedTypes = typeFilters
        .where(isFilterSelected)
        .map((e) => e.value as WordType)
        .toList();
    List<WordLevel> selectedLevels = levelFilters
        .where(isFilterSelected)
        .map((e) => e.value as WordLevel)
        .toList();
    List<WordGender> selectedGenders = genderFilters
        .where(isFilterSelected)
        .map((e) => e.value as WordGender)
        .toList();

    if (selectedLevels.isNotEmpty &&
        selectedLevels.length != levelFilters.length) {
      iterable = iterable.where((w) => selectedLevels.contains(w.level));
    }

    if (selectedTypes.isNotEmpty &&
        selectedTypes.length != typeFilters.length) {
      iterable = iterable.where((w) => selectedTypes.contains(w.type));
    }

    if (selectedGenders.isNotEmpty) {
      iterable = iterable.where((w) => selectedGenders.contains(w.gender));
    }

    filteredWords = iterable.toList();
  }

  bool isFilterSelected(FilterData d) {
    return d.selected;
  }

  // Search methods

  void onSearchTextChange(String value) {
    setState(() {
      textEditingController.text = value;
      search();
    });
  }

  void toggleSearchMode() {
    setState(() {
      isSearchStrict = !isSearchStrict;
      search();
    });
  }

  void clearSearch() {
    if (textEditingController.text.trim().isNotEmpty) {
      setState(() {
        onSearchTextChange("");
      });
    }
  }

  void search() {
    String searchText = textEditingController.text.trim();
    if (searchText.isEmpty) {
      searchedWords = filteredWords;
      return;
    }

    List<Word> updatedSearchedWords = [];
    for (Word word in filteredWords) {
      if (word.containsString(searchText, isSearchStrict)) {
        updatedSearchedWords.add(word);
      }
    }
    searchedWords = updatedSearchedWords;
  }

  //

  List<FilterData> getFilterDataFromEnumValues(List<LocalizedToString> values) {
    return List.generate(values.length, (index) {
      var value = values[index];
      return FilterData(
        value.toLocalizedString(appLangNotifier.value),
        value,
        false,
        () => setState(() => filterWords()),
      );
    });
  }

  Widget noWordsWidget() {
    return Padding(
      padding: const EdgeInsets.all(Sizes.mainPaddingMobile),
      child: Center(
        child: Text(
          KStrings.getStringsForLang(appLangNotifier.value).noWords,
          style: TextStyle(
            color: ThemeColors.getThemeColors(context).emptyPageText,
            fontSize: Sizes.emptyPageFontSize,
            fontWeight: Sizes.emptyPageFontWeight,
          ),
        ),
      ),
    );
  }
}
