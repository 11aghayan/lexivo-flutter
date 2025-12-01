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
    final spacing = 8.0;

    return widget.dictionary.allGrammarCount == 0
        ? NoDataWidget(text: strings.noGrammar)
        : CustomScrollView(
            semanticChildCount: 1,
            slivers: [
              SliverPadding(
                padding: EdgeInsets.all(Sizes.mainPadding),
                sliver: SliverMasonryGrid.extent(
                  maxCrossAxisExtent: Sizes.widgetMaxWidth,
                  crossAxisSpacing: spacing,
                  mainAxisSpacing: spacing,
                  childCount: widget.dictionary.allGrammarCount,
                  itemBuilder: (context, index) {
                    Grammar grammar = widget.dictionary.allGrammar.elementAt(
                      index,
                    );
                    return CustomFilledButtonWidget(
                      backgroundColor: colors.canvas,
                      outlined: true,
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
                            if (mounted) {
                              setState(() {});
                            }
                          }),
                      padding: 24,
                      child: Row(
                        spacing: 4,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              grammar.header,
                              style: TextStyle(
                                color: colors.mainText,
                                fontSize: 16,
                              ),
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
