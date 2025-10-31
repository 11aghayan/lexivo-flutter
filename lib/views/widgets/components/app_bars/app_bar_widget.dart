import 'package:flutter/material.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
    required this.title,
    this.leading = true,
    this.actions = const [],
    this.animationDuration = 300,
  });

  final Widget title;
  final List<Widget> actions;
  final bool leading;
  final int animationDuration;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: animationDuration),
      child: AppBar(
        title: title,
        centerTitle: true,
        actions: actions,
        leading: leading ? IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: ThemeColors.getThemeColors(context).contrastPrimary,
          ),
        ) : null,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
