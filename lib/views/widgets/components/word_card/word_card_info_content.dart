import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/schema/word.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';

class WordCardInfoContent extends StatelessWidget {
  const WordCardInfoContent({super.key, required this.word});

  final Word word;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          word.type.toLocalizedString(appLangNotifier.value),
          style: TextStyle(
            color: ThemeColors.getThemeColors(context).secondary,
            fontSize: Sizes.wordsCardInfoFontSize,
            fontWeight: Sizes.wordsCardInfoFontWeight,
          ),
        ),

        if (word.gender != null)
          Text(
            word.gender?.toLocalizedString(appLangNotifier.value) ?? "",
            style: TextStyle(
              color: ThemeColors.getWordGenderColor(word.gender!),
              fontSize: Sizes.wordsCardInfoFontSize,
              fontWeight: Sizes.wordsCardInfoFontWeight,
            ),
          ),

        Text(
          word.level.toLocalizedString(appLangNotifier.value),
          style: TextStyle(
            color: ThemeColors.getThemeColors(context).mainText,
            fontSize: Sizes.wordsCardInfoFontSize,
            fontWeight: Sizes.wordsCardInfoFontWeight,
          ),
        ),
      ],
    );
  }
}
