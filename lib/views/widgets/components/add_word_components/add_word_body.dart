import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/schema/enums/word_gender.dart';
import 'package:lexivo_flutter/schema/enums/word_level.dart';
import 'package:lexivo_flutter/schema/enums/word_type.dart';
import 'package:lexivo_flutter/schema/word/word.dart';
import 'package:lexivo_flutter/views/widgets/components/add_word_components/word_field_dropdown.dart';

class AddWordBody extends StatefulWidget {
  const AddWordBody({super.key, required this.word});

  final Word? word;

  @override
  State<AddWordBody> createState() => _AddWordBodyState();
}

class _AddWordBodyState extends State<AddWordBody> {
  late Word tempWord;
  final strings = KStrings.getStringsForLang(appLangNotifier.value);

  @override
  void initState() {
    tempWord = widget.word != null ? Word.copy(widget.word!) : Word.create();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var safeArea = MediaQuery.of(context).padding;
    
    List<Widget> children = [
      // Level
      WordFieldDropdown(
        setValue: (String? value) => setLevel(value!),
        initialSelection: tempWord.level.toString(),
        entries: WordLevel.values,
        label: strings.level,
      ),

      // Type
      WordFieldDropdown(
        setValue: (String? value) => setType(value!),
        initialSelection: tempWord.type.toString(),
        entries: WordType.values,
        label: strings.type,
      ),

      if (tempWord.type == WordType.NOUN)
        WordFieldDropdown(
          setValue: (String? value) => setGender(value!),
          initialSelection: tempWord.gender.toString(),
          entries: WordGender.values,
          label: strings.gender,
        ),
    ];

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.fromLTRB(Sizes.mainPadding, Sizes.mainPadding + safeArea.top, Sizes.mainPadding, Sizes.mainPadding + safeArea.bottom),
          sliver: SliverMasonryGrid.extent(
            maxCrossAxisExtent: 500,
            crossAxisSpacing: Sizes.addWordPageGridSpacing,
            mainAxisSpacing: Sizes.addWordPageGridSpacing,
            childCount: children.length,
            itemBuilder: (context, index) {
              return children[index];
            },
          ),
        ),
      ],
    );
  }

  void setType(String value) {
    setState(() {
      tempWord.setType(WordType.fromString(value));
    });
  }

  void setGender(String value) {
    tempWord.setGender(WordGender.fromString(value));
  }

  void setLevel(String value) {
    tempWord.setLevel(WordLevel.fromString(value));
  }

  void save() {
    // TODO: Check if all neccessary fields are there
    // TODO: clear all unneccessary fields
    // TODO: If new save to dictionary, and memory
    // TODO: Else update all the fields of the word and update memory
  }
}
