import 'package:flutter/material.dart';
import 'package:lexivo_flutter/schema/word/word.dart';

class FlipCardBackWidget extends StatelessWidget {
  const FlipCardBackWidget({super.key, required this.word});

  final Word word;

  @override
  Widget build(BuildContext context) {
    // TODO: Implement
    return Container(
      color: Colors.blue,
      child: Center(child: Text(word.native ?? word.plural ?? "Error")),
    );
  }
}
