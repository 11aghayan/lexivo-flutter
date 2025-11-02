import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/schema/interface/localized_to_string_interface.dart';
import 'package:lexivo_flutter/util/string_util.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';

class WordFieldDropdown extends StatelessWidget {
  const WordFieldDropdown({
    super.key,
    required this.setValue,
    required this.initialSelection,
    required this.entries,
    required this.label,
  });

  final void Function(String?) setValue;
  final String initialSelection;
  final List<LocalizedToStringInterface> entries;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.getThemeColors(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final padding = Sizes.mainPadding * 2;
        final effectiveWidth = constraints.maxWidth;
        final effectiveHeight = constraints.maxHeight - padding - MediaQuery.of(context).padding.bottom;

        return DropdownMenuFormField(
          label: Text(label),
          textStyle: TextStyle(color: colors.mainText),
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(
              color: colors.secondary,
              letterSpacing: 0.8,
              fontWeight: FontWeight.bold,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Sizes.borderRadius_2),
              borderSide: BorderSide(color: colors.searchTextFieldBorder),
            ),
          ),
          menuStyle: MenuStyle(
            backgroundColor: WidgetStatePropertyAll(colors.canvas),
            fixedSize: WidgetStatePropertyAll(
              Size(effectiveWidth, double.nan),
            ),
            maximumSize: WidgetStatePropertyAll(
              Size(constraints.maxWidth, effectiveHeight),
            ),
            padding: WidgetStatePropertyAll(EdgeInsets.all(0)),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Sizes.borderRadius_2),
              ),
            ),
          ),
          width: effectiveWidth,
          initialSelection: initialSelection,
          onSelected: setValue,
          textAlign: TextAlign.start,
          dropdownMenuEntries: List.generate(entries.length, (index) {
            LocalizedToStringInterface value = entries[index];
            return DropdownMenuEntry(
              value: value.toString(),
              label: Strings.toCapitalized(
                value.toLocalizedString(appLangNotifier.value),
              ),
            );
          }),
        );
      },
    );
  }
}
