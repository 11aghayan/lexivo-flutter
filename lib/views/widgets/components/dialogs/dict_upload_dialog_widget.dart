import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/schema/dictionary/dictionary.dart';
import 'package:lexivo_flutter/util/export_import_json.dart';
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
            // TODO: Update text
            "Do you want to export the dictionary as a JSON file or upload to the cloud?",
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
                  // TODO: Update text
                  child: Text("Export as JSON"),
                ),
              ),

              // Button Upload to cloud
              Expanded(
                child: CustomOutlinedButtonWidget(
                  onPressed: () => onUpload(context),
                  borderColor: colors.primary,
                  foregroundColor: colors.primary,
                  // TODO: Update text
                  child: Text("Upload to cloud"),
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
      builder: (context) =>
          // TODO: Update text
          WarningDialogWidget(
            onConfirm: () => upload(context),
            title: "UPLOAD WARNING",
          ),
    );
  }

  upload(context) async {
    // TODO: Show a dialog and tell the user that all data on the server will be overriden with the one on the device; if the user agrees continue;
    // TODO: Wait for the response;
    // TODO: If response ok show snackbar success
    // TODO: Else show snackbar failure

    // TODO: Replace
    showInfoSnackbar(context: context, text: "Not implemented");
    Navigator.pop(context);
  }

  void export(context) async {
    final strings = KStrings.getStringsForLang(appLangNotifier.value);
    // TODO: Update text
    try {
      bool canceled = await exportJsonData(
        data: dict,
        filename: "dict_${dict.language.nameOriginal}",
      );
      if (!canceled) {
        // TODO: Update text
        showOperationResultSnackbar(
          context: context,
          text: "SUCCESS",
          isSuccess: true,
        );
      }
    } catch (e) {
      print(e);
      // TODO: Update text
      showOperationResultSnackbar(
        context: context,
        text: "FAILURE",
        isSuccess: false,
      );
    } finally {
      Navigator.pop(context);
    }
  }
}
