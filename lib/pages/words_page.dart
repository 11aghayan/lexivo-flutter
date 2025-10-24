import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/schema/word.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';
import 'package:lexivo_flutter/views/widgets/components/word_card_widget.dart';

class WordsPage extends StatelessWidget {
  const WordsPage({super.key, required this.words});

  final List<Word> words;

  @override
  Widget build(BuildContext context) {
    return words.isEmpty
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
            child: Column(
              children: [
                ...List.generate(words.length, (index) {
                  return WordCardWidget();
                }),
              ],
            ),
          );
  }
}
