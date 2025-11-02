import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/data/filter_data.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';
import 'package:lexivo_flutter/views/widgets/components/btns/custom_filled_button_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/word_filters/horizontal_scrolling_filters_widget.dart';

class FiltersContainerWidget extends StatelessWidget {
  const FiltersContainerWidget({
    super.key,
    required this.levelFilters,
    required this.typeFilters,
    required this.genderFilters,
    required this.isExpanded,
    required this.toggleExpanded,
  });

  final List<FilterData> levelFilters;
  final List<FilterData> typeFilters;
  final List<FilterData> genderFilters;
  final bool isExpanded;
  final void Function() toggleExpanded;
  final double btnHeight = 47;
  final double padding = 12;

  @override
  Widget build(BuildContext context) {
    Color btnForegroundColor = ThemeColors.getThemeColors(context).mainText;

    return AnimatedContainer(
      height: isExpanded ? 308 : btnHeight,
      duration: Duration(milliseconds: 300),
      padding: EdgeInsets.fromLTRB(
        padding,
        padding,
        padding,
        isExpanded ? padding : 0,
      ),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: ThemeColors.getThemeColors(context).outlinedBtnBorder,
        ),
        borderRadius: BorderRadius.circular(Sizes.borderRadius_1),
      ),
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          spacing: 8,
          mainAxisSize: MainAxisSize.min,
          children: [
            // open/close btn
            CustomFilledButtonWidget(
              backgroundColor: Colors.transparent,
              alignment: Alignment.topRight,
              padding: 0,
              onPressed: toggleExpanded,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    spacing: 4,
                    children: [
                      Icon(
                        Icons.filter_list_rounded,
                        color: btnForegroundColor,
                      ),
                      Text(
                        KStrings.getStringsForLang(
                          appLangNotifier.value,
                        ).filters,
                        style: TextStyle(
                          color: btnForegroundColor,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),

                  Icon(
                    isExpanded
                        ? Icons.arrow_drop_up_rounded
                        : Icons.arrow_drop_down_rounded,
                    color: btnForegroundColor,
                  ),
                ],
              ),
            ),

            // Level filter
            HorizontalScrollingFiltersWidget(
              header: KStrings.getStringsForLang(
                appLangNotifier.value,
              ).level,
              items: levelFilters,
            ),

            // Type filter
            HorizontalScrollingFiltersWidget(
              header: KStrings.getStringsForLang(
                appLangNotifier.value,
              ).type,
              items: typeFilters,
            ),

            // Gender filter
            HorizontalScrollingFiltersWidget(
              header: KStrings.getStringsForLang(
                appLangNotifier.value,
              ).gender,
              items: genderFilters,
            ),
          ],
        ),
      ),
    );
  }
}
