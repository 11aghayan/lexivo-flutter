import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/schema/grammar/grammar_submenu.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';
import 'package:lexivo_flutter/views/widgets/components/grammar/grammar_submenu_data_container_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/text_field/custom_text_field_widget.dart';

class GrammarSubmenuControlWidget extends StatefulWidget {
  const GrammarSubmenuControlWidget({
    super.key,
    required this.submenu,
    required this.deletable,
  });

  final GrammarSubmenu submenu;
  final bool deletable;

  @override
  State<GrammarSubmenuControlWidget> createState() =>
      _GrammarSubmenuControlWidgetState();
}

class _GrammarSubmenuControlWidgetState
    extends State<GrammarSubmenuControlWidget> {
  late ThemeColors colors = ThemeColors.getThemeColors(context);
  late KStrings strings = KStrings.getStringsForLang(appLangNotifier.value);

  bool isHeaderError = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.borderRadius_1),
        color: colors.canvas,
        border: Border.all(width: 1, color: colors.outlinedBtnBorder),
      ),
      child: Column(
        spacing: 8,
        children: [
          // Delete button
          ConstrainedBox(
            constraints: BoxConstraints(minHeight: 48),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 4,
              children: [
                // TODO: buggy
                AutoSizeText(
                  widget.submenu.header.trim().isEmpty
                      ? strings.submenu
                      : widget.submenu.header,
                  maxLines: 3,
                  wrapWords: true,
                  softWrap: true,
                  minFontSize: 12,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: colors.secondary,
                  ),
                ),

                if (widget.deletable)
                  IconButton(
                    onPressed: () {
                      // TODO: Delete with dialog
                    },
                    icon: Icon(Icons.close, color: colors.deleteBtn),
                  ),
              ],
            ),
          ),

          // Header
          CustomTextFieldWidget(
            onChanged: onHeaderTextChanged,
            initialValue: widget.submenu.header,
            error: isHeaderError,
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
    );
  }

  void onHeaderTextChanged(String value) {
    setState(() {
      widget.submenu.header = value;
    });
  }
}
