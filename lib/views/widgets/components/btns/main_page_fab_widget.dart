import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/db/db.dart';
import 'package:lexivo_flutter/schema/dictionary/dictionary.dart';
import 'package:lexivo_flutter/util/export_import_json.dart';
import 'package:lexivo_flutter/util/snackbar_util.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';
import 'package:lexivo_flutter/views/widgets/components/dialogs/add_dict_dialog_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/dialogs/warning_dialog_widget.dart';

class MainPageFabWidget extends StatelessWidget {
  const MainPageFabWidget({
    super.key,
    required this.addDictionary,
    required this.updateState,
  });

  final Function(Dictionary) addDictionary;
  final Function() updateState;

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
            onPressed: () => importDict(context),
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

  void importDict(context) async {
    try {
      final dictMap = await importJsonData();

      if (dictMap == null) return;
      final dict = Dictionary.fromJson(dictMap);

      final added = Dictionary.addDictionary(dict);

      if (added) {
        await Db.getDb().dict.importDict(dict);
        updateState();
        return;
      }

      // TODO: Update text
      showDialog(
        context: context,
        builder: (context) =>
            // TODO: Update text
            WarningDialogWidget(
              onConfirm: () async {
                onDuplicateDictImportConfirm(context, dict);
              },
              title: "HASJFAHJ",
            ),
      );
    } catch (e) {
      print(e);
      // TODO: Update text
      showOperationResultSnackbar(
        context: context,
        text: "FAILURE",
        isSuccess: false,
      );
    }
  }

  void onDuplicateDictImportConfirm(context, Dictionary dict) async {
    final db = Db.getDb();
    try {
      final dictionaryInMemory = Dictionary.getDictionaryByLang(dict.language)!;
      await db.word.insertWords(dictionaryInMemory.id, dict.allWords);
      await db.grammar.insertGrammar(
        dictionaryInMemory.id,
        dict.allGrammar,
      );
      final words = await db.word.getAllWordsOfDict(dictionaryInMemory.id);
      final grammar = await db.grammar.getAllGrammarOfDict(dictionaryInMemory.id);
      dictionaryInMemory.addWords(dict.allWords);
      dictionaryInMemory.addGrammarList(dict.allGrammar);
      if (context.mounted) {
        // TODO: Update text
        showOperationResultSnackbar(
          context: context,
          text: "SUCCESS",
          isSuccess: true,
        );
      }
      updateState();
    } catch (e) {
      print("ERROR");
      // TODO: Update text
      if (context.mounted) {
        showOperationResultSnackbar(
          context: context,
          text: "Something went wrong",
          isSuccess: false,
        );
      }
    }
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
