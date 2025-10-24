import 'package:flutter/material.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';

class CustomDividerWidget extends StatelessWidget {
  const CustomDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(height: 1, width: double.infinity, color: ThemeColors.getThemeColors(context).dividerColor);
  }
}
