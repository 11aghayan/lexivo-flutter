import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';

/// SideAppBarWidget
///
/// A compact, fixed-width vertical sidebar widget that respects device safe
/// area insets and uses the current theme's colors. The bar places an optional
/// leading back button near the top, a column of title-area widgets in the
/// upper/middle area, and a column of action widgets anchored to the bottom
/// (right-aligned inside the action column).
///
/// Behavior and layout details:
/// - The background color is provided by ThemeColors.getThemeColors(context).primary.
/// - The width is computed as `Sizes.sideBarWidth + safeArea.left` so the left
///   safe area inset is included in the bar's width.
/// - Padding uses `Sizes.sideBarBasePadding` combined with the device safe area
///   insets: left and top paddings include safe area, bottom padding includes
///   safe area, right padding uses base padding only.
/// - The container height fills available vertical space (`double.infinity`).
/// - The main Column uses spaceBetween to separate the top (leading/title)
///   and bottom (actions) sections.
/// - If `leading` is true (default) an IconButton with
///   `Icons.arrow_back_ios_new_rounded` is shown; tapping it calls
///   `Navigator.pop(context)`. The button color is `colors.contrastPrimary`.
///
/// Constructor parameters:
/// - titleWidgets: Required. A List<Widget> rendered in a Column for the
///   sidebar's title/content area (e.g., logo, title, navigation items).
/// - actions: Optional. A List<Widget> rendered in a Column at the bottom of
///   the sidebar. The column uses `crossAxisAlignment: CrossAxisAlignment.end`
///   so actions appear right-aligned within the bar.
/// - leading: Optional (defaults to true). Controls whether the leading back
///   IconButton is displayed.
///
/// Notes and recommendations:
/// - Provide fully-built widgets in `titleWidgets` and `actions`. This widget
///   does not modify their internal layout beyond grouping and alignment.
/// - The widget is stateless and relies on theme and MediaQuery values at build
///   time, so it will update when inherited widgets change.
/// - Ensure `Navigator` is available in the context when `leading` is true to
///   avoid runtime errors when the back button is tapped.
class SideAppBarWidget extends StatelessWidget {
  const SideAppBarWidget({
    super.key,
    required this.titleWidgets,
    this.leading = true,
    this.actions = const [],
  });

  final List<Widget> titleWidgets;
  final List<Widget> actions;
  final bool leading;

  @override
  Widget build(BuildContext context) {
    final safeArea = MediaQuery.of(context).padding;
    var colors = ThemeColors.getThemeColors(context);
    const basePadding = Sizes.sideBarBasePadding;

    return Container(
      color: colors.primary,
      width: Sizes.sideBarWidth + safeArea.left,
      padding: EdgeInsets.fromLTRB(
        basePadding + safeArea.left,
        basePadding + safeArea.top,
        basePadding,
        basePadding + safeArea.bottom,
      ),
      height: double.infinity,
      child: Column(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (leading)
            IconButton(
              color: colors.contrastPrimary,
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back_ios_new_rounded),
            ),
          Column(children: titleWidgets),

          Column(crossAxisAlignment: CrossAxisAlignment.end, children: actions),
        ],
      ),
    );
  }
}
