import 'package:flutter/material.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
    required this.title,
    this.leading = true,
    this.actions,
    this.isVisible = true,
    this.animationDuration = 300
  });

  final Widget title;
  final List<Widget>? actions;
  final bool leading;
  final bool isVisible;
  final int animationDuration;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: animationDuration),
      height: isVisible ? 104 : 0,
      child: AppBar(
        title: title,
        centerTitle: true,
        actions: actions,
        leading: leading
            ? IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: ThemeColors.getThemeColors(context).contrastPrimary,
                ),
              )
            : null,
        bottom: PreferredSize(
          preferredSize: preferredSize,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black45,
                  blurRadius: 0.2,
                  spreadRadius: 0.1,
                  offset: Offset(0, 0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
