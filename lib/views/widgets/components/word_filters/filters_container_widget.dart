import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/data/filter_data.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';
import 'package:lexivo_flutter/views/widgets/components/word_filters/horizontal_scrolling_filters_widget.dart';

class FiltersContainerWidget extends StatelessWidget {
  const FiltersContainerWidget({
    super.key,
    required this.levelFilters,
    required this.typeFilters,
    required this.genderFilters,
  });

  final List<FilterData> levelFilters;
  final List<FilterData> typeFilters;
  final List<FilterData> genderFilters;
  final double padding = 12;
  final double verticalSpacing = 8;

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.getThemeColors(context);
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(Sizes.borderRadius_1),
      side: BorderSide(color: colors.outlinedBtnBorder, width: 1),
    );

    return ExpansionTile(
      collapsedShape: shape,
      shape: shape,
      iconColor: colors.mainText,
      //   Header
      title: Row(
        spacing: 4,
        children: [
          Icon(Icons.filter_list_rounded, color: colors.mainText),
          Text(
            KStrings.getStringsForLang(appLangNotifier.value).filters,
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
          header: KStrings.getStringsForLang(appLangNotifier.value).level,
          items: levelFilters,
        ),

        SizedBox(height: verticalSpacing),

        // Type filter
        HorizontalScrollingFiltersWidget(
          header: KStrings.getStringsForLang(appLangNotifier.value).type,
          items: typeFilters,
        ),

        SizedBox(height: verticalSpacing),

        // Gender filter
        HorizontalScrollingFiltersWidget(
          header: KStrings.getStringsForLang(appLangNotifier.value).gender,
          items: genderFilters,
        ),
      ],
    );
  }
}
