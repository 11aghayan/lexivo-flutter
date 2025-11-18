import 'package:flutter/material.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/schema/enums/word_gender.dart';
import 'package:lexivo_flutter/schema/word/word.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';

class WordCardInfoContent extends StatelessWidget {
  const WordCardInfoContent({super.key, required this.word});

  final Word word;

  @override
  Widget build(BuildContext context) {
    final fontSize = 16.0;
    final fontWeight = FontWeight.w600;

    return Row(
      spacing: 4,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          word.type.toLocalizedString(appLangNotifier.value),
          style: TextStyle(
            color: ThemeColors.getThemeColors(context).secondary,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),

        if (word.gender != null && word.gender != WordGender.NO_GENDER)
          Text(
            word.gender?.toLocalizedString(appLangNotifier.value) ?? "",
            style: TextStyle(
              color: ThemeColors.getWordGenderColor(word.gender!),
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
          ),

        Text(
          word.level.toLocalizedString(appLangNotifier.value),
          style: TextStyle(
            color: ThemeColors.getThemeColors(context).mainText,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
      ],
    );
  }
}
