import 'package:flutter/material.dart';
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
    required this.isExpanded,
  });

  final List<FilterData> levelFilters;
  final List<FilterData> typeFilters;
  final List<FilterData> genderFilters;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: isExpanded ? 253 : 0,
      duration: Duration(milliseconds: 200),
      padding: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: ThemeColors.getThemeColors(context).filterNotSelected,
          ),
        ),
      ),
      child: Column(
        spacing: 8,
        children: [
          // Level filter
          HorizontalScrollingFiltersWidget(
            header: KStrings.getStringsForLang(
              appLangNotifier.value,
            ).levelFiltersHeader,
            items: levelFilters,
          ),

          // Type filter
          HorizontalScrollingFiltersWidget(
            header: KStrings.getStringsForLang(
              appLangNotifier.value,
            ).levelFiltersHeader,
            items: typeFilters,
          ),

          // Gender filter
          HorizontalScrollingFiltersWidget(
            header: KStrings.getStringsForLang(
              appLangNotifier.value,
            ).genderFiltersHeader,
            items: genderFilters,
          ),
        ],
      ),
    );
  }
}
