import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/schema/dictionary/dictionary.dart';
import 'package:lexivo_flutter/schema/word/word.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';
import 'package:lexivo_flutter/views/widgets/components/add_word_components/add_word_body.dart';
import 'package:lexivo_flutter/views/widgets/components/app_bars/app_bar_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/app_bars/side_app_bar_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/lang_flag_title.dart';

class AddWordPage extends StatelessWidget {
  const AddWordPage({super.key, required this.dictionary, this.word});

  final Dictionary dictionary;
  final Word? word;

  @override
  Widget build(BuildContext context) {
    final strings = KStrings.getStringsForLang(appLangNotifier.value);
    final colors = ThemeColors.getThemeColors(context);
    List<Widget> titleWidgets = [
      LangFlagTitle(photoPath: dictionary.language.photoPath),
      AutoSizeText(
        strings.addWordPageLabel,
        maxLines: 2,
        minFontSize: 16,
        softWrap: true,
        textAlign: TextAlign.center,
        style: TextStyle(color: colors.contrastPrimary),
      ),
    ];
    bool isOrientationLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: isOrientationLandscape
          ? null
          : AppBarWidget(titleWidgets: titleWidgets),
      body: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (isOrientationLandscape)
            SideAppBarWidget(titleWidgets: titleWidgets),
          Expanded(child: AddWordBody(word: word,)),
        ],
      ),
    );
  }
}
