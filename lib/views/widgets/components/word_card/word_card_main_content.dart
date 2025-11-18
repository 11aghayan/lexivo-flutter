import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/schema/word/word.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';
import 'package:lexivo_flutter/views/widgets/components/custom_divider_widget.dart';

class WordCardMainContent extends StatelessWidget {
  const WordCardMainContent({super.key, required this.word});

  final Word word;

  @override
  Widget build(BuildContext context) {
    final verticalSpacingTight = 4.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: Sizes.wordsCardVerticalSpacingLoose,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: verticalSpacingTight,
          children: textData(context, [
            word.native,
            word.nativeDetails,
            word.plural,
            word.past1,
            word.past2,
          ]),
        ),
        CustomDividerWidget(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: verticalSpacingTight,
          children: textData(context, [word.desc, word.descDetails]),
        ),
      ],
    );
  }

  List<Widget> textData(BuildContext context, List<String?> stringList) {
    List<Text> data = [];
    var colors = ThemeColors.getThemeColors(context);

    for (int i = 0; i < stringList.length; i++) {
      String? str = stringList[i];
      if (str == null) continue;
      bool secondItem = i == 1;
      data.add(
        Text(
          secondItem ? "($str)" : str,
          softWrap: true,
          style: TextStyle(
            color: secondItem ? colors.secondary : colors.mainText,
            fontSize: secondItem ? 14 : 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    return data;
  }
}
