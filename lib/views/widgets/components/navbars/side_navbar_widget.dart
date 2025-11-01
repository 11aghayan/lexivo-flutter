import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/data/page_data.dart';
import 'package:lexivo_flutter/enums/app_lang_enum.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';
import 'package:lexivo_flutter/views/widgets/components/btns/custom_filled_button_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';

class SideNavbarWidget extends StatelessWidget {
  const SideNavbarWidget({
    super.key,
    required this.pages,
    required this.appLang,
    required this.setPageIndex,
    required this.selectedPageIndex,
  });

  final List<PageData> pages;
  final AppLang appLang;
  final Function(int) setPageIndex;
  final int selectedPageIndex;

  @override
  Widget build(BuildContext context) {
    final safeArea = MediaQuery.of(context).padding;
    final colors = ThemeColors.getThemeColors(context);
    const basePadding = Sizes.sideBarBasePadding;

    return Container(
      color: colors.primary,
      width: Sizes.sideBarWidth + safeArea.right,
      padding: EdgeInsets.fromLTRB(
        basePadding,
        basePadding + safeArea.top,
        basePadding + safeArea.right,
        basePadding + safeArea.bottom,
      ),
      child: Column(
        spacing: basePadding,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(pages.length, (int index) {
          final page = pages[index];
          bool selected = selectedPageIndex == index;
          final foregroundColor = selected
              ? colors.primary
              : colors.contrastPrimary;
          final backgroundColor = selected
              ? colors.contrastPrimary
              : colors.primary;

          return GestureDetector(
            onTap: () => setPageIndex(index),
            child: Column(
              spacing: 4,
              children: [
                AnimatedContainer(
                  curve: Curves.easeOut,
                  width: selected ? 100 : 40,
                  duration: Duration(milliseconds: 400),
                  child: CustomFilledButtonWidget(
                    onPressed: () => setPageIndex(index),
                    backgroundColor: backgroundColor,
                    padding: 4,
                    borderRadius: Sizes.navbarIndicatorBorderRadius,
                    child: Icon(page.icon, color: foregroundColor, size: 28),
                  ),
                ),
                AutoSizeText(page.getLabel(appLang), maxLines: 1, style: TextStyle(color: colors.contrastPrimary),),
              ],
            ),
          );
        }),
      ),
    );
  }
}
