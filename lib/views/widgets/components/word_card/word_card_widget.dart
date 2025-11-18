import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/pages/add_word_page.dart';
import 'package:lexivo_flutter/schema/dictionary/dictionary.dart';
import 'package:lexivo_flutter/schema/word/word.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';
import 'package:lexivo_flutter/views/widgets/components/btns/custom_filled_button_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/dialogs/delete_dialog_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/word_card/word_card_info_content.dart';
import 'package:lexivo_flutter/views/widgets/components/word_card/word_card_main_content.dart';

class WordCardWidget extends StatelessWidget {
  const WordCardWidget({
    super.key,
    required this.word,
    required this.onDelete,
    required this.dictionary,
    required this.updateState,
  });

  final Word word;
  final void Function() onDelete;
  final void Function() updateState;
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      radius: Sizes.borderRadius_1,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                AddWordPage(dictionary: dictionary, word: word),
          ),
        ).then((_) => updateState());
      },
      child: Container(
        padding: EdgeInsets.all(Sizes.mainPadding),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(Sizes.borderRadius_1),
          boxShadow: [
            BoxShadow(
              blurRadius: Sizes.shadowBlurRadius,
              color: ThemeColors.getThemeColors(context).listItemBg,
              spreadRadius: Sizes.shadowSpreadRadius,
            ),
          ],
        ),
        child: Column(
          spacing: Sizes.wordsCardVerticalSpacingLoose,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WordCardInfoContent(word: word),
            WordCardMainContent(word: word),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomFilledButtonWidget(
                  onPressed: () {
                    Navigator.push(
                      context,
                      DialogRoute(
                        context: context,
                        builder: (context) =>
                            DeleteDialogWidget(onDelete: onDelete),
                      ),
                    );
                  },
                  backgroundColor: ThemeColors.getThemeColors(
                    context,
                  ).deleteBtn,
                  child: Text(
                    KStrings.getStringsForLang(appLangNotifier.value).delete,
                    style: TextStyle(
                      color: ThemeColors.getThemeColors(
                        context,
                      ).contrastPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
