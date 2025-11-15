import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/schema/dictionary/dictionary.dart';
import 'package:lexivo_flutter/schema/language/language.dart';
import 'package:lexivo_flutter/util/string_util.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';
import 'package:lexivo_flutter/views/widgets/components/btns/custom_filled_button_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/btns/custom_outlined_button_widget.dart';

/// A dialog widget that allows the user to add a new dictionary (language)
/// or edit the language of an existing dictionary.
///
/// Behavior
/// - Shows a title that changes depending on whether a `dictionary` was
///   provided (add vs. edit mode).
/// - Presents a dropdown of available languages (flag image + native name).
/// - Displays an inline error message if the user attempts to save without
///   selecting a language.
/// - Provides Cancel and Save actions. Cancel closes the dialog without
///   changes. Save validates the selection, invokes the provided callback,
///   and closes the dialog.
///
/// Constructor parameters
/// - `dictionary` (optional): When provided the dialog operates in edit mode
///   and pre-selects the dictionary's language.
/// - `addDictionary` (optional): Callback invoked when creating a new
///   dictionary. Receives the newly created `Dictionary`.
/// - `updateDictionary` (optional): Callback invoked when updating an existing
///   dictionary's language. Receives the original `Dictionary` and the newly
///   selected `Language`.
///
/// Implementation details
/// - The widget is stateful and stores:
///   - `selectedLanguage`: the currently chosen language in the dropdown,
///   - `showErrorMsg`: whether to show the validation error message,
///   - localized `strings` and theme `colors` for rendering.
/// - The dropdown is populated from `Language.allLanguagesList` and displays
///   each entry with its flag image and original language name.
/// - `handleSave()` enforces validation:
///   - If no language is selected, sets `showErrorMsg` to true and aborts.
///   - In edit mode, calls `updateDictionary` only if the language changed.
///   - In add mode, calls `addDictionary` with `Dictionary.create(selected)`.
///   - After invoking the appropriate callback the dialog is dismissed with
///     `Navigator.pop(context)`.
///
/// Notes
/// - The widget relies on application-specific types and helpers such as
///   `Language`, `Dictionary`, `KStrings`, `ThemeColors`, `Sizes`, and custom
///   button widgets; these must be defined elsewhere in the codebase.
/// - The dialog constrains its maximum width and uses theming to match the
///   surrounding UI.
class AddDictDialogWidget extends StatefulWidget {
  const AddDictDialogWidget({
    super.key,
    this.dictionary,
    this.addDictionary,
    this.updateDictionary,
  });

  final Dictionary? dictionary;
  final Function(Dictionary)? addDictionary;
  final Function(Dictionary, Language)? updateDictionary;

  @override
  State<AddDictDialogWidget> createState() => _AddDictDialogWidgetState();
}

class _AddDictDialogWidgetState extends State<AddDictDialogWidget> {
  final strings = KStrings.getStringsForLang(appLangNotifier.value);
  late ThemeColors colors = ThemeColors.getThemeColors(context);
  bool showErrorMsg = false;
  late Language? selectedLanguage = widget.dictionary?.language;

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
                constraints: BoxConstraints(maxWidth: Sizes.widgetMaxWidth),
                padding: EdgeInsets.all(Sizes.dialogInnerPadding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Sizes.borderRadius_1),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: Sizes.shadowBlurRadius,
                      color: colors.shadow,
                      spreadRadius: Sizes.shadowSpreadRadius,
                    ),
                  ],
                  color: colors.canvas,
                ),
                child: Column(
                  spacing: Sizes.dialogVerticalSpacing,
                  children: [
                    // Title
                    Text(
                      widget.dictionary == null
                          ? strings.addDictDialogTitle
                          : strings.editDictDialogTitle,
                      style: TextStyle(
                        color: colors.mainText,
                        fontSize: Sizes.fontSizeDialogTitle,
                        fontWeight: Sizes.fontWeightDialogTitle,
                      ),
                    ),

                    // Dropdown
                    Material(
                      child: DropdownButton<Language>(
                        value: selectedLanguage,
                        hint: Text(strings.addDictionaryDropdownHint),
                        menuMaxHeight: 300,
                        borderRadius: BorderRadius.circular(
                          Sizes.borderRadius_2,
                        ),
                        items: List.generate(Language.allLanguagesList.length, (
                          index,
                        ) {
                          Language lang = Language.allLanguagesList[index];
                          return DropdownMenuItem(
                            value: lang,
                            child: Row(
                              spacing: 12,
                              children: [
                                Image.asset(
                                  lang.photoPath,
                                  height: 25,
                                  width: 40,
                                ),
                                Text(Strings.toCapitalized(lang.nameOriginal)),
                              ],
                            ),
                          );
                        }),
                        onChanged: (newValue) {
                          showErrorMsg = false;
                          selectedLanguage = newValue;
                          if (mounted) {
                            setState(() {});
                          }
                        },
                      ),
                    ),

                    // Error Message
                    if (showErrorMsg)
                      Text(
                        strings.noDictSelectedError,
                        style: TextStyle(color: Colors.red),
                      ),

                    // Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      spacing: Sizes.dialogHorizontalSpacing,
                      children: [
                        // Button Cancel
                        CustomOutlinedButtonWidget(
                          onPressed: () => Navigator.pop(context),
                          child: Text(strings.cancel),
                        ),

                        // Button Delete
                        CustomFilledButtonWidget(
                          onPressed: handleSave,
                          child: Text(
                            strings.save,
                            style: TextStyle(color: colors.contrastPrimary),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void handleSave() {
    if (selectedLanguage == null) {
      showErrorMsg = true;
      if (mounted) {
        setState(() {});
      }
      return;
    }
    if (widget.dictionary != null) {
      if (widget.dictionary!.language != selectedLanguage) {
        widget.updateDictionary!(widget.dictionary!, selectedLanguage!);
      }
    } else {
      widget.addDictionary!(Dictionary.create(selectedLanguage!));
    }
    Navigator.pop(context);
  }
}
