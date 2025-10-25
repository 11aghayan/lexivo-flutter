import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/schema/dictionary.dart';
import 'package:lexivo_flutter/schema/word.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';
import 'package:lexivo_flutter/views/widgets/components/word_card/word_card_widget.dart';

class WordsPage extends StatefulWidget {
  const WordsPage({super.key, required this.dictionary});

  final Dictionary dictionary;

  @override
  State<WordsPage> createState() => _WordsPageState();
}

class _WordsPageState extends State<WordsPage> {
  @override
  Widget build(BuildContext context) {
    return widget.dictionary.allWordsCount == 0
        ? Padding(
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
          )
        : SingleChildScrollView(
            padding: EdgeInsets.all(Sizes.mainPaddingMobile),
            child: Column(
              spacing: Sizes.wordsPageVerticalSpacing,
              children: [
                ...List.generate(widget.dictionary.allWordsCount, (index) {
                  Word word = widget.dictionary.allWords[index];
                  return WordCardWidget(
                    word: word,
                    onDelete: () {
                      setState(() {
                        widget.dictionary.deleteWord(word);
                      });
                    },
                  );
                }),
              ],
            ),
          );
  }
}
