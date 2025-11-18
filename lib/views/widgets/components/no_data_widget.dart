import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.mainPadding),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: ThemeColors.getThemeColors(context).emptyPageText,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
