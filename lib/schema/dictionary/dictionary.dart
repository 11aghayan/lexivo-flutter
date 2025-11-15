import 'package:json_annotation/json_annotation.dart';
import 'package:lexivo_flutter/schema/grammar/grammar.dart';
import 'package:lexivo_flutter/schema/grammar/grammar_submenu.dart';
import 'package:lexivo_flutter/schema/interface/deletable_interface.dart';
import 'package:lexivo_flutter/schema/language/language.dart';
import 'package:lexivo_flutter/schema/word/word.dart';
import 'package:lexivo_flutter/util/string_util.dart';
import 'package:uuid/uuid.dart';

part 'dictionary.g.dart';

@JsonSerializable()
class Dictionary implements Deletable {
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

  @override
  void delete() {
    allDictionaries.remove(this);
  }
  //

  // Word methods

  /// Adds multiple [Word] instances to the dictionary.
  ///
  /// Iterates over [words] and adds each element by delegating to [addWord],
  /// preserving the order of the provided list. If [words] is empty, no changes
  /// are made to the dictionary.
  ///
  /// Parameters:
  /// - [words]: The list of [Word] objects to add (expected to be non-null).
  ///
  /// Complexity: O(n) where n is the number of words in [words].
  ///
  /// Example:
  /// ```dart
  /// addWords([word1, word2, word3]);
  /// ```
  void addWords(List<Word> words) {
    for (Word word in words) {
      addWord(word);
    }
  }

  /// Trims string fields on [word] and adds it to the internal word collection.
  ///
  /// This method first calls `_trimStringFieldsInWord(word)` to remove leading and
  /// trailing whitespace from any string properties of the provided [Word] object,
  /// then appends the (mutated) instance to `allWords`.
  ///
  /// Parameters:
  /// - [word]: The Word instance to sanitize and add. This method mutates the
  ///   provided object.
  ///
  /// Side effects:
  /// - The passed [word] is modified (its string fields are trimmed).
  /// - The `allWords` collection is expanded with the provided [word].
  void addWord(Word word) {
    _trimStringFieldsInWord(word);
    allWords.add(word);
  }

  /// Trims string fields on the provided [word] and updates the in-memory
  /// collection by replacing the existing entry that has the same `id`.
  ///
  /// This calls [_trimStringFieldsInWord(word)] before performing the update.
  /// If an item in [allWords] has `id == word.id`, that item is replaced with
  /// the provided [word] instance; otherwise [allWords] remains unchanged.
  /// The list order is preserved.
  ///
  /// [word]: The Word instance whose trimmed version should replace the existing
  /// entry. Must have a valid `id`.
  ///
  /// Time complexity: O(n) in the number of items in [allWords].
  void updateWord(Word word) {
    _trimStringFieldsInWord(word);
    allWords = allWords.map((w) => w.id == word.id ? word : w).toList();
  }

  /// Removes [word] from the dictionary's collection of words.
  ///
  /// If [word] is present in `allWords`, it will be removed. If [word] is not
  /// found, the collection remains unchanged. Removal uses the equality semantics
  /// of the `Word` type (i.e., `==`), so ensure `Word` implements equality as
  /// expected.
  ///
  /// Parameters:
  /// - [word]: The `Word` instance to remove.
  ///
  /// This method does not return a value.
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

  void addGrammar(Grammar grammar) {
    _trimStringFieldsInGrammar(grammar);
    allGrammar.add(grammar);
  }

  void updateGrammar(Grammar grammar) {
    _trimStringFieldsInGrammar(grammar);
    allGrammar = allGrammar.map((g) => g.id == grammar.id ? grammar : g).toList();
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
