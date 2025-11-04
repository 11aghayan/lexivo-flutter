import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lexivo_flutter/schema/dictionary/dictionary.dart';
import 'package:lexivo_flutter/schema/grammar/grammar.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';
import 'package:lexivo_flutter/views/widgets/components/app_bars/app_bar_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/btns/dict_page_fab_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/grammar_page_body.dart';
import 'package:lexivo_flutter/views/widgets/components/lang_flag_title.dart';

class GrammarPage extends StatelessWidget {
  const GrammarPage({super.key, required this.dictionary, this.grammar});

  final Grammar? grammar;
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context) {
    Grammar tempGrammar = grammar == null ? Grammar.create("", []) : Grammar.copy(grammar!);

    final colors = ThemeColors.getThemeColors(context);
    final isOrientationLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final titleWidgets = [
      LangFlagTitle(photoPath: dictionary.language.photoPath),
      AutoSizeText(
        // TODO: Add localized header
        grammar?.header ?? "ADD GRAMMAR",
        maxLines: 2,
        minFontSize: 16,
        softWrap: true,
        textAlign: TextAlign.center,
        style: TextStyle(color: colors.contrastPrimary),
      ),
    ];

    final appBarActions = [
      if (grammar != null)
        IconButton(
          onPressed: () {
            // TODO: 
          },
          icon: Icon(FontAwesomeIcons.trash, color: colors.deleteBtn),
        ),
    ];

    return Scaffold(
      appBar: !isOrientationLandscape
          ? AppBarWidget(titleWidgets: titleWidgets, actions: appBarActions)
          : null,
      body: GrammarPageBody(grammar: tempGrammar),
      floatingActionButton: DictPageFabWidget(scrollUpBtnVisible: false, scrollUp: (){}, dictionary: dictionary, onPressed: (){
        // TODO: 
      }),
    );
  }

  Future<void> addSubmenu() async {
    // TODO:
  }
}
