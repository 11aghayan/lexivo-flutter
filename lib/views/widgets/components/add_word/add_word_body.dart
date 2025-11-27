import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/schema/enums/word_gender.dart';
import 'package:lexivo_flutter/schema/enums/word_level.dart';
import 'package:lexivo_flutter/schema/enums/word_type.dart';
import 'package:lexivo_flutter/schema/word/word.dart';
import 'package:lexivo_flutter/util/snackbar_util.dart';
import 'package:lexivo_flutter/views/widgets/components/add_word/word_field_dropdown.dart';
import 'package:lexivo_flutter/views/widgets/components/btns/save_btn_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/custom_divider_widget.dart';
import 'package:lexivo_flutter/views/widgets/components/text_field/custom_text_field_widget.dart';

class AddWordBody extends StatefulWidget {
  const AddWordBody({
    super.key,
    required this.word,
    required this.saveInDictionary,
  });

  final Word? word;
  final Future<void> Function(Word) saveInDictionary;

  @override
  State<AddWordBody> createState() => _AddWordBodyState();
}

class _AddWordBodyState extends State<AddWordBody> {
  late Word tempWord;
  final strings = KStrings.getStringsForLang(appLangNotifier.value);
  bool emptyNativeError = false;
  bool emptyPluralError = false;
  bool emptyDescError = false;

