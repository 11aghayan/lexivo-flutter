import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';

class SideNavbarWidget extends StatelessWidget {
  const SideNavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final safeArea = MediaQuery.of(context).padding.right;
    var colors = ThemeColors.getThemeColors(context);

    return Container(
      color: colors.primary,
      width: Sizes.sideBarWidth + safeArea,
      height: double.infinity,
      child: SafeArea(
        child: Column(
          children: [
            Icon(Icons.abc),
            Icon(Icons.access_time_filled_outlined),
            Icon(Icons.account_balance_outlined),
          ],
        ),
      ),
    );
  }
}
