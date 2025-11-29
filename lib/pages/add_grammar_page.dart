import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/db/db.dart';
import 'package:lexivo_flutter/schema/dictionary/dictionary.dart';
import 'package:lexivo_flutter/schema/grammar/grammar.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';
import 'package:lexivo_flutter/views/widgets/components/app_bars/app_bar_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/app_bars/side_app_bar_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/btns/dict_page_fab_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/grammar/add_grammar_page_body.dart';
import 'package:lexivo_flutter/views/widgets/components/lang_flag_title.dart';

class AddGrammarPage extends StatefulWidget {
  const AddGrammarPage({super.key, required this.dictionary, this.grammar});

  final Grammar? grammar;
  final Dictionary dictionary;

  @override
  State<AddGrammarPage> createState() => _AddGrammarPageState();
}

class _AddGrammarPageState extends State<AddGrammarPage> {
  late final tempGrammar = widget.grammar == null
      ? Grammar.create()
      : Grammar.copy(widget.grammar!);

  late final strings = KStrings.getStringsForLang(appLangNotifier.value);
  late final colors = ThemeColors.getThemeColors(context);

  late final titleWidgets = [
    LangFlagTitle(photoPath: widget.dictionary.language.photoPath),
    Text(
      widget.grammar?.header ?? strings.addGrammarPageLabel,
      textAlign: TextAlign.center,
      style: TextStyle(color: colors.contrastPrimary),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isOrientationLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: !isOrientationLandscape
          ? AppBarWidget(titleWidgets: titleWidgets)
          : null,
      body: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (isOrientationLandscape)
            SideAppBarWidget(titleWidgets: titleWidgets),
          Expanded(
            child: AddGrammarPageBody(
              grammar: tempGrammar,
              isUpdate: widget.grammar != null,
              saveInDictionary: widget.grammar == null
                  ? addGrammar
                  : updateGrammar,
            ),
          ),
        ],
      ),
      floatingActionButton: DictPageFabWidget(
        scrollUpBtnVisible: false,
        scrollUp: () {},
        dictionary: widget.dictionary,
        onPressed: addSubmenu,
      ),
    );
  }

  void addSubmenu() {
    tempGrammar.addSubmenu();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> addGrammar(Grammar grammar) async {
    final g = widget.dictionary.addGrammar(grammar);
    await Db.getDb().grammar.insertGrammar(widget.dictionary.id, [g]);
  }

  Future<void> updateGrammar(Grammar grammar) async {
    final g = widget.dictionary.updateGrammar(grammar);
    await Db.getDb().grammar.updateGrammar(g);
  }
}
