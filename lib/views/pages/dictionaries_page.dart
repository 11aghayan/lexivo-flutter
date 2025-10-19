import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/schema/dictionary.dart';
import 'package:lexivo_flutter/views/widgets/components/dictionar_card/dictionary_card_widget.dart';

class DictionariesPage extends StatefulWidget {
  const DictionariesPage({super.key});

  @override
  State<DictionariesPage> createState() => _DictionariesPageState();
}

class _DictionariesPageState extends State<DictionariesPage> {
  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(Sizes.mainPaddingMobile),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: getCrossAxisItemCount(),
        childAspectRatio: 1.8,
        mainAxisSpacing: Sizes.gridViewItemsSpacing,
        crossAxisSpacing: Sizes.gridViewItemsSpacing,
      ),

      children: List.generate(
        Dictionary.getAllDictionaries().length,
        (index) =>
            DictionaryCardWidget(dictionary: Dictionary.getDictionaryAt(index)),
      ),
    );
  }

  int getCrossAxisItemCount() {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth > 900 ? 3 : screenWidth > 600 ? 2 : 1;
  }
}
