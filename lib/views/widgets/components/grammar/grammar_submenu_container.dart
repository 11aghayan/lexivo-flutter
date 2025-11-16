import 'package:flutter/material.dart';
import 'package:lexivo_flutter/schema/grammar/grammar_submenu.dart';

class GrammarSubmenuContainer extends StatelessWidget {
  const GrammarSubmenuContainer({super.key, required this.submenu});

  final GrammarSubmenu submenu;

  @override
  Widget build(BuildContext context) {
    // TODO: Implememnt
    return Container(
      child: Text(submenu.header),
    );
  }
}
