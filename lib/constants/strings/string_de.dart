import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/schema/enums/word_gender.dart';
import 'package:lexivo_flutter/schema/enums/word_type.dart';

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
  final String dictionaryAddedSuccessfully =
      "Wörterbuch erfolgreich hinzugefügt";
  @override
  final String dictionaryLanguageUpdatedSuccessfully =
      "Wörterbuchsprache erfolgreich aktualisiert";
  @override
  final String duplicateDictionary = "Doppeltes Wörterbuch";
  @override
  final String dictionaryDeleted = "Wörterbuch gelöscht";
  @override
  final String noDictionaries = "Keine Wörterbücher";
  @override
  final String wordsPageLabel = "Wörter";
  @override
  final String grammarsPageLabel = "Grammatik";
  @override
  final String practicePageLabel = "Üben";
  @override
  final String noWords = "Keine Wörter";
  @override
  final String search = "Suchen";
  @override
  final String level = "Niveau";
  @override
  final String gender = "Geschlecht";
  @override
  final String type = "Wortart";
  @override
  final String filters = "Filter";
  @override
  final String wordsExportedSuccessfully = "Wörter erfolgreich exportiert";
  @override
  final String wordsImportedSuccessfully = "Wörter erfolgreich importiert";
  @override
  final String wordsCouldNotBeImported = "Wörter konnten nicht importiert werden";
   @override
  final String wordAddedSuccessfully = "Wort erfolgreich hinzugefügt";
  @override
  final String wordCouldNotBeAdded = "Wort konnte nicht hinzugefügt werden";
  @override
  final String wordUpdatedSuccessfully = "Wort wurde erfolgreich aktualisiert";
  @override
  final String wordCouldNotBeUpdated = "Word konnte nicht aktualisiert werden";
  @override
  final String addWordPageLabel = "Wort hinzufügen";
  @override
  final String word = "Wort";
  @override
  final String updateWordPageLabel = "Wort aktualisieren";
  @override
  final String wordDetails = "Wortdetails";
  @override
  final String plural = "Plural";
  @override
  final String past = "Vergangenheit";
  @override
  final String desc = "Beschreibung";
  @override
  final String descDetails = "Beschreibung Details";
  @override
  final String optional = "Optional";
  @override
  final String emptyTextFieldError = "Das Feld darf nicht leer sein";
  @override
  final String noWordsToExport = "Keine Wöret im Wörterbuch zum exportieren";
  @override
  final String noGrammarToExport = "Keine Grammatik im Wörterbuch zum exportieren";
    @override
  final String noGrammar = "Keine Grammatik";

  @override
  String twoStepDelete(String text) {
    return "Geben Sie zum Löschen '${text.toLowerCase()}' ein";
  }

  @override
  String wordTypeToString(WordType wordType) {
    return switch (wordType) {
      WordType.NOUN => "Nomen",
      WordType.ADJ_ADV => "Adjektiv/Adverb",
      WordType.VERB => "Verb",
      WordType.PRON_PREP => "Pronomen/Präposition",
      WordType.QUESTION_WORD => "Fragewort",
      WordType.NUMERAL => "Zahlwort",
      _ => "Ausdruck",
    };
  }

  @override
  String wordGenderToString(WordGender wordGender) {
    return switch (wordGender) {
      WordGender.MASCULINE => "männlich",
      WordGender.FEMININE => "weiblich",
      WordGender.NEUTER => "neuter",
      WordGender.PERSONAL => "persönlich",
      WordGender.PLURAL => "plural",
      _ => "kein Geschlecht",
    };
  }
}
