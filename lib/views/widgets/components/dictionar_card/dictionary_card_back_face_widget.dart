import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/schema/dictionary.dart';
import 'package:lexivo_flutter/util/math_util.dart';
import 'package:lexivo_flutter/util/string_util.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';
import 'package:lexivo_flutter/views/widgets/components/outlined_icon_button.dart';

class DictionaryCardBackFaceWidget extends StatelessWidget {
  const DictionaryCardBackFaceWidget({super.key, required this.dictionary});

  final Dictionary dictionary;
  final double iconSize = 32;

  @override
  Widget build(BuildContext context) {
    Color iconColorDark = ThemeColors.getThemeColors(context).dictionaryIconBtnColor;

    Matrix4 matrix = Matrix4.identity();
    matrix.rotateY(getRadiansFromDegree(180));
    matrix.rotateZ(getRadiansFromDegree(180));

    return Container(
      transformAlignment: Alignment.center,
      transform: matrix,
      padding: EdgeInsets.all(Sizes.cardInnerPadding),
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(Sizes.borderRadius_1),
      ),
      child: Column(
        children: [
          Text(
              Strings.toCapitalized(dictionary.language.nameOriginal),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: ThemeColors.getThemeColors(context).mainText,
              ),
            ),
          Divider(),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              spacing: 4,
              children: [
                // Icon EDIT
                OutlinedIconButton(
                  onPressed: () {
                    // TODO: Add edit dictionary func
                  },
                  child: Icon(
                    Icons.edit,
                    size: iconSize,
                    color: iconColorDark,
                  ),
                ),

                // Icon UPLOAD
                OutlinedIconButton(
                  onPressed: () {
                    // TODO: Add upload dict func
                  },
                  child: Icon(
                    Icons.file_upload_outlined,
                    size: iconSize,
                    color: iconColorDark,
                  ),
                ),

                // Icon DOWNLOAD
                OutlinedIconButton(
                  onPressed: () {
                    // TODO: Add download dict func
                  },
                  child: Icon(
                    Icons.cloud_download_outlined,
                    size: iconSize,
                    color: iconColorDark,
                  ),
                ),

                // Icon DELETE
                OutlinedIconButton(
                  onPressed: () {
                    // TODO: Add download dict func
                  },
                  child: Icon(
                    Icons.delete_forever_rounded,
                    size: iconSize,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
