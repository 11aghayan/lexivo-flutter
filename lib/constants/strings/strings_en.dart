import 'package:lexivo_flutter/constants/strings/strings.dart';

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
  final String dictionaryLanguageUpdatedSuccessfully = "Dictionary language updated successfully";
  @override
  final String duplicateDictionary = "Duplicate dictionary";
  @override
  final String dictionaryDeleted = "Dictionary deleted";

  @override
  String twoStepDelete(String text) {
    return "Type '${text.toLowerCase()}' to delete";
  }
}