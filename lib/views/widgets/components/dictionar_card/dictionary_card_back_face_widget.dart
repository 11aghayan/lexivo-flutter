import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/schema/deletable_interface.dart';
import 'package:lexivo_flutter/schema/dictionary.dart';
import 'package:lexivo_flutter/schema/language.dart';
import 'package:lexivo_flutter/util/math_util.dart';
import 'package:lexivo_flutter/util/string_util.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';
import 'package:lexivo_flutter/views/widgets/components/btns/custom_filled_button_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/btns/custom_outlined_button_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/dialogs/add_dict_dialog_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/dialogs/delete_dialog_widget.dart';

class DictionaryCardBackFaceWidget extends StatelessWidget {
  const DictionaryCardBackFaceWidget({
    super.key,
    required this.dictionary,
    required this.updateDictionary,
    required this.deleteDictionary,
  });

  final Dictionary dictionary;
  final double iconSize = 32;
  final Function(Dictionary, Language) updateDictionary;
  final Function(Deletable) deleteDictionary;

  @override
  Widget build(BuildContext context) {
    Color iconColorDark = ThemeColors.getThemeColors(context).dictionaryIconBtn;

    return Container(
      transformAlignment: Alignment.center,
      transform: Matrix4.identity()
        ..rotateY(getRadiansFromDegree(180))
        ..rotateZ(getRadiansFromDegree(180)),
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
                CustomOutlinedButtonWidget(
                  onPressed: () {
                    Navigator.push(
                      context,
                      DialogRoute(
                        context: context,
                        builder: (context) {
                          return AddDictDialogWidget(
                            dictionary: dictionary,
                            updateDictionary: updateDictionary,
                          );
                        },
                      ),
                    );
                  },
                  child: Icon(Icons.edit, size: iconSize, color: iconColorDark),
                ),

                // Icon UPLOAD
                CustomOutlinedButtonWidget(
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
                CustomOutlinedButtonWidget(
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
                CustomFilledButtonWidget(
                  onPressed: () {
                    Navigator.push(
                      context,
                      DialogRoute(
                        context: context,
                        builder: (context) {
                          return DeleteDialogWidget(
                            onDelete: () => deleteDictionary(dictionary),
                            twoStepDeleteText:
                                "${KStrings.getStringsForLang(appLangNotifier.value).delete.toLowerCase()} ${dictionary.language.nameOriginal}",
                          );
                        },
                      ),
                    );
                  },
                  backgroundColor: ThemeColors.getThemeColors(
                    context,
                  ).deleteBtn,
                  child: Icon(
                    Icons.delete_forever_rounded,
                    size: iconSize,
                    color: ThemeColors.getThemeColors(context).contrastPrimary,
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
