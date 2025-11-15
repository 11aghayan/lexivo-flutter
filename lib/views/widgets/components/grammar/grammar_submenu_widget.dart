import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/schema/grammar/grammar_submenu.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';
import 'package:lexivo_flutter/views/widgets/components/dialogs/delete_dialog_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/grammar/grammar_submenu_data_container_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/text_field/custom_text_field_widget.dart';

class GrammarSubmenuWidget extends StatefulWidget {
  const GrammarSubmenuWidget({
    super.key,
    required this.submenu,
    required this.deletable,
    required this.onDelete,
    required this.emptyHeaderError,
  });

  final GrammarSubmenu submenu;
  final bool deletable;
  final void Function() onDelete;
  final bool emptyHeaderError;

  @override
  State<GrammarSubmenuWidget> createState() => _GrammarSubmenuWidgetState();
}

class _GrammarSubmenuWidgetState extends State<GrammarSubmenuWidget> {
  late ThemeColors colors = ThemeColors.getThemeColors(context);
  late KStrings strings = KStrings.getStringsForLang(appLangNotifier.value);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: Sizes.widgetMaxWidth),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.borderRadius_1),
          color: colors.canvas,
          border: Border.all(width: 1, color: colors.outlinedBtnBorder),
        ),
        child: Column(
          spacing: 8,
          children: [
            // Header text
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: 48),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 4,
                children: [
                  Flexible(
                    child: Text(
                      widget.submenu.header.trim().isEmpty
                          ? strings.submenu
                          : widget.submenu.header,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: colors.secondary,
                      ),
                    ),
                  ),

                  // Delete button
                  if (widget.deletable)
                    IconButton(
                      onPressed: () {
                        if (widget.deletable) {
                          showDialog(
                            context: context,
                            builder: (context) =>
                                DeleteDialogWidget(onDelete: widget.onDelete),
                          );
                        }
                      },
                      icon: Icon(Icons.close, color: colors.deleteBtn),
                    ),
                ],
              ),
            ),

            // Header input
            CustomTextFieldWidget(
              onChanged: onHeaderTextChanged,
              initialValue: widget.submenu.header,
              error: widget.emptyHeaderError,
              label: strings.header,
            ),

            // Explanations
            GrammarSubmenuDataContainer(
              data: widget.submenu.explanations,
              label: strings.explanations,
            ),

            // Examples
            GrammarSubmenuDataContainer(
              data: widget.submenu.examples,
              label: strings.examples,
              canBeEmpty: true,
            ),
          ],
        ),
      ),
    );
  }

  void onHeaderTextChanged(String value) {
    widget.submenu.header = value;
    if (mounted) {
      setState(() {});
    }
  }
}
