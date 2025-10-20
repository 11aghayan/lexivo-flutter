import 'package:lexivo_flutter/schema/language.dart';
import 'package:lexivo_flutter/schema/word.dart';
import 'package:uuid/uuid.dart';

class Dictionary {
  final String id;
  final List<Word> _allWords;
  Language _language;

  static List<Dictionary> _allDictionaries = [];

  Dictionary.existing(this._language, this._allWords) : id = Uuid().v4();
  Dictionary(this._language) : id = Uuid().v4(), _allWords = [];

  Language get language => _language;
  List<Word> get allWords => _allWords;
  int get allWordsCount => _allWords.length;

  void setLanguage(Language lang) {
    _language = lang;
  }

  static void addDictionary(Dictionary dict) {

    _allDictionaries.add(dict);
  }

  static void deleteDictionary(Dictionary dict) {
    _allDictionaries.remove(dict);
  }

  static void deleteDictionaryAt(int index) {
    _allDictionaries.removeAt(index);
  }

  static Dictionary getDictionaryAt(int index) {
    return _allDictionaries.elementAt(index);
  }

  static List<Dictionary> getAllDictionaries() {
    return _allDictionaries.toList();
  }

  static void setAllDictionaries(List<Dictionary> dicts) {
    _allDictionaries = dicts;
  }
}