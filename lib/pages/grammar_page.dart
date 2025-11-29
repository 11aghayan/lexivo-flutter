import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/db/db.dart';
import 'package:lexivo_flutter/pages/add_grammar_page.dart';
import 'package:lexivo_flutter/schema/dictionary/dictionary.dart';
import 'package:lexivo_flutter/schema/grammar/grammar.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';
import 'package:lexivo_flutter/views/widgets/components/app_bars/app_bar_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/app_bars/side_app_bar_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/dialogs/delete_dialog_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/grammar/grammar_submenu_container.dart';
import 'package:lexivo_flutter/views/widgets/components/lang_flag_title.dart';

class GrammarPage extends StatefulWidget {
  const GrammarPage({
    super.key,
    required this.dictionary,
    required this.grammar,
  });

  final Dictionary dictionary;
  final Grammar grammar;

  @override
  State<GrammarPage> createState() => _GrammarPageState();
}

class _GrammarPageState extends State<GrammarPage> {
  late Grammar grammar = widget.grammar;
  late final strings = KStrings.getStringsForLang(appLangNotifier.value);
  late final colors = ThemeColors.getThemeColors(context);
  late final appBarActions = [
    IconButton(
      onPressed: () =>
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddGrammarPage(
                dictionary: widget.dictionary,
                grammar: grammar,
              ),
            ),
          ).then((_) {
            if (mounted) {
              setState(() {
                grammar = widget.dictionary.allGrammar.firstWhere(
                  (e) => e.id == grammar.id,
                );
              });
            }
          }),
      icon: Icon(FontAwesomeIcons.penToSquare),
    ),

    // Delete btn
    IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) =>
              DeleteDialogWidget(onDelete: () => deleteGrammar(grammar)),
        );
      },
      icon: Icon(FontAwesomeIcons.trash, color: colors.deleteBtn),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isOrientationLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final safeArea = MediaQuery.of(context).padding;
    final titleWidgets = [
      LangFlagTitle(photoPath: widget.dictionary.language.photoPath),
      Text(grammar.header, textAlign: TextAlign.center),
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
            child: MasonryGridView.extent(
              padding: EdgeInsets.fromLTRB(
                Sizes.mainPadding,
                Sizes.mainPadding,
                Sizes.mainPadding + safeArea.right,
                Sizes.mainPadding,
              ),
              maxCrossAxisExtent: Sizes.widgetMaxWidth,
              mainAxisSpacing: Sizes.gridViewItemsSpacing,
              crossAxisSpacing: Sizes.gridViewItemsSpacing,
              itemCount: grammar.submenuListLength,
              itemBuilder: (context, index) =>
                  GrammarSubmenuContainer(submenu: grammar.submenuList[index]),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> deleteGrammar(Grammar g) async {
    widget.dictionary.deleteGrammar(g);
    await Db.getDb().grammar.deleteGrammar(grammar.id);
    if (mounted) {
      Navigator.pop(context);
    }
  }
}
