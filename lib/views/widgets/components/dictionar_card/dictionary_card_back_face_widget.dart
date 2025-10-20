import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/schema/dictionary.dart';

class DictionaryCardBackFaceWidget extends StatelessWidget {
  const DictionaryCardBackFaceWidget({super.key, required this.dictionary});

  final Dictionary dictionary;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(Sizes.borderRadius_1),
      ),
      // TODO: 
      child: Row(),
    );
  }
}
