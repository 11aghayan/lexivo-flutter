import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
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
  late final strings = KStrings.getStringsForLang(appLangNotifier.value);
  late final colors = ThemeColors.getThemeColors(context);
  late final titleWidgets = [
    LangFlagTitle(photoPath: widget.dictionary.language.photoPath),
    Text(widget.grammar.header, textAlign: TextAlign.center),
  ];
  late final appBarActions = [
    // Delete btn
    IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) =>
              DeleteDialogWidget(onDelete: () => deleteGrammar(widget.grammar)),
        );
      },
      icon: Icon(FontAwesomeIcons.trash, color: colors.deleteBtn),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isOrientationLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

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
              //TODO: Check the swipe up side padding
              padding: EdgeInsets.all(Sizes.mainPadding),
              maxCrossAxisExtent: Sizes.widgetMaxWidth,
              mainAxisSpacing: Sizes.gridViewItemsSpacing,
              crossAxisSpacing: Sizes.gridViewItemsSpacing,
              itemCount: widget.grammar.submenuListLength,
              itemBuilder: (context, index) => GrammarSubmenuContainer(
                submenu: widget.grammar.submenuList[index],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> deleteGrammar(Grammar g) async {
    widget.dictionary.deleteGrammar(g);
    Navigator.pop(context);
    // TODO: Delete from DB
  }
}
