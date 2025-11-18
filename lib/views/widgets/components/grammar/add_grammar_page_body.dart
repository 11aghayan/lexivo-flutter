import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/schema/grammar/grammar.dart';
import 'package:lexivo_flutter/schema/grammar/grammar_submenu.dart';
import 'package:lexivo_flutter/util/snackbar_util.dart';
import 'package:lexivo_flutter/views/widgets/components/btns/save_btn_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/grammar/add_grammar_submenu_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/text_field/custom_text_field_widget.dart';

class AddGrammarPageBody extends StatefulWidget {
  const AddGrammarPageBody({
    super.key,
    required this.grammar,
    required this.saveInDictionary,
    required this.isUpdate,
  });

  final Grammar grammar;
  final Future<void> Function(Grammar g) saveInDictionary;
  final bool isUpdate;

  @override
  State<AddGrammarPageBody> createState() => _AddGrammarPageBodyState();
}

class _AddGrammarPageBodyState extends State<AddGrammarPageBody> {
  final strings = KStrings.getStringsForLang(appLangNotifier.value);

  bool isHeaderError = false;
  List<int> submenuHeaderErrorIndices = [];

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
                constraints: BoxConstraints(maxWidth: Sizes.widgetMaxWidth),
                child: SizedBox(
                  width: double.infinity,
                  child: CustomTextFieldWidget(
                    onChanged: (String value) {
                      widget.grammar.header = value;
                    },
                    error: isHeaderError,
                    label: strings.header,
                    initialValue: widget.grammar.header,
                  ),
                ),
              ),
            ),
          ),
        ),

        // Submenus
        SliverPadding(
          padding: EdgeInsets.all(Sizes.mainPadding),
          sliver: widget.grammar.submenuListLength < 2
              ? SliverToBoxAdapter(
                  child: Center(
                    child: AddGrammarSubmenuWidget(
                      submenu: widget.grammar.submenuList[0],
                      emptyHeaderError: submenuHeaderErrorIndices.contains(0),
                      deletable: false,
                      onDelete: () {},
                    ),
                  ),
                )
              : SliverMasonryGrid.extent(
                  maxCrossAxisExtent: Sizes.widgetMaxWidth,
                  crossAxisSpacing: Sizes.gridViewItemsSpacing,
                  mainAxisSpacing: Sizes.gridViewItemsSpacing,
                  childCount: widget.grammar.submenuListLength,
                  itemBuilder: (context, index) {
                    GrammarSubmenu submenu = widget.grammar.submenuList[index];
                    return AddGrammarSubmenuWidget(
                      submenu: submenu,
                      emptyHeaderError: submenuHeaderErrorIndices.contains(index),
                      deletable: true,
                      onDelete: () => deleteSubmenu(submenu),
                    );
                  },
                ),
        ),

        // Save button
        SliverPadding(
          padding: EdgeInsets.all(Sizes.mainPadding),
          sliver: SliverToBoxAdapter(
            child: Center(child: SaveBtnWidget(onPressed: save)),
          ),
        ),
      ],
    );
  }

  void deleteSubmenu(GrammarSubmenu submenu) {
    widget.grammar.deleteSubmenu(submenu);
    if (mounted) {
      setState(() {});
    }
  }

  void save() async {
    if (_necessaryFieldsError()) return;
    try {
      await widget.saveInDictionary(widget.grammar);
      if (mounted) {
        String text = !widget.isUpdate
            ? strings.grammarAddedSuccessfully
            : strings.grammarUpdatedSuccessfully;
        showOperationResultSnackbar(
          context: context,
          text: text,
          isSuccess: true,
        );
        Navigator.pop(context);
      }
    } catch (e) {
      print(e);
      if (mounted) {
        String text = !widget.isUpdate
            ? strings.grammarCouldNotBeAdded
            : strings.grammarCouldNotBeUpdated;
        showOperationResultSnackbar(
          context: context,
          text: text,
          isSuccess: false,
        );
      }
    }
  }

  bool _necessaryFieldsError() {
    isHeaderError = widget.grammar.header.trim().isEmpty;

    List<int> errorIndices = [];
    for (int i = 0; i < widget.grammar.submenuListLength; i++) {
      if (widget.grammar.submenuList[i].header.trim().isEmpty) {
        errorIndices.add(i);
      }
    }
    submenuHeaderErrorIndices = errorIndices;

    if (mounted) {
      setState(() {});
    }

    return isHeaderError || submenuHeaderErrorIndices.isNotEmpty;
  }
}
