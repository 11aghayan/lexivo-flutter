import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lexivo_flutter/schema/dictionary.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';
import 'package:lexivo_flutter/views/widgets/components/dialogs/add_dict_dialog_widget.dart';

class MainPageFloatingActionBtnWidget extends StatelessWidget {
  const MainPageFloatingActionBtnWidget({
    super.key,
    required this.pageIndex,
    required this.addDictionary,
  });

  final int pageIndex;
  final Function(Dictionary) addDictionary;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 16,
      children: pageIndex == 0
          ? [
              FloatingActionButton.small(
                onPressed: () {
                  // TODO: Add Import JSON func
                },
                backgroundColor: ThemeColors.getThemeColors(
                  context,
                ).contrastPrimary,
                foregroundColor: ThemeColors.getThemeColors(context).accent,
                child: Icon(Icons.download_rounded),
              ),

              // Button Add
              FloatingActionButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (buildContext) {
                      return AddDictDialogWidget(addDictionary: addDictionary);
                    },
                  );
                },
                child: Icon(Icons.add_rounded),
              ),
            ]
          : [],
    );
  }
}
