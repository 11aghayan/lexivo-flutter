import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/schema/dictionary/dictionary.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';
import 'package:lexivo_flutter/views/widgets/components/dialogs/add_dict_dialog_widget.dart';

class MainPageFabWidget extends StatelessWidget {
  const MainPageFabWidget({super.key, required this.addDictionary});

  final Function(Dictionary) addDictionary;

  @override
  Widget build(BuildContext context) {
    double safeArea = MediaQuery.of(context).padding.right;
    bool isOrientationLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Padding(
      padding: EdgeInsets.only(
        right: isOrientationLandscape ? Sizes.sideBarWidth + safeArea : 0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: Sizes.fabVerticalSpacing,
        children: [
          FloatingActionButton.small(
            heroTag: "main_page_import_dict_fab",
            onPressed: importDict,
            backgroundColor: ThemeColors.getThemeColors(
              context,
            ).contrastPrimary,
            foregroundColor: ThemeColors.getThemeColors(context).accent,
            child: Icon(Icons.download_rounded),
          ),

          // Button Add
          FloatingActionButton(
            heroTag: "main_page_add_dict_fab",
            onPressed: () => showAddDictDialog(context),
            child: Icon(Icons.add_rounded),
          ),
        ],
      ),
    );
  }

  void importDict() {
    // TODO: Implement
  }

  void showAddDictDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (buildContext) {
        return AddDictDialogWidget(addDictionary: addDictionary);
      },
    );
  }
}
