import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/schema/deletable_interface.dart';
import 'package:lexivo_flutter/schema/dictionary.dart';
import 'package:lexivo_flutter/schema/language.dart';
import 'package:lexivo_flutter/util/math_util.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';
import 'package:lexivo_flutter/views/widgets/components/dictionar_card/dictionary_card_back_face_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/dictionar_card/dictionary_card_front_face_widget.dart';
import 'package:lexivo_flutter/views/widgets/dict_page_widget_tree.dart';

class DictionaryCardWidget extends StatefulWidget {
  const DictionaryCardWidget({
    super.key,
    required this.dictionary,
    required this.updateDictionary,
    required this.deleteDictionary,
  });

  final Dictionary dictionary;
  final Function(Dictionary, Language) updateDictionary;
  final Function(Deletable) deleteDictionary;

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
      onLongPress: () async {
        setState(() => scale = 0.8);
        await Future.delayed(Duration(milliseconds: 50));

        setState(() => scale = 1.0);
        await Future.delayed(Duration(milliseconds: 40));

        setState(() {
          rotationInRadians =
              (rotationInRadians * -1) - getRadiansFromDegree(180);
        });

        Timer(Duration(milliseconds: (animationDuration / 2).toInt()), () {
          setState(() {
            isRotated = !isRotated;
          });
        });
      },
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return DictPageWidgetTree(dictionary: widget.dictionary);
            },
          ),
        );
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: animationDuration),
        transformAlignment: Alignment.center,
        transform: Matrix4.identity()
          ..scaleAdjoint(scale)
          ..rotateX(rotationInRadians),
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.borderRadius_1),
          boxShadow: [
            BoxShadow(
              blurRadius: Sizes.shadowBlurRadius,
              color: ThemeColors.getThemeColors(context).cardBorder,
              spreadRadius: Sizes.shadowSpreadRadius,
            ),
          ],
          // border: Border.all(width: 1.5, color: ThemeColors.getThemeColors(context).cardBorderColor),
          image: DecorationImage(
            image: AssetImage(widget.dictionary.language.photoPath),
            fit: BoxFit.fill,
          ),
        ),
        child: isRotated
            ? DictionaryCardBackFaceWidget(
                dictionary: widget.dictionary,
                updateDictionary: widget.updateDictionary,
                deleteDictionary: widget.deleteDictionary,
              )
            : DictionaryCardFrontFaceWidget(dictionary: widget.dictionary),
      ),
    );
  }
}
