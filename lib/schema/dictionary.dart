import 'package:lexivo_flutter/schema/deletable_interface.dart';
import 'package:lexivo_flutter/schema/language.dart';
import 'package:lexivo_flutter/schema/word.dart';
import 'package:uuid/uuid.dart';

class Dictionary implements Deletable {
  final String id;
  final List<Word> _allWords;
  Language _language;

  static List<Dictionary> _allDictionaries = [];
  static get dictionariesCount => _allDictionaries.length;

  Dictionary.existing(this.id, this._language, this._allWords);
  Dictionary(this._language) : id = Uuid().v4(), _allWords = [];

  Language get language => _language;
  List<Word> get allWords => _allWords;
  int get allWordsCount => _allWords.length;

  bool setLanguage(Language lang) {
    if (Dictionary._dictionaryExists(lang)) {
      return false;
    }
    _language = lang;
    return true;
  }

  @override
  void delete() {
    _allDictionaries.remove(this);
  }

  static bool addDictionary(Dictionary dict) {
    if (_dictionaryExists(dict.language)) {
      return false;
    }
    _allDictionaries.add(dict);
    return true;
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

  static bool _dictionaryExists(Language lang) {
    return _allDictionaries.any(
      (elm) => elm.language.name == lang.name,
    );
  }
}
