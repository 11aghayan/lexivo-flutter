import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/schema/enums/word_gender.dart';
import 'package:lexivo_flutter/schema/enums/word_type.dart';
import 'package:lexivo_flutter/util/string_util.dart';

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
  final String practicePageLabel = "Practice";
  @override
  final String noWords = "No words";
  @override
  final String search = "Search";
  @override
  final String level = "Level";
  @override
  final String gender = "Gender";
  @override
  final String type = "Type";
  @override
  final String filters = "Filters";
  @override
  final String wordsExportedSuccessfully = "Words exported successfully";
  @override
  final String wordsImportedSuccessfully = "Words imported successfully";
  @override
  final String wordsCouldNotBeImported = "Words could not be imported";
  @override
  final String wordAddedSuccessfully = "Word added successfully";
  @override
  final String wordCouldNotBeAdded = "Word could not be added";
  @override
  final String wordUpdatedSuccessfully = "Word updated successfully";
  @override
  final String wordCouldNotBeUpdated = "Word could not be updated";
  @override
  final String addWordPageLabel = "Add word";
  @override
  final String updateWordPageLabel = "Update word";
  @override
  final String word = "Word";
  @override
  final String wordDetails = "Word details";
  @override
  final String plural = "Plural";
  @override
  final String past = "Past";
  @override
  final String desc = "Description";
  @override
  final String descDetails = "Description details";
  @override
  final String optional = "Optional";
  @override
  final String emptyTextFieldError = "Field cannot be empty";
  @override
  final String noWordsToExport = "No words in dictionary to export";
  @override
  final String noGrammarToExport = "No grammar in dictionary to export";
  @override
  final String noGrammar = "No grammar";
  @override
  final String addGrammarPageLabel = "Add grammar";
  @override
  final String header = "Header";
  @override
  final String row = "Row";
  @override
  final String explanations = "Explanations";
  @override
  final String examples = "Examples";
  @override
  final String submenu = "Submenu";
  @override
  final String grammarAddedSuccessfully = "Grammar added successfully";
  @override
  final String grammarCouldNotBeAdded = "Grammar could not be added";
  @override
  final String grammarUpdatedSuccessfully = "Grammar updated successfully";
  @override
  final String grammarCouldNotBeUpdated = "Grammar could not be updated";
  @override
  final String grammar = "grammar";
  @override
  final String grammarExportedSuccessfully = "Grammar exported successfully";
  @override
  final String grammarImportedSuccessfully = "Grammar imported successfully";
  @override
  final String grammarCouldNotBeImported = "Grammar could not be imported";
  @override
  final String startPracticeBtnText = "Go";
  @override
  final String wordToDesc = "Word to description";
  @override
  final String descToWord = "Description to word";
  @override
  final String practice = "Practice";
  @override
  final String exam = "Exam";
  @override
  final String noWordsMatchingTheFilters = "No words matching the filters";
  @override
  final String startAgain = "Start again";
  @override
  final String wordsCount = "Words count";
  @override
  final String dictionaryCouldNotBeImported =
      "Dictionary could not be imported";
  @override
  final String dictionaryImportedSuccessfully =
      "Dictionary imported successfully";
  @override
  final String dictionaryCouldNotBeExported =
      "Dictionary could not be exported";
  @override
  final String dictionaryExportedSuccessfully =
      "Dictionary exported successfully";
  @override
  final String dictionary = "dictionary";
  @override
  final String dictionaryUploadWarning =
      "The dictionary data on the server will be overwritten with the uploaded data";
  @override
  final String dictionaryDownloadWarning =
      "The dictionary data on the device will be overwritten with the downloaded data";
  @override
  final String dictUploadOptionQuestion =
      "Do you want to export the dictionary as a JSON file or upload to the cloud?";
  @override
  final String exportAsJson = "Export as JSON";
  @override
  final String uploadToCloud = "Upload to cloud";
  @override
  final String somethingWentWrong = "Something went wrong";
  @override
  final String textContinue = "Continue";
  @override
  final String warning = "Warning";

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

  @override
  String duplicateDictImportWarningText(String dictLang) {
    return "You already have the dictionary \"${Strings.toCapitalized(dictLang)}\". If you press \"Continue\" the missing words and grammar of the imported dictionary will be added to the existing one";
  }
}
