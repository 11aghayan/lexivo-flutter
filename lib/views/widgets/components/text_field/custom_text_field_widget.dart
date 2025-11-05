import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';

/// A customizable, themed single-line-or-multi-line text input widget.
///
/// This widget wraps a [TextFormField] and applies the project's theme styles,
/// border radii and colors. It is intended to be a reusable text input used
/// throughout the app with consistent visual treatment and built-in support
/// for displaying a simple localized "empty field" error message.
///
/// Key behaviors
/// - Uses `ThemeColors.getThemeColors(context)` to obtain colors for text,
///   borders and background.
/// - Displays a localized error message if [error] is true. The message is
///   retrieved via `KStrings.getStringsForLang(appLangNotifier.value).emptyTextFieldError`.
/// - Supports both single-line and multi-line inputs via [maxLines].
/// - Shows a suffix icon when [icon] is provided.
/// - Applies a filled background when [backgroundColor] (or theme scaffold
///   background) is supplied.
///
/// IMPORTANT: Do not provide both [textEditingController] and [initialValue]
/// at the same time. Flutter's [TextFormField] asserts that you must not set
/// both a controller and an initial value simultaneously. Prefer using a
/// controller for programmatic reads/writes, or use [initialValue] for a
/// one-time initial display value.
///
/// Constructor parameters
/// - onChanged (required): Callback invoked with the current input value
///   whenever the text changes.
/// - hint: Optional hint text shown inside the field when it's empty.
/// - label: Optional floating label text shown above/inside the field.
/// - borderRadius: Radius applied to the input's outline border. Defaults to
///   `Sizes.borderRadius_2`.
/// - icon: Optional widget displayed as the `suffixIcon`.
/// - textEditingController: Optional [TextEditingController] to control the
///   field value programmatically. (Do not combine with [initialValue].)
/// - borderColor: Optional override color for the input border in enabled
///   state. Falls back to the theme's `searchTextFieldBorder`.
/// - error: When true, displays the localized empty-field error text.
/// - initialValue: Optional initial text value for the field. (Do not combine
///   with [textEditingController].)
/// - backgroundColor: Optional fill color for the field. If null, the theme's
///   scaffold background color is used.
/// - maxLines: Maximum number of lines for the input. Defaults to 2.
///
/// Styling notes
/// - Cursor color and text color follow the theme's `mainText`.
/// - Label text uses the theme's `secondary` color and bold weight.
/// - Focused border uses the theme's `primary` color.
/// - Error border uses the theme's `failure` color.
///
/// Example
/// ```dart
/// CustomTextFieldWidget(
///   onChanged: (value) => print(value),
///   label: 'Description',
///   hint: 'Enter a short description',
///   maxLines: 3,
///   borderRadius: 12.0,
/// )
/// ```
///
/// Usage tip
/// - If you need to read or set the text after the widget is built (for example,
///   to clear the field or set its value programmatically), pass a
///   [TextEditingController]. Otherwise, use [initialValue] for a one-time
///   initial value only.
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
    this.initialValue,
    this.backgroundColor,
    this.maxLines = 2,
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
  final Color? backgroundColor;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.getThemeColors(context);
    var borderColor = this.borderColor ?? colors.searchTextFieldBorder;

    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      controller: textEditingController,
      cursorColor: colors.mainText,
      style: TextStyle(
        color: colors.mainText,
        fontWeight: FontWeight.w300,
        fontSize: 16,
      ),
      minLines: 1,
      maxLines: maxLines,
      decoration: InputDecoration(
        errorText: error
            ? KStrings.getStringsForLang(
                appLangNotifier.value,
              ).emptyTextFieldError
            : null,
        labelText: label,
        fillColor: backgroundColor ?? colors.scaffoldBg,
        filled: true,
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
