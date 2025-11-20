import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/schema/word/word.dart';
import 'package:lexivo_flutter/views/widgets/components/app_bars/app_bar_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/flip_card/flip_card_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/lang_flag_title.dart';

class PracticePage extends StatelessWidget {
  const PracticePage({
    super.key,
    required this.words,
    required this.directionDescToWord,
    required this.flagPhotoPath,
  });

  final List<Word> words;
  final bool directionDescToWord;
  final String flagPhotoPath;

  @override
  Widget build(BuildContext context) {
    final strings = KStrings.getStringsForLang(appLangNotifier.value);
    final titleWidgets = [
      LangFlagTitle(photoPath: flagPhotoPath),
      Text(strings.practice),
    ];

    return Scaffold(
      appBar: AppBarWidget(titleWidgets: titleWidgets),
      body: SafeArea(
        child: Center(
          child: FlipCardWidget(),
        ),
      ),
    );
  }
}
