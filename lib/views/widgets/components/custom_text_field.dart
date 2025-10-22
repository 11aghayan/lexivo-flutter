import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.onChanged, required this.label, this.borderRadius = Sizes.borderRadius_2});

  final double borderRadius;
  final String label;
  final Function(String value) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: ThemeColors.getThemeColors(context).secondary,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius)
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: ThemeColors.getThemeColors(context).primary,
            width: 2
          )
        )
      ),
    );
  }
}