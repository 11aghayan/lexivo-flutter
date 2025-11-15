import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';
import 'package:lexivo_flutter/views/widgets/components/btns/custom_outlined_button_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/text_field/custom_text_field_widget.dart';

/// A widget that displays and manages a list of editable text fields with a label.
///
/// This widget creates a container with a list of text fields that can be dynamically
/// added or removed. Each text field represents a row of data that can be edited.
///
/// Parameters:
/// * [data] - A list of strings that will be displayed in the text fields
/// * [label] - The text label displayed at the top of the container
/// * [canBeEmpty] - Whether the list can be empty (defaults to false)
///
/// Features:
/// * Dynamically add new rows with the '+' button
/// * Delete existing rows with the 'x' button (if more than one row exists or [canBeEmpty] is true)
/// * Edit text in each row
/// * Automatically updates the provided [data] list when changes occur
///
/// The widget maintains its state using [StatefulWidget] and updates the UI
/// accordingly when rows are added, removed, or edited.
class GrammarSubmenuDataContainer extends StatefulWidget {
  const GrammarSubmenuDataContainer({
    super.key,
    required this.data,
    required this.label,
    this.canBeEmpty = false,
  });

  final List<String> data;
  final String label;
  final bool canBeEmpty;

  @override
  State<GrammarSubmenuDataContainer> createState() =>
      _GrammarSubmenuDataContainerState();
}

class _GrammarSubmenuDataContainerState
    extends State<GrammarSubmenuDataContainer> {
  late ThemeColors colors = ThemeColors.getThemeColors(context);
  late KStrings strings = KStrings.getStringsForLang(appLangNotifier.value);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.borderRadius_2),
        color: colors.scaffoldBg,
        border: Border.all(color: colors.outlinedBtnBorder, width: 1),
      ),

      child: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label
          Text(widget.label),

          // Data
          ...List.generate(widget.data.length, (index) {
            String dataRow = widget.data[index];
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 4,
              children: [
                Expanded(
                  child: CustomTextFieldWidget(
                    onChanged: (String value) => onTextChange(value, index),
                    borderRadius: Sizes.borderRadius_3,
                    initialValue: dataRow,
                    hint: "${strings.row} ${index + 1}",
                  ),
                ),

                if (widget.data.length > 1 || widget.canBeEmpty)
                  IconButton(
                    onPressed: () => onRowDelete(index),
                    icon: Icon(Icons.close, color: colors.deleteBtn),
                  ),
              ],
            );
          }),

          // Add row button
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomOutlinedButtonWidget(
                onPressed: onAddRow,
                padding: 16,
                borderRadius: Sizes.borderRadius_3,
                child: Icon(Icons.add_rounded),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void onTextChange(String value, int index) {
    widget.data[index] = value;
  }

  void onRowDelete(int index) {
    widget.data.removeAt(index);
    if (mounted) {
      setState(() {});
    }
  }

  void onAddRow() {
    widget.data.add("");
    if (mounted) {
      setState(() {});
    }
  }
}
