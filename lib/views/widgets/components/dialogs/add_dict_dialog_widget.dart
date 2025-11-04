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
  Language? selectedLanguage;

  @override
  void initState() {
    selectedLanguage = widget.dictionary?.language;
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
                constraints: BoxConstraints(maxWidth: Sizes.dialogMaxWidth),
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
                          setState(() {
                            showErrorMsg = false;
                            selectedLanguage = newValue;
                          });
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
      setState(() {
        showErrorMsg = true;
      });
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
