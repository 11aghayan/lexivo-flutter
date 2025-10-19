import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/schema/dictionary.dart';
import 'package:lexivo_flutter/util/string_util.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';

class DictionaryCardFrontFaceWidget extends StatelessWidget {
  const DictionaryCardFrontFaceWidget({super.key, required this.dictionary});

  final Dictionary dictionary;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black54,
            border: Border.all(width: 1, color: ThemeColors.getThemeColors(context).secondary),
            borderRadius: BorderRadius.circular(Sizes.borderRadius_1),
          ),
        ),
        Center(
          child: Text(
            Strings.toCapitalized(dictionary.language.nameOriginal),
            style: TextStyle(
              color: ThemeColors.getThemeColors(context).contrastPrimary,
              fontSize: 32,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
