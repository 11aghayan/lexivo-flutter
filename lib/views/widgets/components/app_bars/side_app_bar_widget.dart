import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';

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
    final colors = ThemeColors.getThemeColors(context);
    final basePadding = Sizes.sideBarBasePadding;
    final titleWidgets = this.titleWidgets.map((w) {
      if (w is Text) {
        final text = Text(
          w.data!,
          style: TextStyle(
            fontWeight: w.style?.fontWeight,
            fontSize: w.style?.fontSize ?? 18,
            color: w.style?.color ?? colors.contrastPrimary,
          ),
        );
        return FittedBox(child: text);
      }
      return w;
    }).toList();

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
              onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
              icon: Icon(Icons.arrow_back_ios_new_rounded),
            ),
          Column(children: titleWidgets),

          Column(crossAxisAlignment: CrossAxisAlignment.end, children: actions),
        ],
      ),
    );
  }
}
