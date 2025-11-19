import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/schema/enums/word_gender.dart';
import 'package:lexivo_flutter/schema/enums/word_level.dart';
import 'package:lexivo_flutter/schema/enums/word_type.dart';
import 'package:lexivo_flutter/schema/word/word.dart';
import 'package:lexivo_flutter/util/filter_data_util.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';
import 'package:lexivo_flutter/views/widgets/components/binary_selection_switch_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/btns/custom_filled_button_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/word_filters/word_filters_container_widget.dart';

class PracticeSetupPage extends StatefulWidget {
  const PracticeSetupPage({super.key});

  @override
  State<PracticeSetupPage> createState() => _PracticeSetupPageState();
}

class _PracticeSetupPageState extends State<PracticeSetupPage> {
  late final levelFilters = getFilterDataFromEnumValues(
    WordLevel.values,
    _onFilterChanged,
  );
  late final typeFilters = getFilterDataFromEnumValues(
    WordType.values,
    _onFilterChanged,
  );
  late final genderFilters = getFilterDataFromEnumValues(
    WordGender.values,
    _onFilterChanged,
  );
  late final colors = ThemeColors.getThemeColors(context);
  final strings = KStrings.getStringsForLang(appLangNotifier.value);
  late final commonTextStyle = TextStyle(color: colors.mainText);
  bool directionDescToWord = false;
  bool modeTest = false;

  @override
  Widget build(BuildContext context) {
    final safeArea = MediaQuery.of(context).padding;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          Sizes.mainPadding,
          Sizes.mainPadding,
          Sizes.mainPadding,
          Sizes.mainPadding + safeArea.bottom,
        ),
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Filters container
            WordFiltersContainerWidget(
              levelFilters: levelFilters,
              typeFilters: typeFilters,
              genderFilters: genderFilters,
              static: true,
            ),

            // Direction selector
            BinarySelectionSwitchWidget(
              leftWidget: Flexible(
                child: Text(
                  strings.wordToDesc,
                  textAlign: TextAlign.end,
                  style: commonTextStyle,
                ),
              ),
              rightWidget: Flexible(
                child: Text(strings.descToWord, style: commonTextStyle),
              ),
              onSwitched: () => directionDescToWord = !directionDescToWord,
            ),

            // Mode selector
            BinarySelectionSwitchWidget(
              leftWidget: Flexible(
                child: Text(
                  strings.practice,
                  textAlign: TextAlign.end,
                  style: commonTextStyle,
                ),
              ),
              rightWidget: Flexible(
                child: Text(strings.test, style: commonTextStyle),
              ),
              onSwitched: () => modeTest = !modeTest,
            ),

            // Start button
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: Sizes.widgetMaxWidth),
              child: SizedBox(
                width: double.infinity,
                child: CustomFilledButtonWidget(
                  onPressed: onStart,
                  padding: 16,
                  elevation: true,
                  backgroundColor: colors.accent,
                  child: Text(
                    strings.startPracticeBtnText,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: colors.contrastPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onFilterChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  List<Word> getFilteredWords() {
    // TODO implement
    return [];
  }

  void onStart() {
    final words = getFilteredWords();
    // TODO: navigate to the practice or the test page and pass the words
  }
}
