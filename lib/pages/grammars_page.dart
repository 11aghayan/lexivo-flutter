import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/pages/grammar_page.dart';
import 'package:lexivo_flutter/schema/dictionary/dictionary.dart';
import 'package:lexivo_flutter/schema/grammar/grammar.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';
import 'package:lexivo_flutter/views/widgets/components/btns/custom_filled_button_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/no_data_widget.dart';

class GrammarsPage extends StatefulWidget {
  const GrammarsPage({super.key, required this.dictionary});

  final Dictionary dictionary;

  @override
  State<GrammarsPage> createState() => _GrammarsPageState();
}

class _GrammarsPageState extends State<GrammarsPage> {
  @override
  Widget build(BuildContext context) {
    final strings = KStrings.getStringsForLang(appLangNotifier.value);
    final colors = ThemeColors.getThemeColors(context);

    return widget.dictionary.allGrammarCount == 0
        ? NoDataWidget(text: strings.noGrammar)
        : CustomScrollView(
            semanticChildCount: 1,
            slivers: [
              SliverPadding(
                padding: EdgeInsets.all(Sizes.mainPadding),
                sliver: SliverMasonryGrid.extent(
                  maxCrossAxisExtent: 500,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childCount: widget.dictionary.allGrammarCount,
                  itemBuilder: (context, index) {
                    Grammar grammar = widget.dictionary.allGrammar[index];
                    return CustomFilledButtonWidget(
                      backgroundColor: colors.canvas,
                      borderWidth: 1,
                      onPressed: () =>
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => GrammarPage(
                                dictionary: widget.dictionary,
                                grammar: grammar,
                              ),
                            ),
                          ).then((_) {
                            setState(() {});
                          }),
                      padding: 16,
                      child: Row(
                        spacing: 4,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            grammar.header,
                            style: TextStyle(
                              color: colors.mainText,
                              fontSize: 16,
                            ),
                          ),
                          Icon(
                            FontAwesomeIcons.arrowRight,
                            color: colors.mainText,
                            size: 16,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
  }
}
