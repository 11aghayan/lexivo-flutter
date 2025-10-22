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
  });

  final VoidCallback onPressed;
  final Widget child;
  final double? borderRadius;
  final double? borderWidth;
  final Color? borderColor;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.all(padding!),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius!),
            border: Border.all(
              width: borderWidth!,
              color:
                  borderColor ??
                  ThemeColors.getThemeColors(context).outlinedBtnBorder,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
