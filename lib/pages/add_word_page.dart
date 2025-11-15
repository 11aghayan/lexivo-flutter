import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/schema/dictionary/dictionary.dart';
import 'package:lexivo_flutter/schema/word/word.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';
import 'package:lexivo_flutter/views/widgets/components/add_word/add_word_body.dart';
import 'package:lexivo_flutter/views/widgets/components/app_bars/app_bar_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/app_bars/side_app_bar_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/dialogs/delete_dialog_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/lang_flag_title.dart';

class AddWordPage extends StatelessWidget {
  const AddWordPage({super.key, required this.dictionary, this.word});

  final Dictionary dictionary;
  final Word? word;

  @override
  Widget build(BuildContext context) {
    final strings = KStrings.getStringsForLang(appLangNotifier.value);
    final colors = ThemeColors.getThemeColors(context);
    final header = word == null
        ? strings.addWordPageLabel
        : strings.updateWordPageLabel;

    List<Widget> titleWidgets = [
      LangFlagTitle(photoPath: dictionary.language.photoPath),
      Text(
        header,
        textAlign: TextAlign.center,
        style: TextStyle(color: colors.contrastPrimary),
        maxLines: 2,
      ),
    ];
    bool isOrientationLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    Widget deleteBtn = IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) =>
              DeleteDialogWidget(onDelete: () => deleteWord(word!)),
        ).then((_) {
          if (context.mounted) {
            Navigator.pop(context);
          }
        });
      },
      icon: Icon(FontAwesomeIcons.trash, color: colors.deleteBtn),
    );

    return Scaffold(
      appBar: isOrientationLandscape
          ? null
          : AppBarWidget(
              titleWidgets: titleWidgets,
              actions: [if (word != null) deleteBtn],
            ),
      body: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (isOrientationLandscape)
            SideAppBarWidget(
              titleWidgets: titleWidgets,
              actions: [if (word != null) deleteBtn],
            ),
          Expanded(
            child: AddWordBody(
              word: word,
              saveInDictionary: word == null ? addWord : updateWord,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> addWord(Word word) async {
    dictionary.addWord(word);
    // TODO: Save to DB
  }

  Future<void> updateWord(Word word) async {
    dictionary.updateWord(word);
    // TODO: Update in DB
  }

  Future<void> deleteWord(Word word) async {
    dictionary.deleteWord(word);
    // TODO: Delete from DB
  }
}
