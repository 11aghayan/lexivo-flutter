import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/schema/interface/deletable_interface.dart';
import 'package:lexivo_flutter/schema/dictionary.dart';
import 'package:lexivo_flutter/schema/language.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';
import 'package:lexivo_flutter/views/widgets/components/dictionar_card/dictionary_card_widget.dart';

class DictionariesPage extends StatelessWidget {
  const DictionariesPage({
    super.key,
    required this.updateDictionary,
    required this.deleteDictionary,
  });

  final Function(Dictionary, Language) updateDictionary;
  final Function(Deletable) deleteDictionary;

  @override
  Widget build(BuildContext context) {
    return Dictionary.dictionariesCount > 0
        ? GridView(
            padding: const EdgeInsets.all(Sizes.mainPadding),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 500,
              childAspectRatio: 1.8,
              mainAxisSpacing: Sizes.gridViewItemsSpacing,
              crossAxisSpacing: Sizes.gridViewItemsSpacing,
            ),

            children: List.generate(
              Dictionary.dictionariesCount,
              (index) => DictionaryCardWidget(
                dictionary: Dictionary.getDictionaryAt(index),
                updateDictionary: updateDictionary,
                deleteDictionary: deleteDictionary,
              ),
            ),
          )
        : Center(
            child: ValueListenableBuilder(
              valueListenable: appLangNotifier,
              builder: (context, appLang, child) {
                return Text(
                  KStrings.getStringsForLang(appLang).noDictionaries,
                  style: TextStyle(
                    color: ThemeColors.getThemeColors(context).emptyPageText,
                    fontSize: Sizes.emptyPageFontSize,
                    fontWeight: Sizes.emptyPageFontWeight,
                  ),
                );
              },
            ),
          );
  }
}
