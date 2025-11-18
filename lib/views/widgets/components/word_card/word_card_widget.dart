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
    final colors = ThemeColors.getThemeColors(context);

    return CustomFilledButtonWidget(
      borderRadius: Sizes.borderRadius_1,
      outlined: true,
      padding: 16,
      backgroundColor: colors.canvas,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                AddWordPage(dictionary: dictionary, word: word),
          ),
        ).then((_) => updateState());
      },
      child: Column(
        spacing: Sizes.wordsCardVerticalSpacingLoose,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Info content
          WordCardInfoContent(word: word),

          // Main content
          WordCardMainContent(word: word),

          // Delete btn row
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Delete btn
              CustomFilledButtonWidget(
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => DeleteDialogWidget(onDelete: onDelete),
                ),
                backgroundColor: colors.deleteBtn,
                child: Text(
                  KStrings.getStringsForLang(appLangNotifier.value).delete,
                  style: TextStyle(color: colors.contrastPrimary),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// boxShadow: [
//             BoxShadow(
//               blurRadius: Sizes.shadowBlurRadius,
//               color: ThemeColors.getThemeColors(context).listItemBg,
//               spreadRadius: Sizes.shadowSpreadRadius,
//             ),
//           ],
