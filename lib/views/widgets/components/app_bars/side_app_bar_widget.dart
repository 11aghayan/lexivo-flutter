import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';

class SideAppBarWidget extends StatelessWidget {
  const SideAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final safeArea = MediaQuery.of(context).padding.left;
    var colors = ThemeColors.getThemeColors(context);

    return Container(
      color: colors.primary,
      width: Sizes.sideBarWidth + safeArea,
      height: double.infinity,
      child: SafeArea(
        child: Column(
          children: [
            Icon(Icons.arrow_back_ios_new_rounded),
          ],
        ),
      ),
    );
  }
}
