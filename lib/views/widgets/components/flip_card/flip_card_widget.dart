import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/schema/word/word.dart';
import 'package:lexivo_flutter/util/math_util.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';
import 'package:lexivo_flutter/views/widgets/components/flip_card/flip_card_back_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/flip_card/flip_card_front_widget.dart';

class FlipCardWidget extends StatefulWidget {
  const FlipCardWidget({
    super.key,
    required this.word,
    required this.switchCard,
    required this.isActive,
    required this.directionDescToWord,
    required this.setBgRedOpacity,
    required this.setBgGreenOpacity,
  });

  final Word word;
  final void Function() switchCard;
  final void Function(double, bool) setBgRedOpacity;
  final void Function(double, bool) setBgGreenOpacity;
  final bool isActive;
  final bool directionDescToWord;

  @override
  State<FlipCardWidget> createState() => _FlipCardWidgetState();
}

class _FlipCardWidgetState extends State<FlipCardWidget> {
  late final colors = ThemeColors.getThemeColors(context);
  late final frontWidget = FlipCardFrontWidget(
    word: widget.word,
    directionDescToWord: widget.directionDescToWord,
  );
  late final backWidget = FlipCardBackWidget(word: widget.word);
  final animationDuration = 150;
  final cardPadding = 10.0;
  late Widget child = frontWidget;
  late double scaleFactor = 1;
  late var screenSize = MediaQuery.of(context).size;
  late final biggestScreenSize = max(screenSize.width, screenSize.height);
  bool noAnimation = false;
  double flipDegree = 0.0;
  bool isFlipped = false;
  double translateX = 0;

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: isFlipped || !widget.isActive ? null : flip,
      onHorizontalDragStart: !isFlipped ? null : onSwipeStart,
      onHorizontalDragEnd: !widget.isActive || !isFlipped ? null : onSwipeEnd,
      onHorizontalDragUpdate: !isFlipped ? null : onSwipeUpdate,
      child: AnimatedContainer(
        duration: Duration(milliseconds: noAnimation ? 0 : animationDuration),
        transformAlignment: Alignment.center,
        transform: Matrix4.identity()
          ..scaleAdjoint(scaleFactor)
          ..rotateY(getRadiansFromDegree(flipDegree))
          ..translateByDouble(translateX, 0, 0, 1),
        height: min(500, screenSize.height - 120),
        width: min(350, screenSize.width - (Sizes.mainPadding * 2) - 40),
        padding: EdgeInsets.all(cardPadding),
        decoration: BoxDecoration(
          color: colors.canvas,
          borderRadius: BorderRadius.circular(Sizes.borderRadius_1),
          border: Border.all(width: 1, color: colors.outlinedBtnBorder),
        ),
        child: SizedBox(child: child),
      ),
    );
  }

  void flip() async {
    // Flipping first half and scaling down
    isFlipped = true;
    flipDegree = 90;
    scaleFactor = 0.9;
    _updateState();

    // Updating the content
    await Future.delayed(Duration(milliseconds: animationDuration));
    noAnimation = true;
    child = backWidget;
    flipDegree = -90;
    _updateState();

    // Flipping the remaining half and scaling up
    noAnimation = false;
    flipDegree = 0;
    scaleFactor = 1;
    _updateState();
  }

  void onSwipeStart(DragStartDetails details) {
    noAnimation = true;
  }

  void onSwipeUpdate(DragUpdateDetails details) {
    final dx = details.delta.dx;
    translateX += dx;
    var bgOpacity = translateX.abs() / 360;
    if (translateX > 0) {
      widget.setBgGreenOpacity(bgOpacity, false);
    } else {
      widget.setBgRedOpacity(bgOpacity, false);
    }
  }

  void onSwipeEnd(DragEndDetails details) async {
    noAnimation = false;
    double velocity = details.velocity.pixelsPerSecond.dx;
    if (velocity.abs() > 2000 || translateX.abs() > 180) {
      if (translateX > 0) {
        swipeRight();
      } else {
        swipeLeft();
      }
      await Future.delayed(Duration(milliseconds: animationDuration));
      widget.switchCard();
    } else {
      bringBack();
    }
  }

  void swipeLeft() {
    widget.word.resetPracticeCountdown();
    translateX = -biggestScreenSize - 10;
    widget.setBgRedOpacity(0, true);
  }

  void swipeRight() {
    widget.word.decrementPracticeCountdown();
    translateX = biggestScreenSize + 10;
    widget.setBgGreenOpacity(0, true);
  }

  void bringBack() {
    widget.setBgGreenOpacity(0, true);
    translateX = 0;
  }

  void _updateState() {
    if (!mounted) return;
    setState(() {});
  }
}
