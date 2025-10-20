import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
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
        SizedBox(
          height: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.all(Sizes.cardInnerPadding),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(Sizes.borderRadius_1),
                  ),
                ),
                child: ValueListenableBuilder(
                  valueListenable: appLangNotifier,
                  builder: (context, appLang, child) {
                    return Text(
                      "${KStrings.getStringsForLang(appLang).words} : ${dictionary.allWordsCount}",
                      style: TextStyle(
                        color: ThemeColors.getThemeColors(
                          context,
                        ).contrastPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
