import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';

class CustomOutlinedButtonWidget extends StatelessWidget {
  const CustomOutlinedButtonWidget({
    super.key,
    required this.onPressed,
    required this.child,
    this.borderRadius = Sizes.borderRadius_2,
    this.borderColor,
    this.borderWidth = 1,
    this.padding = 12,
    this.foregroundColor,
  });

  final VoidCallback onPressed;
  final Widget child;
  final double borderRadius;
  final double borderWidth;
  final Color? borderColor;
  final double padding;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.getThemeColors(context);

    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.all(padding),
        foregroundColor: foregroundColor ?? colors.mainText,
        side: BorderSide(
          color: borderColor ?? colors.outlinedBtnBorder,
          width: borderWidth,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: child,
    );
  }
}
