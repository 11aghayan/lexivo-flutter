import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/schema/dictionary/dictionary.dart';
import 'package:lexivo_flutter/util/json_util.dart';
import 'package:lexivo_flutter/util/snackbar_util.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';
import 'package:lexivo_flutter/views/widgets/components/btns/custom_filled_button_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/btns/custom_outlined_button_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/dialogs/dialog_skeleton_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/dialogs/warning_dialog_widget.dart';

class DictUploadDialogWidget extends StatelessWidget {
  const DictUploadDialogWidget({super.key, required this.dict});

  final Dictionary dict;

  @override
  Widget build(BuildContext context) {
    final strings = KStrings.getStringsForLang(appLangNotifier.value);
    final colors = ThemeColors.getThemeColors(context);

    return DialogSkeletonWidget(
      child: Column(
        spacing: 8,
        children: [
          // Title
          Text(
            strings.dictUploadOptionQuestion,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Sizes.fontSizeDialogTitle,
              color: colors.mainText,
              fontWeight: Sizes.fontWeightDialogTitle,
            ),
          ),

          // Spacing
          SizedBox(height: 10),

          Row(
            spacing: 8,
            children: [
              // Button Export
              Expanded(
                child: CustomFilledButtonWidget(
                  onPressed: () => export(context),
                  foregroundColor: colors.contrastPrimary,
                  child: Text(strings.exportAsJson),
                ),
              ),

              // Button Upload to cloud
              Expanded(
                child: CustomOutlinedButtonWidget(
                  onPressed: () => onUpload(context),
                  borderColor: colors.primary,
                  foregroundColor: colors.primary,
                  child: Text(strings.uploadToCloud),
                ),
              ),
            ],
          ),

          Row(
            children: [
              // Button Cancel
              Expanded(
                child: CustomOutlinedButtonWidget(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    strings.cancel,
                    style: TextStyle(color: colors.mainText),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void onUpload(context) {
    showDialog(
      context: context,
      builder: (context) => WarningDialogWidget(
        title: KStrings.getStringsForLang(
          appLangNotifier.value,
        ).dictionaryUploadWarning,
      ),
    ).then((confirmed) async {
      if (confirmed) {
        await upload(context);
      }
    });
  }

  Future<void> upload(context) async {
    // TODO: Show Loader
    // TODO: Wait for the response;
    // TODO: If response ok show snackbar success
    // TODO: Else show snackbar failure

    // TODO: Replace
    showInfoSnackbar(context: context, text: "Not implemented");
    Navigator.pop(context);
  }

  void export(context) async {
    final strings = KStrings.getStringsForLang(appLangNotifier.value);
    
    try {
      bool canceled = await exportJsonData(
        data: dict,
        filename:
            "${strings.dictionary.toLowerCase()}_${dict.language.nameOriginal}_${KStrings.appName.toLowerCase()}",
      );
      if (!canceled) {
        showOperationResultSnackbar(
          context: context,
          text: strings.dictionaryExportedSuccessfully,
          isSuccess: true,
        );
      }
    } catch (e) {
      print(e);

      showOperationResultSnackbar(
        context: context,
        text: strings.dictionaryCouldNotBeExported,
        isSuccess: false,
      );
    } finally {
      Navigator.pop(context);
    }
  }
}
