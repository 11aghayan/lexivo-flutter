import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/schema/grammar/grammar_submenu.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';

class GrammarSubmenuContainer extends StatelessWidget {
  const GrammarSubmenuContainer({super.key, required this.submenu});

  final GrammarSubmenu submenu;

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.getThemeColors(context);
    final strings = KStrings.getStringsForLang(appLangNotifier.value);
    final paddingVertical = 4.0;
    final paddingHorizontal = 12.0;
    final backgroundColor = colors.canvas;
    final foregroundColor = colors.mainText;
    final shape = RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(Sizes.borderRadius_2),
        side: BorderSide(color: colors.outlinedBtnBorder)
      );

    return ExpansionTile(
      title: Text(submenu.header),
      textColor: foregroundColor,
      iconColor: foregroundColor,
      backgroundColor: backgroundColor,
      collapsedBackgroundColor: backgroundColor,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      tilePadding: EdgeInsets.symmetric(
        horizontal: paddingHorizontal,
        vertical: paddingVertical,
      ),
      childrenPadding: EdgeInsets.all(8),
      collapsedShape: shape,
      shape: shape,
      children: [
        ...generateListTiles(
          context,
          strings.explanations,
          submenu.explanations,
        ),
        ...generateListTiles(context, strings.examples, submenu.examples),
      ],
    );
  }

  List<Widget> generateListTiles(
    BuildContext context,
    String header,
    List<String> data,
  ) {
    if (data.isEmpty) return [];
    final colors = ThemeColors.getThemeColors(context);
    return [
      Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(
          header,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: colors.secondary,
          ),
          textAlign: TextAlign.start,
        ),
      ),
      ...List.generate(
        data.length,
        (index) => ListTile(
          title: Text(data[index], maxLines: 10),
          textColor: colors.mainText,
          titleTextStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          shape: Border(bottom: BorderSide(width: 1, color: colors.outlinedBtnBorder)),
        ),
      ),
    ];
  }
}
