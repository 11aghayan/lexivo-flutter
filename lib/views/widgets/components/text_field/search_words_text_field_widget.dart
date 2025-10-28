import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';
import 'package:lexivo_flutter/views/widgets/components/btns/custom_filled_button_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/text_field/custom_text_field_widget.dart';

class SearchWordsTextFieldWidget extends StatelessWidget {
  const SearchWordsTextFieldWidget({
    super.key,
    required this.toggleSearchMode,
    required this.isSearchStrict,
    required this.textEditingController,
    required this.clearSearch,
    required this.onSearchTextChange,
    this.borderColor
  });

  final Function() toggleSearchMode;
  final Function() clearSearch;
  final Function(String value) onSearchTextChange;
  final bool isSearchStrict;
  final TextEditingController textEditingController;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return CustomTextFieldWidget(
      label: KStrings.getStringsForLang(appLangNotifier.value).search,
      textEditingController: textEditingController,
      borderRadius: Sizes.borderRadius_1,
      borderColor: borderColor,
      icon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomFilledButtonWidget(
            onPressed: toggleSearchMode,
            backgroundColor: isSearchStrict
                ? ThemeColors.getThemeColors(context).searchModeBg
                : Colors.transparent,
            child: Icon(Icons.spellcheck_rounded),
          ),
          IconButton(
            onPressed: clearSearch,
            icon: textEditingController.text.trim().isEmpty
                ? Icon(Icons.search)
                : Icon(Icons.close_rounded),
          ),
        ],
      ),
      onChanged: onSearchTextChange,
    );
  }
}
