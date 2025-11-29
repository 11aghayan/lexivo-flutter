import 'package:json_annotation/json_annotation.dart';
import 'package:lexivo_flutter/schema/grammar/grammar.dart';
import 'package:lexivo_flutter/schema/grammar/grammar_submenu.dart';
import 'package:lexivo_flutter/schema/language/language.dart';
import 'package:lexivo_flutter/schema/word/word.dart';
import 'package:lexivo_flutter/util/string_util.dart';
import 'package:uuid/uuid.dart';

part 'dictionary.g.dart';

@JsonSerializable()
class Dictionary {
  final String id;
  List<Word> allWords;
  List<Grammar> allGrammar;
  Language language;

  static List<Dictionary> allDictionaries = [];
  static get dictionariesCount => allDictionaries.length;

  Dictionary(this.id, this.language, this.allWords, this.allGrammar);
  Dictionary.create(this.language)
    : id = Uuid().v4(),
      allWords = [],
      allGrammar = [];

  // Dictionary methods

  int get allWordsCount => allWords.length;
  int get allGrammarCount => allGrammar.length;

  bool setLanguage(Language lang) {
    if (Dictionary._dictionaryExists(lang)) {
      return false;
    }
    language = lang;
    return true;
  }

  void delete() {
    allDictionaries.remove(this);
  }
  //

  // Word methods

  void addWords(List<Word> words) {
    for (Word word in words) {
      addWord(word);
    }
  }

  Word addWord(Word word) {
    _trimStringFieldsInWord(word);
    allWords.add(word);
    return word;
  }

  Word updateWord(Word word) {
    _trimStringFieldsInWord(word);
    allWords = allWords.map((w) => w.id == word.id ? word : w).toList();
    return word;
  }

  void deleteWord(Word word) {
    allWords.remove(word);
  }

  /// Trims and normalizes selected string fields on a Word instance.
  ///
  /// Applies `Strings.toTrimmedOrNull` to the following fields of [word]:
  /// `native`, `nativeDetails`, `plural`, `past1`, `past2`, `desc`, and
  /// `descDetails`. Whitespace is removed from both ends of each string, and
  /// any empty result is converted to `null`.
  ///
  /// The operation mutates the provided [word] in place and returns the same
  /// instance after modification.
  Word _trimStringFieldsInWord(Word word) {
    word.native = Strings.toTrimmedOrNull(word.native);
    word.nativeDetails = Strings.toTrimmedOrNull(word.nativeDetails);
    word.plural = Strings.toTrimmedOrNull(word.plural);
    word.past1 = Strings.toTrimmedOrNull(word.past1);
    word.past2 = Strings.toTrimmedOrNull(word.past2);
    word.desc = Strings.toTrimmedOrNull(word.desc);
    word.descDetails = Strings.toTrimmedOrNull(word.descDetails);
    return word;
  }
  //

  // Grammar methods
  void addGrammarList(List<Grammar> grammarList) {
    for (Grammar grammar in grammarList) {
      addGrammar(grammar);
    }
  }

  Grammar addGrammar(Grammar grammar) {
    _trimStringFieldsInGrammar(grammar);
    allGrammar.add(grammar);
    return grammar;
  }

  Grammar updateGrammar(Grammar grammar) {
    _trimStringFieldsInGrammar(grammar);
    allGrammar = allGrammar
        .map((g) => g.id == grammar.id ? grammar : g)
        .toList();
    return grammar;
  }

  void deleteGrammar(Grammar grammar) {
    allGrammar.remove(grammar);
  }

  Grammar _trimStringFieldsInGrammar(Grammar grammar) {
    grammar.header = grammar.header.trim();
    for (GrammarSubmenu submenu in grammar.submenuList) {
      submenu.header = submenu.header.trim();
      submenu.explanations = submenu.explanations.map((e) => e.trim()).toList();
      submenu.examples = submenu.examples.map((e) => e.trim()).toList();
    }
    return grammar;
  }
  //

  // Static methods

  static bool addDictionary(Dictionary dict) {
    if (_dictionaryExists(dict.language)) {
      return false;
    }
    allDictionaries.add(dict);
    return true;
  }

  static Dictionary getDictionaryAt(int index) {
    return allDictionaries.elementAt(index);
  }

  static List<Dictionary> getAllDictionaries() {
    return allDictionaries.toList();
  }

  static void setAllDictionaries(List<Dictionary> dicts) {
    allDictionaries = dicts;
  }

  static bool _dictionaryExists(Language lang) {
    return allDictionaries.any((elm) => elm.language.name == lang.name);
  }
  //

  // JSON
  factory Dictionary.fromJson(Map<String, dynamic> json) =>
      _$DictionaryFromJson(json);
  Map<String, dynamic> toJson() => _$DictionaryToJson(this);
}
