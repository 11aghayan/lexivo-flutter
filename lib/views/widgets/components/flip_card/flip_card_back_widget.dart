import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/schema/word/word.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';
import 'package:lexivo_flutter/views/widgets/components/custom_divider_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/word_card/word_card_info_content.dart';

class FlipCardBackWidget extends StatelessWidget {
  const FlipCardBackWidget({super.key, required this.word});

  final Word word;

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.getThemeColors(context);
    final mainTextStyle = TextStyle(
      color: colors.mainText,
      fontSize: Sizes.flipCardMainTextFontSize,
      fontWeight: FontWeight.bold,
    );
    final secondaryTextStyle = TextStyle(
      color: colors.mainText,
      fontWeight: FontWeight.bold,
      fontSize: Sizes.flipCardSecondaryTextFontSize,
    );
    final detailsTextStyle = TextStyle(
      color: colors.secondary,
      fontSize: Sizes.flipCardDetailsTextFontSize,
    );

    return Container(
      padding: EdgeInsets.all(Sizes.flipCardPadding),
      child: Column(
        spacing: Sizes.flipCardVerticalSpacing,
        children: [
          // Word info row
          WordCardInfoContent(word: word),

          // Divider
          CustomDividerWidget(),

          Expanded(
            child: Center(
              child: Column(
                spacing: Sizes.flipCardVerticalSpacing,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Native
                  if (word.native != null)
                    Text(
                      word.native!,
                      textAlign: TextAlign.center,
                      style: mainTextStyle,
                    ),

                  // Plural
                  if (word.plural != null)
                    Text(
                      word.plural!,
                      textAlign: TextAlign.center,
                      style: word.native == null
                          ? mainTextStyle
                          : secondaryTextStyle,
                    ),

                  // Native details
                  if (word.nativeDetails != null)
                    Text(
                      word.nativeDetails!,
                      textAlign: TextAlign.center,
                      style: detailsTextStyle,
                    ),

                  // Past 1
                  if (word.past1 != null)
                    Text(
                      word.past1!,
                      textAlign: TextAlign.center,
                      style: secondaryTextStyle,
                    ),

                  // Past 2
                  if (word.past2 != null)
                    Text(
                      word.past2!,
                      textAlign: TextAlign.center,
                      style: secondaryTextStyle,
                    ),

                  // Divider
                  CustomDividerWidget(),

                  // Desc
                  Text(
                    word.desc!,
                    textAlign: TextAlign.center,
                    style: mainTextStyle,
                  ),

                  // Desc details
                  if (word.descDetails != null)
                    Text(
                      word.descDetails!,
                      textAlign: TextAlign.center,
                      style: detailsTextStyle,
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
