import 'package:lexivo_flutter/constants/strings/strings.dart';

class KStrings_DE extends KStrings {
  @override
  final String loginSignUp = "Anmelden / Registrieren";
  @override
  final String settingsPageLabel = "Einstellungen";
  @override
  final String profilePageLabel = "Profil";
  @override
  final String dictionariesPageLabel = "Wörterbücher";
  @override
  final String words = "Wörter";
  @override
  final String deleteDialogTitle = "Sind Sie sicher Sie wollen zu löschen?";
  @override
  final String cancel = "Absagen";
  @override
  final String delete = "Löschen";
  @override
  final String save = "Speichern";
  @override
  final String addDictDialogTitle = "Wörterbuch hinzufügen";
  @override
  final String editDictDialogTitle = "Wörterbuch bearbeiten";
  @override
  final String addDictionaryDropdownHint = "Wörterbuch auswählen";
  @override
  final String noDictSelectedError = "Kein ausgewähltes Wörterbuch";
  @override
  final String dictionaryAddedSuccessfully = "Wörterbuch erfolgreich hinzugefügt";
  @override
  final String dictionaryLanguageUpdatedSuccessfully = "Wörterbuchsprache erfolgreich aktualisiert";
  @override
  final String duplicateDictionary = "Doppeltes Wörterbuch";
  @override
  final String dictionaryDeleted = "Wörterbuch gelöscht";

  @override
  String twoStepDelete(String text) {
    return "Geben Sie zum Löschen '${text.toLowerCase()}' ein";
  }
}
