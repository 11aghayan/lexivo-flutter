import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';

/// Shows a snackbar with a success or failure message.
///
/// This utility function displays a snackbar at the bottom of the screen with
/// the provided [text] message. The background color of the snackbar is determined
/// by the [isSuccess] parameter:
/// * If [isSuccess] is true, the background will be the theme's success color
/// * If [isSuccess] is false, the background will be the theme's failure color
///
/// The text is centered and styled using the theme's contrast primary color.
/// The snackbar will automatically dismiss after 2.5 seconds.
///
/// Parameters:
/// * [context] - The build context used to show the snackbar and access theme
/// * [text] - The message to display in the snackbar
/// * [isSuccess] - Determines if this is a success (true) or failure (false) message

void showOperationResultSnackbar({
  required BuildContext context,
  required String text,
  required bool isSuccess,
}) {
  final colors = ThemeColors.getThemeColors(context);

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(milliseconds: 2500),
      backgroundColor: !isSuccess ? colors.failure : colors.primary,
      content: Flexible(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: colors.contrastPrimary,
            fontSize: Sizes.snackbarTextSize,
          ),
        ),
      ),
    ),
  );
}

/// Displays an informational snackbar with the specified text.
///
/// The snackbar appears at the bottom of the screen with theme-specific styling.
///
/// Parameters:
/// - [context]: The build context used to show the snackbar and access theme colors
/// - [text]: The text message to display in the snackbar
///
/// The snackbar will automatically dismiss after 2.5 seconds.
void showInfoSnackbar({required BuildContext context, required String text}) {
  final colors = ThemeColors.getThemeColors(context);

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(milliseconds: 2500),
      backgroundColor: colors.infoSnackbarBg,
      content: Flexible(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: colors.mainText,
            fontSize: Sizes.snackbarTextSize,
          ),
        ),
      ),
    ),
  );
}
