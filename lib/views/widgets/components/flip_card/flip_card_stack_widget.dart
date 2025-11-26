import 'package:flutter/material.dart';
import 'package:lexivo_flutter/schema/word/word.dart';
import 'package:lexivo_flutter/views/widgets/components/flip_card/flip_card_widget.dart';

class FlipCardStackWidget extends StatefulWidget {
  const FlipCardStackWidget({
    super.key,
    required this.words,
    required this.directionDescToWord,
    required this.setBgRedOpacity,
    required this.setBgGreenOpacity,
  });

  final List<Word> words;
  final bool directionDescToWord;
  final void Function(double, bool) setBgRedOpacity;
  final void Function(double, bool) setBgGreenOpacity;

  @override
  State<FlipCardStackWidget> createState() => _FlipCardStackWidgetState();
}

class _FlipCardStackWidgetState extends State<FlipCardStackWidget> {
  int currentWordIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(widget.words.length, (index) {
        final word = widget.words[index];
        final topIndex = widget.words.length - currentWordIndex - 1;
        return Center(
          child: AnimatedScale(
            key: ValueKey(word.id),
            duration: Duration(milliseconds: 150),
            scale: topIndex <= index ? 1 : 0.5,
            child: FlipCardWidget(
              word: word,
              directionDescToWord: widget.directionDescToWord,
              switchCard: switchCard,
              setBgGreenOpacity: widget.setBgGreenOpacity,
              setBgRedOpacity: widget.setBgRedOpacity,
              isActive: topIndex == index,
            ),
          ),
        );
      }),
    );
  }

  void switchCard() {
    currentWordIndex++;
    _updateState();
  }

  void _updateState() {
    if (!mounted) return;
    setState(() {});
  }
}
