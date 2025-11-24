import 'package:flutter/material.dart';
import 'package:lexivo_flutter/data/filter_data.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';
import 'package:lexivo_flutter/views/widgets/components/btns/custom_filled_button_widget.dart';

class HorizontalScrollingFiltersWidget extends StatelessWidget {
  const HorizontalScrollingFiltersWidget({
    super.key,
    required this.header,
    required this.items,
  });

  final String header;
  final List<FilterData> items;

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.getThemeColors(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        Text(
          header,
          style: TextStyle(
            color: colors.secondary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 52,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            physics: BouncingScrollPhysics(),
            separatorBuilder: (context, index) {
              return SizedBox(width: 4);
            },
            itemBuilder: (context, index) {
              FilterData item = items[index];
              return CustomFilledButtonWidget(
                onPressed: item.toggleSelected,
                backgroundColor: item.selected
                    ? colors.filterSelected
                    : colors.filterNotSelected,
                padding: 16,
                child: Text(
                  item.label,
                  style: TextStyle(
                    color: colors.mainText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
