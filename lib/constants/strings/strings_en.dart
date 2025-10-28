import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/schema/enums/word_gender.dart';
import 'package:lexivo_flutter/schema/enums/word_type.dart';

class KStrings_EN extends KStrings {
  @override
  final String loginSignUp = "Login / Sign Up";
  @override
  final String settingsPageLabel = "Settings";
  @override
  final String profilePageLabel = "Profile";
  @override
  final String dictionariesPageLabel = "Dictionaries";
  @override
  final String words = "Words";
  @override
  final String deleteDialogTitle = "Are you sure you want to delete?";
  @override
  final String cancel = "Cancel";
  @override
  final String delete = "Delete";
  @override
  final String save = "Save";
  @override
  final String addDictDialogTitle = "Add Dictionary";
  @override
  final String editDictDialogTitle = "Edit Dictionary";
  @override
  final String addDictionaryDropdownHint = "Choose dictionary";
  @override
  final String noDictSelectedError = "No selected dictionary";
  @override
  final String dictionaryAddedSuccessfully = "Dictionary added successfully";
  @override
  final String dictionaryLanguageUpdatedSuccessfully =
      "Dictionary language updated successfully";
  @override
  final String duplicateDictionary = "Duplicate dictionary";
  @override
  final String dictionaryDeleted = "Dictionary deleted";
  @override
  final String noDictionaries = "No dictionaries";
  @override
  final String wordsPageLabel = "Words";
  @override
  final String grammarsPageLabel = "Grammar";
  @override
  final String activitiesPageLabel = "Activities";
  @override
  final String noWords = "No Words";
  @override
  final String search = "Search";
  @override
  final String levelFiltersHeader = "Level";
  @override
  final String genderFiltersHeader = "Gender";
  @override
  final String typeFiltersHeader = "Type";
  @override
  final String filters = "Filters";

  @override
  String twoStepDelete(String text) {
    return "Type '${text.toLowerCase()}' to delete";
  }

  @override
  String wordTypeToString(WordType wordType) {
    return switch (wordType) {
      WordType.NOUN => "noun",
      WordType.ADJ_ADV => "adjective/adverb",
      WordType.VERB => "verb",
      WordType.PRON_PREP => "pronoun/preposition",
      WordType.QUESTION_WORD => "question word",
      WordType.NUMERAL => "numeral",
      _ => "phrase",
    };
  }

  @override
  String wordGenderToString(WordGender wordGender) {
    return wordGender.name.toString().split("_").join(" ").toLowerCase();
  }
}
