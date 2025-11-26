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
  bool isAnimationOn = false;
  Color bgColor = Colors.transparent;
  int key = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleWidgets: titleWidgets),
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              // Swipe responsive bg
              AnimatedContainer(
                duration: Duration(milliseconds: isAnimationOn ? 200 : 0),
                color: bgColor,
                width: double.infinity,
                height: double.infinity,
              ),

              // Start again button
              Center(
                child: CustomFilledButtonWidget(
                  onPressed: resetCardStack,
                  foregroundColor: colors.contrastPrimary,
                  child: Text(strings.startAgain),
                ),
              ),

              // Flip card stack
              FlipCardStackWidget(
                key: ValueKey(key),
                words: widget.words,
                directionDescToWord: widget.directionDescToWord,
                setBgGreenOpacity: setBgGreenOpacity,
                setBgRedOpacity: setBgRedOpacity,
              ),
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

  void setBgRedOpacity(double opacity, bool animated) {
    _toggleAnimated(animated);
    opacity = opacity > 0.7 ? 0.7 : opacity;
    bgColor = Color.fromRGBO(200, 70, 70, opacity);
    _updateState();
  }

  void setBgGreenOpacity(double opacity, bool animated) {
    _toggleAnimated(animated);
    opacity = opacity > 0.5 ? 0.5 : opacity;
    bgColor = Color.fromRGBO(70, 200, 70, opacity);
    _updateState();
  }

  void _toggleAnimated(bool animated) {
    if (animated != isAnimationOn) {
      isAnimationOn = animated;
      _updateState();
    }
  }

  _updateState() {
    if (!mounted) return;
    setState(() {});
  }
}
