import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/db/db.dart';
import 'package:lexivo_flutter/schema/dictionary/dictionary.dart';
import 'package:lexivo_flutter/util/json_util.dart';
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
    final strings = KStrings.getStringsForLang(appLangNotifier.value);

    try {
      final dictMap = await importJsonData();

      if (dictMap == null) return;
      final dict = Dictionary.fromJson(dictMap);

      final added = Dictionary.addDictionary(dict);

      if (added) {
        await Db.getDb().dict.importDict(dict);
        updateState();
        showOperationResultSnackbar(
          context: context,
          text: strings.dictionaryImportedSuccessfully,
          isSuccess: true,
        );
        return;
      }
      showDialog(
        context: context,
        builder: (context) => WarningDialogWidget(
          title: strings.duplicateDictImportWarningText(
            dict.language.nameOriginal,
          ),
        ),
      ).then((confirmed) async {
        if (confirmed) {
          await duplicateDictImportConfirm(context, dict);
        }
      });
    } catch (e) {
      print(e);
      showOperationResultSnackbar(
        context: context,
        text: strings.dictionaryCouldNotBeImported,
        isSuccess: false,
      );
    }
  }

  Future<void> duplicateDictImportConfirm(context, Dictionary dict) async {
    final strings = KStrings.getStringsForLang(appLangNotifier.value);

    final db = Db.getDb();
    try {
      final dictionaryInMemory = Dictionary.getDictionaryByLang(dict.language)!;
      await db.word.insertWords(dictionaryInMemory.id, dict.allWords);
      await db.grammar.insertGrammar(dictionaryInMemory.id, dict.allGrammar);
      dictionaryInMemory.addWords(dict.allWords);
      dictionaryInMemory.addGrammarList(dict.allGrammar);
      if (context.mounted) {
        showOperationResultSnackbar(
          context: context,
          text:
              "${strings.wordsImportedSuccessfully}\n${strings.grammarImportedSuccessfully}",
          isSuccess: true,
        );
      }
      updateState();
    } catch (e) {
      print(e);
      if (context.mounted) {
        showOperationResultSnackbar(
          context: context,
          text: strings.somethingWentWrong,
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
