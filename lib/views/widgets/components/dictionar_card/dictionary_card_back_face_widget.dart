import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/schema/dictionary/dictionary.dart';
import 'package:lexivo_flutter/schema/language/language.dart';
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
  final void Function() deleteDictionary;

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.getThemeColors(context);
    final strings = KStrings.getStringsForLang(appLangNotifier.value);
    final iconColorDark = colors.dictionaryIconBtn;

    return Container(
      transformAlignment: Alignment.center,
      transform: Matrix4.identity()
        ..rotateY(getRadiansFromDegree(180))
        ..rotateZ(getRadiansFromDegree(180)),
      padding: EdgeInsets.all(Sizes.cardInnerPadding),
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: colors.canvas,
        borderRadius: BorderRadius.circular(Sizes.borderRadius_1),
      ),
      child: Column(
        children: [
          Text(
            Strings.toCapitalized(dictionary.language.nameOriginal),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: colors.mainText,
            ),
          ),
          Divider(),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              spacing: 16,
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
                IntrinsicHeight(
                  child: CustomFilledButtonWidget(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          final viewInsets = MediaQuery.of(context).viewInsets;
                          return Padding(
                            padding: EdgeInsets.only(bottom: viewInsets.bottom),
                            child: DeleteDialogWidget(
                              onDelete: deleteDictionary,
                              twoStepDeleteText:
                                  "${strings.delete.toLowerCase()} ${dictionary.language.nameOriginal}",
                            ),
                          );
                        },
                      );
                    },
                    backgroundColor: colors.deleteBtn,
                    child: Icon(
                      Icons.delete_forever_rounded,
                      size: iconSize,
                      color: colors.contrastPrimary,
                    ),
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
