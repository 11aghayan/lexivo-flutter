import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/schema/grammar/grammar.dart';
import 'package:lexivo_flutter/schema/grammar/grammar_submenu.dart';
import 'package:lexivo_flutter/views/widgets/components/btns/save_btn_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/grammar/grammar_submenu_control_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/text_field/custom_text_field_widget.dart';

class GrammarPageBody extends StatefulWidget {
  const GrammarPageBody({super.key, required this.grammar});

  final Grammar grammar;

  @override
  State<GrammarPageBody> createState() => _GrammarPageBodyState();
}

class _GrammarPageBodyState extends State<GrammarPageBody> {
  final strings = KStrings.getStringsForLang(appLangNotifier.value);

  bool isHeaderError = false;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      semanticChildCount: 3,
      slivers: [
        // Header
        SliverPadding(
          padding: EdgeInsets.all(Sizes.mainPadding),
          sliver: SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 500),
                child: SizedBox(
                  width: double.infinity,
                  child: CustomTextFieldWidget(
                    onChanged: (String value) {},
                    error: isHeaderError,
                    label: strings.header,
                  ),
                ),
              ),
            ),
          ),
        ),

        // Submenus
        SliverPadding(
          padding: EdgeInsets.all(Sizes.mainPadding),
          sliver: SliverMasonryGrid.extent(
            maxCrossAxisExtent: Sizes.widgetMaxWidth,
            crossAxisSpacing: Sizes.addGrammarPageGridSpacing,
            mainAxisSpacing: Sizes.addGrammarPageGridSpacing,
            childCount: widget.grammar.submenuListLength,
            itemBuilder: (context, index) {
              GrammarSubmenu submenu = widget.grammar.submenuList[index];
              return GrammarSubmenuControlWidget(submenu: submenu, deletable: widget.grammar.submenuListLength > 1,);
            },
          ),
        ),

        // Save button
        SliverPadding(
          padding: EdgeInsets.all(Sizes.mainPadding),
          sliver: SliverToBoxAdapter(
            child: Center(
              child: SaveBtnWidget(
                onPressed: () {
                  //TODO:
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
