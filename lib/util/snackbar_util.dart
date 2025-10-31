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
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: !isSuccess
          ? ThemeColors.getThemeColors(context).failure
          : ThemeColors.getThemeColors(context).success,
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: ThemeColors.getThemeColors(context).contrastPrimary,
          fontSize: Sizes.snackbarTextSize,
        ),
      ),
    ),
  );
}
