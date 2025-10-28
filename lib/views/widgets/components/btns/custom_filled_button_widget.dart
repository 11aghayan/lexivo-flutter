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
    this.height,
    this.alignment = Alignment.center
  });

  final VoidCallback? onPressed;
  final Widget child;
  final double? borderRadius;
  final Color? backgroundColor;
  final double? padding;
  final bool disabled;
  final double? height;
  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          alignment: alignment,
          height: height,
          padding: EdgeInsets.all(padding!),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius!),
            color: disabled
                ? ThemeColors.getThemeColors(context).disabledBtn
                : (backgroundColor ??
                      ThemeColors.getThemeColors(context).primary),
          ),
          child: child,
        ),
      ),
    );
  }
}
