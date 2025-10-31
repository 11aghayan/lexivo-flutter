import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/data/filter_data.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/schema/dictionary.dart';
import 'package:lexivo_flutter/schema/interface/localized_to_string_interface.dart';
import 'package:lexivo_flutter/schema/enums/word_gender.dart';
import 'package:lexivo_flutter/schema/enums/word_level.dart';
import 'package:lexivo_flutter/schema/enums/word_type.dart';
import 'package:lexivo_flutter/schema/word.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';
import 'package:lexivo_flutter/views/widgets/components/text_field/search_words_text_field_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/word_card/word_card_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/word_filters/filters_container_widget.dart';

class WordsPage extends StatefulWidget {
  const WordsPage({
    super.key,
    required this.dictionary,
    required this.isScrollUpBtnVisible,
    required this.scrollController,
  });

  final Dictionary dictionary;
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

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: widget.scrollController,
      semanticChildCount: 2,
      slivers: [
        // Search and filter elements
        SliverPadding(
          padding: EdgeInsets.all(Sizes.mainPadding),
          sliver: SliverToBoxAdapter(
            child: Column(
              spacing: 8,
              children: [
                // Search input
                SearchWordsTextFieldWidget(
                  toggleSearchMode: toggleSearchMode,
                  isSearchStrict: isSearchStrict,
                  textEditingController: textEditingController,
                  clearSearch: clearSearch,
                  onSearchTextChange: onSearchTextChange,
                ),

                // Filters container
                FiltersContainerWidget(
                  toggleExpanded: toggleFiltersContainer,
                  levelFilters: levelFilters,
                  typeFilters: typeFilters,
                  genderFilters: genderFilters,
                  isExpanded: isFiltersContainerExpanded,
                ),

                // If no results are there
                if (searchedWords.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(Sizes.mainPadding),
                    child: Center(
                      child: Text(
                        KStrings.getStringsForLang(
                          appLangNotifier.value,
                        ).noWords,
                        style: TextStyle(
                          color: ThemeColors.getThemeColors(
                            context,
                          ).emptyPageText,
                          fontSize: Sizes.emptyPageFontSize,
                          fontWeight: Sizes.emptyPageFontWeight,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),

        // Words grid view
        SliverPadding(
          padding: EdgeInsets.all(Sizes.mainPadding),
          sliver: SliverMasonryGrid.extent(
            maxCrossAxisExtent: 500,
            crossAxisSpacing: Sizes.wordsPageGridSpacing,
            mainAxisSpacing: Sizes.wordsPageGridSpacing,
            childCount: searchedWords.length,
            itemBuilder: (context, index) {
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
            },
          ),
        ),
      ],
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
        onSearchTextChange("");
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

  List<FilterData> getFilterDataFromEnumValues(
    List<LocalizedToStringInterface> values,
  ) {
    return List.generate(values.length, (index) {
      var value = values[index];
      return FilterData(
        value.toLocalizedString(appLangNotifier.value),
        value,
        false,
        _onFilterChanged,
      );
    });
  }

  void _onFilterChanged() {
    setState(() {
      filterWords();
    });
  }

  void toggleFiltersContainer() {
    setState(() {
      isFiltersContainerExpanded = !isFiltersContainerExpanded;
    });
  }
}
