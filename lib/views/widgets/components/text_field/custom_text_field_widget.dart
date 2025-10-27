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
  });

  final double borderRadius;
  final String label;
  final Function(String value) onChanged;
  final Widget? icon;
  final TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      controller: textEditingController,
      decoration: InputDecoration(
        suffixIcon: icon,
        labelText: label,
        labelStyle: TextStyle(
          color: ThemeColors.getThemeColors(context).secondary,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
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
