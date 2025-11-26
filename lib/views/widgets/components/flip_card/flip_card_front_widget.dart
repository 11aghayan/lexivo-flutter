import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
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

    String mainText = directionDescToWord
        ? word.desc!
        : (word.native ?? word.plural!);
    String? details = directionDescToWord ? word.descDetails : word.nativeDetails;

    return Container(
      padding: EdgeInsets.all(Sizes.flipCardPadding),
      child: Column(
        spacing: Sizes.flipCardVerticalSpacing,
        children: [
          // Word info row
          WordCardInfoContent(word: word, hideGender: true),

          // Divider 
          CustomDividerWidget(),

          Expanded(
            child: Center(
              child: Column(
                spacing: Sizes.flipCardVerticalSpacing,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Main text
                  Text(
                    mainText,
                    style: TextStyle(
                      color: colors.mainText,
                      fontSize: Sizes.flipCardMainTextFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // Divider
                  if (details != null) CustomDividerWidget(),

                  // Details
                  if (details != null)
                    Text(
                      details,
                      style: TextStyle(
                        color: colors.secondary,
                        fontSize: Sizes.flipCardDetailsTextFontSize,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