  @override
  void initState() {
    tempWord = widget.word != null ? Word.copy(widget.word!) : Word.create();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final safeArea = MediaQuery.of(context).padding;
    final mainPadding = Sizes.mainPadding;

    final childrenTop = [
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

      // Gender
      if (tempWord.type == WordType.NOUN)
        WordFieldDropdown(
          setValue: (String? value) => setGender(value!),
          initialSelection: tempWord.gender.toString(),
          entries: WordGender.values,
          label: strings.gender,
        ),

      // Native
      if (tempWord.gender != WordGender.PLURAL)
        CustomTextFieldWidget(
          onChanged: setWord,
          label: strings.word,
          error: emptyNativeError,
          initialValue: tempWord.native,
        ),

      // Native details
      CustomTextFieldWidget(
        onChanged: setWordDetails,
        label: "${strings.wordDetails} (${strings.optional})",
        initialValue: tempWord.nativeDetails,
      ),

      // Plural
      if (tempWord.type == WordType.NOUN)
        CustomTextFieldWidget(
          onChanged: setPlural,
          error: emptyPluralError,
          initialValue: tempWord.plural,
          label:
              strings.plural +
              (tempWord.gender != WordGender.PLURAL
                  ? "(${strings.optional})"
                  : ""),
        ),

      // Past 1
      if (tempWord.type == WordType.VERB)
        CustomTextFieldWidget(
          onChanged: setPast1,
          label: "${strings.past} 1 (${strings.optional})",
          initialValue: tempWord.past1,
        ),

      //Past 2
      if (tempWord.type == WordType.VERB)
        CustomTextFieldWidget(
          onChanged: setPast2,
          label: "${strings.past} 2 (${strings.optional})",
          initialValue: tempWord.past2,
        ),
    ];

    final childrenBottom = [
      // Description
      CustomTextFieldWidget(
        onChanged: setDesc,
        label: strings.desc,
        error: emptyDescError,
        initialValue: tempWord.desc,
      ),

      // Description details
      CustomTextFieldWidget(
        onChanged: setDescDetails,
        label: "${strings.descDetails} (${strings.optional})",
        initialValue: tempWord.descDetails,
      ),
    ];

    return CustomScrollView(
      semanticChildCount: 4,
      slivers: [
        // Native segment
        SliverPadding(
          padding: EdgeInsets.fromLTRB(
            mainPadding,
            mainPadding + safeArea.top,
            mainPadding,
            0,
          ),
          sliver: SliverMasonryGrid.extent(
            maxCrossAxisExtent: Sizes.widgetMaxWidth,
            crossAxisSpacing: Sizes.gridViewItemsSpacing,
            mainAxisSpacing: Sizes.gridViewItemsSpacing,
            childCount: childrenTop.length,
            itemBuilder: (context, index) {
              return childrenTop[index];
            },
          ),
        ),

        // Divider
        SliverPadding(
          padding: EdgeInsets.symmetric(
            horizontal: Sizes.mainPadding,
            vertical: Sizes.gridViewItemsSpacing + 4,
          ),
          sliver: SliverToBoxAdapter(child: CustomDividerWidget()),
        ),

        // Description Segment
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.gridViewItemsSpacing),
          sliver: SliverMasonryGrid.extent(
            maxCrossAxisExtent: Sizes.widgetMaxWidth,
            crossAxisSpacing: Sizes.gridViewItemsSpacing,
            mainAxisSpacing: Sizes.gridViewItemsSpacing,
            childCount: 2,
            itemBuilder: (context, index) {
              return childrenBottom[index];
            },
          ),
        ),

        // Save button
        SliverPadding(
          padding: EdgeInsets.fromLTRB(
            mainPadding,
            Sizes.gridViewItemsSpacing + 8,
            mainPadding,
            mainPadding + safeArea.bottom,
          ),
          sliver: SliverToBoxAdapter(
            child: Center(child: SaveBtnWidget(onPressed: save)),
          ),
        ),
      ],
    );
  }

  void setType(String value) {
    WordType type = WordType.fromString(value);
    emptyNativeError = false;
    emptyPluralError = false;
    emptyDescError = false;
    tempWord.setType(type);
    if (type == WordType.NOUN) {
      tempWord.setGender(tempWord.gender ?? WordGender.MASCULINE);
    }
    if (mounted) {
      setState(() {});
    }
  }

  void setGender(String value) {
    WordGender? gender = WordGender.fromString(value);
    if (gender != WordGender.PLURAL) {
      emptyPluralError = false;
    } else {
      emptyNativeError = false;
    }
    tempWord.setGender(gender);
    if (mounted) {
      setState(() {});
    }
  }

  void setLevel(String value) {
    tempWord.setLevel(WordLevel.fromString(value));
  }

  void setWord(String value) {
    tempWord.native = value;
    if (emptyNativeError) {
      emptyNativeError = false;
      if (mounted) {
        setState(() {});
      }
    }
  }

  void setWordDetails(String value) {
    tempWord.nativeDetails = value;
  }

  void setPlural(String value) {
    tempWord.plural = value;
    if (emptyPluralError) {
      emptyPluralError = false;
      if (mounted) {
        setState(() {});
      }
    }
  }

  void setPast1(String value) {
    tempWord.past1 = value;
  }

  void setPast2(String value) {
    tempWord.past2 = value;
  }

  void setDesc(String value) {
    tempWord.desc = value;
    emptyDescError = false;
    if (emptyDescError) {
      if (mounted) {
        setState(() {});
      }
    }
  }

  void setDescDetails(String value) {
    tempWord.descDetails = value;
  }

  void save() async {
    if (necessaryFieldsError()) return;
    clearRedundantFields();
    try {
      await widget.saveInDictionary(tempWord);
      if (mounted) {
        String text = widget.word == null
            ? strings.wordAddedSuccessfully
            : strings.wordUpdatedSuccessfully;
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
        String text = widget.word == null
            ? strings.wordCouldNotBeAdded
            : strings.wordCouldNotBeUpdated;
        showOperationResultSnackbar(
          context: context,
          text: text,
          isSuccess: false,
        );
      }
    }
  }

  bool necessaryFieldsError() {
    if (tempWord.type == WordType.NOUN &&
        tempWord.gender == WordGender.PLURAL) {
      emptyPluralError =
          tempWord.plural == null || tempWord.plural!.trim().isEmpty;
    } else {
      emptyNativeError =
          tempWord.native == null || tempWord.native!.trim().isEmpty;
    }

    emptyDescError = tempWord.desc == null || tempWord.desc!.trim().isEmpty;

    if (mounted) {
      setState(() {});
    }

    return emptyDescError || emptyNativeError || emptyPluralError;
  }

  void clearRedundantFields() {
    if (tempWord.type != WordType.NOUN) {
      tempWord.gender = null;
      tempWord.plural = null;
    }

    if (tempWord.gender == WordGender.PLURAL) {
      tempWord.native = null;
    }

    if (tempWord.type != WordType.VERB) {
      tempWord.past1 = null;
      tempWord.past2 = null;
    }
  }
}
