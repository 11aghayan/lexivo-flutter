import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/schema/dictionary/dictionary.dart';
import 'package:lexivo_flutter/schema/language/language.dart';
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
  final Function(Dictionary) deleteDictionary;

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
      onLongPress: rotate,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return DictPageWidgetTree(dictionary: widget.dictionary);
            },
          ),
        ).then((_) => _updateState());
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
              color: ThemeColors.getThemeColors(context).shadow,
              spreadRadius: Sizes.shadowSpreadRadius,
            ),
          ],
          image: DecorationImage(
            image: AssetImage(widget.dictionary.language.photoPath),
            fit: BoxFit.fill,
          ),
        ),
        child: isRotated
            ? DictionaryCardBackFaceWidget(
                dictionary: widget.dictionary,
                updateDictionary: widget.updateDictionary,
                deleteDictionary: () {
                  widget.deleteDictionary(widget.dictionary);
                  rotate();
                },
              )
            : DictionaryCardFrontFaceWidget(dictionary: widget.dictionary),
      ),
    );
  }

  void rotate() async {
    scale = 0.8;
    _updateState();
    await Future.delayed(Duration(milliseconds: 50));

    scale = 1.0;
    _updateState();
    await Future.delayed(Duration(milliseconds: 40));

    rotationInRadians = (rotationInRadians * -1) - getRadiansFromDegree(180);
    _updateState();

    Timer(Duration(milliseconds: (animationDuration / 2).toInt()), () {
      isRotated = !isRotated;
      _updateState();
    });
  }

  void _updateState() {
    if (!mounted) return;
    setState(() {});
  }
}
