import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';

class CustomTextFieldWidget extends StatelessWidget {
  const CustomTextFieldWidget({
    super.key,
    required this.onChanged,
    this.hint,
    this.label,
    this.borderRadius = Sizes.borderRadius_2,
    this.icon,
    this.textEditingController,
    this.borderColor,
    this.error = false,
    this.initialValue
  });

  final double borderRadius;
  final String? hint;
  final String? label;
  final Function(String value) onChanged;
  final Widget? icon;
  final TextEditingController? textEditingController;
  final Color? borderColor;
  final bool error;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.getThemeColors(context);
    var borderColor = this.borderColor ?? colors.searchTextFieldBorder;

    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      controller: textEditingController,
      cursorColor: colors.mainText,
      style: TextStyle(color: colors.mainText, fontWeight: FontWeight.w300, fontSize: 16),
      decoration: InputDecoration(
        errorText: error
            ? KStrings.getStringsForLang(
                appLangNotifier.value,
              ).emptyTextFieldError
            : null,
        labelText: label,
        labelStyle: TextStyle(
          color: colors.secondary,
          fontWeight: FontWeight.bold,
        ),
        suffixIcon: icon,
        hint: hint != null
            ? Text(hint!, style: TextStyle(color: colors.secondary))
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: borderColor, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: borderColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: colors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: colors.failure, width: 2),
        ),
      ),
    );
  }
}
