import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';

void showOperationResultSnackbar(
  BuildContext context, String text, bool isSuccess) {
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
