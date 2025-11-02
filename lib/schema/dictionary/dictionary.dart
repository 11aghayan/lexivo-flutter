import 'package:json_annotation/json_annotation.dart';
import 'package:lexivo_flutter/schema/grammar/grammar.dart';
import 'package:lexivo_flutter/schema/interface/deletable_interface.dart';
import 'package:lexivo_flutter/schema/language/language.dart';
import 'package:lexivo_flutter/schema/word/word.dart';
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
  Dictionary.create(this.language) : id = Uuid().v4(), allWords = [], allGrammar = [];

  // Dictionary methods

  int get allWordsCount => allWords.length;

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
  void addWords(List<Word> words) {
    allWords.addAll(words);
  }

  void addWord(Word word) {
    allWords.add(word);
  }

  void editWord(Word word) {
    allWords = allWords.map((w) => w.id == word.id ? word : w).toList();
  }

  void deleteWord(Word word) {
    allWords.remove(word);
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
