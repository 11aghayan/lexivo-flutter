import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/data/filter_data.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/util/string_util.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';
import 'package:lexivo_flutter/views/widgets/components/word_filters/horizontal_scrolling_filters_widget.dart';

class WordFiltersContainerWidget extends StatelessWidget {
  const WordFiltersContainerWidget({
    super.key,
    required this.levelFilters,
    required this.typeFilters,
    required this.genderFilters,
    this.static = false,
  });

  final bool static;
  final List<FilterData> levelFilters;
  final List<FilterData> typeFilters;
  final List<FilterData> genderFilters;

  @override
  Widget build(BuildContext context) {
    final double padding = 12;
    final double verticalSpacing = 8;
    final colors = ThemeColors.getThemeColors(context);
    final strings = KStrings.getStringsForLang(appLangNotifier.value);
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(Sizes.borderRadius_1),
      side: BorderSide(color: colors.outlinedBtnBorder, width: 1),
    );

    return ExpansionTile(
      collapsedShape: shape,
      shape: shape,
      initiallyExpanded: static,
      enabled: !static,
      showTrailingIcon: !static,
      iconColor: colors.mainText,
      //   Header
      title: Row(
        spacing: 4,
        children: [
          Icon(Icons.filter_list_rounded, color: colors.mainText),
          Text(
            strings.filters,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              color: colors.mainText,
            ),
          ),
        ],
      ),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      childrenPadding: EdgeInsets.all(padding),
      children: [
        // Level filter
        HorizontalScrollingFiltersWidget(
          header: strings.level,
          items: levelFilters,
        ),

        SizedBox(height: verticalSpacing),

        // Type filter
        HorizontalScrollingFiltersWidget(
          header: strings.type,
          items: typeFilters,
        ),

        SizedBox(height: verticalSpacing),

        // Gender filter
        HorizontalScrollingFiltersWidget(
          header: strings.gender,
          items: genderFilters
              .map(
                (f) => FilterData(
                  Strings.toCapitalized(f.label),
                  f.value,
                  f.selected,
                  f.updateState,
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
