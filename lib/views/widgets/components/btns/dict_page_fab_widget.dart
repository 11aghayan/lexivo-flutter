import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';

class DictPageFabWidget extends StatelessWidget {
  const DictPageFabWidget({
    super.key,
    required this.pageIndex,
    required this.scrollUpBtnVisible,
    required this.scrollUp
  });

  final int pageIndex;
  final bool scrollUpBtnVisible;
  final Function() scrollUp;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: Sizes.fabVerticalSpacing,
      children: pageIndex == 0
          ? [
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
                onPressed: () {
                  //TODO: Redirect to add word page
                },
                child: Icon(Icons.add_rounded),
              ),
            ]
          : [],
    );
  }
}
