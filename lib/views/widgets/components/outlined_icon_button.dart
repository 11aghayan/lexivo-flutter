import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';

class OutlinedIconButton extends StatelessWidget {
  const OutlinedIconButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.borderRadius = Sizes.borderRadius_2,
    this.borderColor,
    this.borderWidth = 1,
    this.padding = 12
  });

  final VoidCallback onPressed;
  final Widget child;
  final double? borderRadius; 
  final double? borderWidth;
  final Color? borderColor;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(padding!),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius!),
          border: Border.all(
            width: borderWidth!,
            color: borderColor ?? ThemeColors.getThemeColors(context).dictionaryIconBtnBorderColor
          )
        ),
        child: child),
    );
  }
}
