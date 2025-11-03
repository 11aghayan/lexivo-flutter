import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';
import 'package:lexivo_flutter/views/widgets/components/btns/custom_filled_button_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/btns/custom_outlined_button_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/text_field/custom_text_field_widget.dart';

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
  bool disabled = false;

  @override
  void initState() {
    disabled = widget.twoStepDeleteText != null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(Sizes.mainPadding),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.maxFinite,
                constraints: BoxConstraints(maxWidth: Sizes.dialogMaxWidth),
                padding: EdgeInsets.all(Sizes.dialogInnerPadding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Sizes.borderRadius_1),
                  color: Theme.of(context).canvasColor,
                ),
                child: ValueListenableBuilder(
                  valueListenable: appLangNotifier,
                  builder: (context, appLang, child) {
                    return Column(
                      spacing: Sizes.dialogVerticalSpacing,
                      children: [
                        // Title
                        Text(
                          KStrings.getStringsForLang(appLang).deleteDialogTitle,
                          style: TextStyle(
                            color: ThemeColors.getThemeColors(context).mainText,
                            fontSize: Sizes.fontSizeDialogTitle,
                            fontWeight: Sizes.fontWeightDialogTitle,
                          ),
                        ),

                        // Two factor check input
                        if (widget.twoStepDeleteText != null)
                          CustomTextFieldWidget(
                            onChanged: (value) {
                              if (value.trim() == widget.twoStepDeleteText) {
                                setState(() {
                                  disabled = false;
                                });
                              } else {
                                setState(() {
                                  disabled = true;
                                });
                              }
                            },
                            hint: KStrings.getStringsForLang(
                              appLangNotifier.value,
                            ).twoStepDelete(widget.twoStepDeleteText!),
                          ),

                        // Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          spacing: Sizes.dialogHorizontalSpacing,
                          children: [
                            // Button Delete
                            CustomFilledButtonWidget(
                              onPressed: disabled
                                  ? null
                                  : () {
                                      widget.onDelete();
                                      Navigator.pop(context);
                                    },
                              disabled: disabled,
                              backgroundColor: ThemeColors.getThemeColors(
                                context,
                              ).deleteBtn,
                              child: Text(
                                KStrings.getStringsForLang(appLang).delete,
                                style: TextStyle(
                                  color: ThemeColors.getThemeColors(
                                    context,
                                  ).contrastPrimary,
                                ),
                              ),
                            ),

                            // Button Cancel
                            CustomOutlinedButtonWidget(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                KStrings.getStringsForLang(appLang).cancel,
                                style: TextStyle(
                                  color: ThemeColors.getThemeColors(
                                    context,
                                  ).mainText,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
