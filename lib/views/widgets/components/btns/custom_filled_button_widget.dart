import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';

class CustomFilledButtonWidget extends StatelessWidget {
  const CustomFilledButtonWidget({
    super.key,
    required this.onPressed,
    required this.child,
    this.borderRadius = Sizes.borderRadius_2,
    this.backgroundColor,
    this.padding = 12,
    this.disabled = false,
    this.alignment = Alignment.center,
    this.elevation = false,
    this.noSplash = false,
    this.borderColor,
    this.borderWidth,
    this.outlined = false
  });

  final VoidCallback? onPressed;
  final Widget child;
  final double borderRadius;
  final Color? backgroundColor;
  final double padding;
  final bool disabled;
  final Alignment? alignment;
  final bool elevation;
  final bool noSplash;
  final Color? borderColor;
  final double? borderWidth;
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.getThemeColors(context);

    return FilledButton(
        onPressed: disabled ? null : onPressed,
        style: FilledButton.styleFrom(
          disabledBackgroundColor: colors.disabledBtn,
          backgroundColor: backgroundColor ?? colors.primary,
          foregroundColor: colors.mainText,
          alignment: alignment,
          padding: EdgeInsets.all(padding),
          elevation: elevation ? 1 : 0,
          shadowColor: colors.shadow,
          overlayColor: noSplash ? Colors.transparent : null,
          side: borderWidth != null ? BorderSide(
            color: borderColor ?? colors.outlinedBtnBorder,
            width: borderWidth!
          ) : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(
              color: outlined ? colors.outlinedBtnBorder : Colors.transparent,
              width: outlined ? 1 : 0
            )
          ),
        ),
        child: child,
      );
  }
}
