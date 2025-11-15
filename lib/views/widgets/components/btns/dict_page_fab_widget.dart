import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/schema/dictionary/dictionary.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';

class DictPageFabWidget extends StatelessWidget {
  const DictPageFabWidget({
    super.key,
    required this.scrollUpBtnVisible,
    required this.scrollUp,
    required this.dictionary,
    required this.onPressed,
    this.extraOffset = false
  });

  final Dictionary dictionary;
  final bool scrollUpBtnVisible;
  final void Function() scrollUp;
  final void Function() onPressed;
  final bool extraOffset;

  @override
  Widget build(BuildContext context) {
    double safeArea = MediaQuery.of(context).padding.right;
    bool isOrientationLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Padding(
      padding: EdgeInsets.only(
        right: isOrientationLandscape ? safeArea + (extraOffset ? Sizes.sideBarWidth : 0) : 0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        spacing: Sizes.fabVerticalSpacing,
        children: [
          if (scrollUpBtnVisible)
            FloatingActionButton.small(
              heroTag: "dict_page_scroll_up_fab",
              onPressed: scrollUp,
              backgroundColor: ThemeColors.getThemeColors(
                context,
              ).contrastPrimary,
              foregroundColor: ThemeColors.getThemeColors(context).accent,
              child: Icon(Icons.keyboard_arrow_up_rounded),
            ),

          // Button Add
          FloatingActionButton(
            heroTag: "dict_page_add_word_fab",
            onPressed: onPressed,
            child: Icon(Icons.add_rounded),
          ),
        ],
      ),
    );
  }
}
