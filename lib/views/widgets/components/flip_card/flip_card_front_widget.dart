import 'package:flutter/material.dart';
import 'package:lexivo_flutter/schema/word/word.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';
import 'package:lexivo_flutter/views/widgets/components/custom_divider_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/word_card/word_card_info_content.dart';

class FlipCardFrontWidget extends StatelessWidget {
  const FlipCardFrontWidget({
    super.key,
    required this.word,
    required this.directionDescToWord,
  });

  final Word word;
  final bool directionDescToWord;

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.getThemeColors(context);

    String w = directionDescToWord ? word.desc! : (word.native ?? word.plural!);
    String? wd = directionDescToWord ? word.descDetails : word.nativeDetails;

    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        spacing: 8,
        children: [
          WordCardInfoContent(word: word, hideGender: true),
          CustomDividerWidget(),
          Expanded(
            child: Center(
              child: Column(
                spacing: 4,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(w, style: TextStyle(color: colors.mainText, fontSize: 24, fontWeight: FontWeight.bold)),
                  if (wd != null) CustomDividerWidget(),
                  if (wd != null) Text(wd, style: TextStyle(color: colors.secondary, fontSize: 18),),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
