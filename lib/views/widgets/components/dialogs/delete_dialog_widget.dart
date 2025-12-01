import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';
import 'package:lexivo_flutter/views/widgets/components/btns/custom_filled_button_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/btns/custom_outlined_button_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/dialogs/dialog_skeleton_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/text_field/custom_text_field_widget.dart';

/// A confirmation dialog widget used to confirm destructive "delete" actions.
///
/// This widget displays a centered dialog with a localized title, an optional
/// two-step confirmation input, and action buttons for "Delete" and "Cancel".
/// It integrates with the app's theming, sizing and localization helpers and
/// uses custom button and text field widgets.
///
/// Behavior:
/// - If [twoStepDeleteText] is provided, the dialog shows a text field and the
///   "Delete" button is initially disabled. The button becomes enabled only
///   when the trimmed input exactly equals [twoStepDeleteText].
/// - Pressing the "Delete" button invokes [onDelete] and then closes the
///   dialog (Navigator.pop).
/// - Pressing the "Cancel" button simply closes the dialog (Navigator.pop).
/// - Localization is read from a ValueListenable (appLangNotifier) so labels and
///   hints update with the app language.
///
/// Parameters:
/// - [twoStepDeleteText] (optional): The exact string the user must enter to
///   enable deletion. Comparison ignores leading/trailing whitespace but is
///   otherwise exact (case-sensitive).
/// - [onDelete] (required): Callback invoked when the user confirms deletion.
///
/// Notes:
/// - The widget relies on external helpers (ThemeColors, Sizes, KStrings,
///   appLangNotifier) and custom UI components (CustomTextFieldWidget,
///   CustomFilledButtonWidget, CustomOutlinedButtonWidget).
/// - Intended to be presented via showDialog / Navigator overlays.
class DeleteDialogWidget extends StatefulWidget {
  const DeleteDialogWidget({
    super.key,
    this.twoStepDeleteText,
    required this.onDelete,
  });

  final String? twoStepDeleteText;
  final Function() onDelete;

  @override
  State<DeleteDialogWidget> createState() => _DeleteDialogWidgetState();
}

class _DeleteDialogWidgetState extends State<DeleteDialogWidget> {
  late final colors = ThemeColors.getThemeColors(context);
  final strings = KStrings.getStringsForLang(appLangNotifier.value);
  late bool disabled = widget.twoStepDeleteText != null;

  @override
  Widget build(BuildContext context) {
    return DialogSkeletonWidget(
      child: Column(
        spacing: Sizes.dialogVerticalSpacing,
        children: [
          // Title
          Text(
            strings.deleteDialogTitle,
            style: TextStyle(
              color: colors.mainText,
              fontSize: Sizes.fontSizeDialogTitle,
              fontWeight: Sizes.fontWeightDialogTitle,
            ),
          ),

          // Two factor check input
          if (widget.twoStepDeleteText != null)
            CustomTextFieldWidget(
              onChanged: (value) {
                if (value.trim() == widget.twoStepDeleteText) {
                  disabled = false;
                } else {
                  disabled = true;
                }
                if (mounted) {
                  setState(() {});
                }
              },
              hint: strings.twoStepDelete(widget.twoStepDeleteText!),
            ),

          // Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: Sizes.dialogHorizontalSpacing,
            children: [
              // Button Delete
              CustomFilledButtonWidget(
                onPressed: () {
                  widget.onDelete();
                  Navigator.pop(context);
                },
                disabled: disabled,
                backgroundColor: colors.deleteBtn,
                child: Text(
                  strings.delete,
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
