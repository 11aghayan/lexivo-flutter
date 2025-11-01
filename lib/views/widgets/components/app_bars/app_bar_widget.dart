import 'package:flutter/material.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
    required this.titleWidgets,
    this.leading = true,
    this.actions = const []
  });

  final List<Widget> titleWidgets;
  final List<Widget> actions;
  final bool leading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: titleWidgets),
        centerTitle: true,
        actions: actions,
        leading: leading ? IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: ThemeColors.getThemeColors(context).contrastPrimary,
          ),
        ) : null,
      );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
