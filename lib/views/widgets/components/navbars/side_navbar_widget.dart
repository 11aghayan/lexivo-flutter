import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/data/page_data.dart';
import 'package:lexivo_flutter/enums/app_lang_enum.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';
import 'package:lexivo_flutter/views/widgets/components/btns/custom_filled_button_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';

/// A vertical side navigation bar widget that displays a list of pages as
/// icon buttons with labels and a selectable/expandable indicator.
///
/// The widget renders a column of navigation items centered vertically and
/// respects the device safe area insets (top, right, bottom). Each item
/// shows an icon inside a filled button and a single-line label below it.
/// The currently selected item is visually emphasized by swapping foreground
/// and background colors and expanding the indicator's width with an
/// animated transition.
///
/// Behavior and visuals:
/// - Uses the current theme colors (via `ThemeColors.getThemeColors`) to
///   determine `primary` and `contrastPrimary` colors for selected and
///   unselected states.
/// - Selected item:
///   - Foreground color = `colors.primary`.
///   - Background color = `colors.contrastPrimary`.
///   - Indicator (button container) animates to a wider width (`100`).
/// - Unselected item:
///   - Foreground color = `colors.contrastPrimary`.
///   - Background color = `colors.primary`.
///   - Indicator animates to a narrow width (`40`).
/// - Animation uses `Curves.easeOut` and a 400ms duration for width changes.
/// - Both the outer `GestureDetector` and the inner `CustomFilledButtonWidget`
///   trigger `setPageIndex(index)` when tapped/pressed.
///
/// Parameters:
/// - pages: A list of `PageData` objects representing the pages to display.
///   The order of items in this list defines the visual order and the index
///   passed to `setPageIndex` when an item is selected.
/// - appLang: The current application language used to retrieve localized
///   labels via `page.getLabel(appLang)`.
/// - setPageIndex: Callback invoked with the selected page index (int). This
///   should update the parent state so that `selectedPageIndex` reflects the
///   new selection.
/// - selectedPageIndex: The index of the currently selected page. The widget
///   uses this to determine which item is highlighted and expanded.
///
/// Notes and expectations:
/// - `selectedPageIndex` should be a valid index into `pages`. Out-of-range
///   values will cause incorrect selection behavior.
/// - The widget depends on `Sizes` constants (e.g., `sideBarWidth`,
///   `sideBarBasePadding`, `navbarIndicatorBorderRadius`) and custom widgets
///   (`CustomFilledButtonWidget`, `AutoSizeText`) and types (`PageData`,
///   `AppLang`, `ThemeColors`). Ensure those are available and compatible.
/// - The label is constrained to a single line (`maxLines: 1`) for compact
///   layout; longer labels should be short or localized appropriately.
/// - The widget is stateless; selection state must be managed by the parent and
///   provided via `selectedPageIndex`.
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
