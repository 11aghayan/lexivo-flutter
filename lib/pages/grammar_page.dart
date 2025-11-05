import 'package:auto_size_text/auto_size_text.dart';
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
    AutoSizeText(
      widget.grammar?.header ?? strings.addGrammarPageLabel,
      maxLines: 2,
      minFontSize: 12,
      softWrap: true,
      textAlign: TextAlign.center,
      style: TextStyle(color: colors.contrastPrimary),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isOrientationLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBarActions = [
      if (widget.grammar != null)
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
      body: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (isOrientationLandscape)
            SideAppBarWidget(
              titleWidgets: titleWidgets,
              actions: appBarActions,
            ),
          Expanded(child: GrammarPageBody(grammar: tempGrammar)),
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

  Future<void> addSubmenu() async {
    setState(() {
      tempGrammar.addSubmenu();
    });
  }
}
