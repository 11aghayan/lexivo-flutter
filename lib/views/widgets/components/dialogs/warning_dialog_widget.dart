import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';
import 'package:lexivo_flutter/views/widgets/components/btns/custom_filled_button_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/btns/custom_outlined_button_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/dialogs/dialog_skeleton_widget.dart';

class WarningDialogWidget extends StatefulWidget {
  const WarningDialogWidget({
    super.key,
    required this.onConfirm,
    required this.title,
  });

  final Function() onConfirm;
  final String title;

  @override
  State<WarningDialogWidget> createState() => _WarningDialogWidgetState();
}

class _WarningDialogWidgetState extends State<WarningDialogWidget> {
  late final colors = ThemeColors.getThemeColors(context);
  final strings = KStrings.getStringsForLang(appLangNotifier.value);
  // TODO: Update color
  final warningIcon = Icon(Icons.warning_rounded, color: Colors.deepOrange);

  @override
  Widget build(BuildContext context) {
    return DialogSkeletonWidget(
      child: Column(
        spacing: Sizes.dialogVerticalSpacing,
        children: [
          // Title
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8,
            children: [
              warningIcon,

              // Title
              Text(
                // TODO: Update text
                "WARNING",
                style: TextStyle(
                  color: colors.mainText,
                  fontSize: 22,
                  fontWeight: Sizes.fontWeightDialogTitle,
                ),
              ),

              warningIcon,
            ],
          ),

          Text(
            widget.title,
            style: TextStyle(
              color: colors.mainText,
              fontSize: Sizes.fontSizeDialogTitle,
              fontWeight: Sizes.fontWeightDialogTitle,
            ),
          ),

          // Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: Sizes.dialogHorizontalSpacing,
            children: [
              // Button Confirm
              CustomFilledButtonWidget(
                onPressed: () {
                  widget.onConfirm();
                  Navigator.pop(context);
                },
                // TODO: Update Color
                backgroundColor: Colors.deepOrange,
                child: Text(
                  // TODO: Update text
                  "CONFIRM",
                  style: TextStyle(color: colors.contrastPrimary),
                ),
              ),

              // Button Cancel
              CustomOutlinedButtonWidget(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  strings.cancel,
                  style: TextStyle(color: colors.mainText),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
