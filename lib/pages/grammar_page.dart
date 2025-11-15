import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/schema/dictionary/dictionary.dart';
import 'package:lexivo_flutter/schema/grammar/grammar.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';
import 'package:lexivo_flutter/views/widgets/components/app_bars/app_bar_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/app_bars/side_app_bar_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/btns/dict_page_fab_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/dialogs/delete_dialog_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/grammar/grammar_page_body.dart';
import 'package:lexivo_flutter/views/widgets/components/lang_flag_title.dart';

class GrammarPage extends StatefulWidget {
  const GrammarPage({super.key, required this.dictionary, this.grammar});

  final Grammar? grammar;
  final Dictionary dictionary;

  @override
  State<GrammarPage> createState() => _GrammarPageState();
}

class _GrammarPageState extends State<GrammarPage> {
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
      maxLines: 2,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isOrientationLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBarActions = [
      // Delete btn
      if (widget.grammar != null)
        IconButton(
          onPressed: () {
            if (widget.grammar == null) return;
            showDialog(
              context: context,
              builder: (context) => DeleteDialogWidget(
                onDelete: () => deleteGrammar(widget.grammar!),
              ),
            );
          },
          icon: Icon(FontAwesomeIcons.trash, color: colors.deleteBtn),
        ),
    ];

    return Scaffold(
      appBar: !isOrientationLandscape
          ? AppBarWidget(titleWidgets: titleWidgets, actions: appBarActions)
          : null,
      body: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (isOrientationLandscape)
            SideAppBarWidget(
              titleWidgets: titleWidgets,
              actions: appBarActions,
            ),
          Expanded(
            child: GrammarPageBody(
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

  Future<void> addGrammar(Grammar g) async {
    widget.dictionary.addGrammar(g);
    // TODO: Save to db
  }

  Future<void> updateGrammar(Grammar g) async {
    widget.dictionary.updateGrammar(g);
    // TODO: Update in db
  }

  Future<void> deleteGrammar(Grammar g) async {
    widget.dictionary.deleteGrammar(g);
    Navigator.pop(context);
    // TODO: Delete from DB
  }
}
