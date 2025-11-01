import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';

class CustomTextFieldWidget extends StatelessWidget {
  const CustomTextFieldWidget({
    super.key,
    required this.onChanged,
    required this.label,
    this.borderRadius = Sizes.borderRadius_2,
    this.icon,
    this.textEditingController,
    this.borderColor,
  });

  final double borderRadius;
  final String label;
  final Function(String value) onChanged;
  final Widget? icon;
  final TextEditingController? textEditingController;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    var borderColor =
        this.borderColor ??
        ThemeColors.getThemeColors(context).searchTextFieldBorder;

    return TextField(
      onChanged: onChanged,
      controller: textEditingController,
      decoration: InputDecoration(
        suffixIcon: icon,
        hint: Text(
          label,
          style: TextStyle(
            color: ThemeColors.getThemeColors(context).secondary,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: borderColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: ThemeColors.getThemeColors(context).primary,
            width: 2,
          ),
        ),
      ),
    );
  }
}
