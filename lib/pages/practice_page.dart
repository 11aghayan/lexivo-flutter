import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/schema/word/word.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';
import 'package:lexivo_flutter/views/widgets/components/app_bars/app_bar_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/btns/custom_filled_button_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/flip_card/flip_card_stack_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/lang_flag_title.dart';

class PracticePage extends StatefulWidget {
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
  State<PracticePage> createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
  late final strings = KStrings.getStringsForLang(appLangNotifier.value);
  late final colors = ThemeColors.getThemeColors(context);
  late final titleWidgets = [
    LangFlagTitle(photoPath: widget.flagPhotoPath),
    Text(strings.practice),
  ];
  int key = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleWidgets: titleWidgets),
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              // Start again button
              Center(
                child: CustomFilledButtonWidget(
                  onPressed: resetCardStack,
                  foregroundColor: colors.contrastPrimary,
                  child: Text(strings.startAgain),
                ),
              ),

              // Flip card stack
              FlipCardStackWidget(key: ValueKey(key), words: widget.words),
            ],
          ),
        ),
      ),
    );
  }

  void resetCardStack() {
    key++;
    _updateState();
  }

  _updateState() {
    if (!mounted) return;
    setState(() {});
  }
}
