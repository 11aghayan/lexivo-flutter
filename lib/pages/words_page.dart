import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/data/filter_data.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/db/db.dart';
import 'package:lexivo_flutter/schema/dictionary/dictionary.dart';
import 'package:lexivo_flutter/schema/enums/word_gender.dart';
import 'package:lexivo_flutter/schema/enums/word_level.dart';
import 'package:lexivo_flutter/schema/enums/word_type.dart';
import 'package:lexivo_flutter/schema/word/word.dart';
import 'package:lexivo_flutter/util/filter_data_util.dart';
import 'package:lexivo_flutter/views/widgets/components/no_data_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/text_field/search_words_text_field_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/word_card/word_card_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/word_filters/word_filters_container_widget.dart';

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
  late List<Word> filteredWords = widget.dictionary.allWords;
  late List<Word> searchedWords = filteredWords;
  bool isSearchStrict = false;
  late List<FilterData> levelFilters = getFilterDataFromEnumValues(
    WordLevel.values,
    _onFilterChanged,
  );
  late List<FilterData> typeFilters = getFilterDataFromEnumValues(
    WordType.values,
    _onFilterChanged,
  );
  late List<FilterData> genderFilters = getFilterDataFromEnumValues(
    WordGender.values,
    _onFilterChanged,
  );
  int renderNum = 0;

  @override
  void didUpdateWidget(covariant WordsPage oldWidget) {
    filterWords();
    super.didUpdateWidget(oldWidget);
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
                WordFiltersContainerWidget(
                  genderFilters: genderFilters,
                  levelFilters: levelFilters,
                  typeFilters: typeFilters,
                ),

                // If no results are there
                if (searchedWords.isEmpty)
                  NoDataWidget(
                    text: KStrings.getStringsForLang(
                      appLangNotifier.value,
                    ).noWords,
                  ),
              ],
            ),
          ),
        ),

        // Words grid view
        SliverPadding(
          padding: EdgeInsets.all(Sizes.mainPadding),
          sliver: SliverMasonryGrid.extent(
            maxCrossAxisExtent: Sizes.widgetMaxWidth,
            crossAxisSpacing: Sizes.gridViewItemsSpacing,
            mainAxisSpacing: Sizes.gridViewItemsSpacing,
            childCount: searchedWords.length,
            itemBuilder: (context, index) {
              Word word = searchedWords[index];
              return WordCardWidget(
                dictionary: widget.dictionary,
                word: word,
                updateState: () {
                  filterWords();
                  if (mounted) {
                    setState(() {});
                  }
                },
                onDelete: () => onDelete(word),
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

  void _onFilterChanged() {
    filterWords();
    _updateState();
  }

  // Search methods

  void onSearchTextChange(String value) {
    textEditingController.text = value;
    search();
    _updateState();
  }

  void toggleSearchMode() {
    isSearchStrict = !isSearchStrict;
    search();
    _updateState();
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

  void onDelete(Word word) async {
    widget.dictionary.deleteWord(word);
    filteredWords.remove(word);
    searchedWords.remove(word);
    await Db.getDb().word.deleteWord(word.id);
    _updateState();
  }

  void _updateState() {
    if (!mounted) return;
    setState(() {});
  }
}
