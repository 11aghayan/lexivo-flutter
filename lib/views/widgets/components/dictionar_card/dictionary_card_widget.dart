import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/schema/dictionary.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';
import 'package:lexivo_flutter/views/widgets/components/dictionar_card/dictionary_card_back_face_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/dictionar_card/dictionary_card_front_face_widget.dart';

class DictionaryCardWidget extends StatefulWidget {
  const DictionaryCardWidget({super.key, required this.dictionary});

  final Dictionary dictionary;

  @override
  State<DictionaryCardWidget> createState() => _DictionaryCardWidgetState();
}

class _DictionaryCardWidgetState extends State<DictionaryCardWidget> {
  final int animationDuration = 200;

  bool isRotated = false;
  double rotationInRadians = 0;
  double scale = 1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        // TODO: Add scale change
        setState(() {
          rotationInRadians =
              (rotationInRadians * -1) - getRotationRadiansFromDegree(180);
        });
        Timer(Duration(milliseconds: (animationDuration / 2).toInt()), () {
          setState(() {
            isRotated = !isRotated;
          });
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: animationDuration),
        transformAlignment: Alignment.center,
        transform: Matrix4.rotationX(rotationInRadians),
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.borderRadius_1),
          boxShadow: [BoxShadow(blurRadius: Sizes.cardShadowBlurRadius, color: ThemeColors.getThemeColors(context).cardBorderColor, spreadRadius: Sizes.cardShadowSpreadRadius)],
          // border: Border.all(width: 1.5, color: ThemeColors.getThemeColors(context).cardBorderColor),
          image: DecorationImage(
            image: AssetImage(widget.dictionary.language.photoPath),
            fit: BoxFit.fill,
          ),
        ),
        child: isRotated
            ? DictionaryCardBackFaceWidget(dictionary: widget.dictionary)
            : DictionaryCardFrontFaceWidget(dictionary: widget.dictionary),
      ),
    );
  }

  double getRotationRadiansFromDegree(double degree) {
    return degree * math.pi / 180;
  }
}
