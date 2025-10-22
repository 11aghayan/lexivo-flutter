import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/schema/deletable_interface.dart';
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
            padding: const EdgeInsets.all(Sizes.mainPaddingMobile),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: getCrossAxisItemCount(context),
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
          child: Text("No Dictionaries", style: TextStyle(
            color: ThemeColors.getThemeColors(context).emptyPageText,
            fontSize: 18,
            fontWeight: FontWeight.w600
          ),),
        );
  }

  int getCrossAxisItemCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth > 900
        ? 3
        : screenWidth > 600
        ? 2
        : 1;
  }
}
