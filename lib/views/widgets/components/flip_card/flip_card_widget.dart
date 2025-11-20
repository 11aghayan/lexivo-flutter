import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';

class FlipCardWidget extends StatefulWidget {
  const FlipCardWidget({super.key});

  @override
  State<FlipCardWidget> createState() => _FlipCardWidgetState();
}

class _FlipCardWidgetState extends State<FlipCardWidget> {
  late final colors = ThemeColors.getThemeColors(context);
  final flipDurationMs = 300;
  final cardPadding = 10.0;
  bool isFlipped = false;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    
    return GestureDetector(
      child: AnimatedContainer(
          duration: Duration(milliseconds: flipDurationMs),
          height: min(500, screenSize.height - 120),
          width: min(350, screenSize.width - (Sizes.mainPadding * 2) - 40),
          padding: EdgeInsets.all(cardPadding),
          decoration: BoxDecoration(
            color: colors.canvas,
            borderRadius: BorderRadius.circular(Sizes.borderRadius_1),
            border: Border.all(width: 1, color: colors.outlinedBtnBorder),
          ),
          child: SizedBox(
            child: Column(
              children: [
                Text("Wordsdfijsdfoiljsdoilfjsdoifjsdiofjsidojfasoidjasoidjsaoidjasoidjass")
              ],
            ),
          ),
        ),
    );
  }

  void flip() {
    isFlipped = true;
    setState(() {});
  }
}
