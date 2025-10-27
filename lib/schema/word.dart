import 'package:lexivo_flutter/schema/enums/word_gender.dart';
import 'package:lexivo_flutter/schema/enums/word_level.dart';
import 'package:lexivo_flutter/schema/enums/word_type.dart';
import 'package:uuid/uuid.dart';

class Word {
  final String id;

  WordType _type;
  WordLevel _level;
  int _practiceCountdown;
  WordGender? _gender;
  String? _native;
  String? _nativeDetails;
  String? _plural;
  String? _past1;
  String? _past2;
  String? _desc;
  String? _descDetails;

  Word.existing(
    this.id,
    this._type,
    this._level,
    this._practiceCountdown,
    this._gender,
    this._native,
    this._nativeDetails,
    this._plural,
    this._past1,
    this._past2,
    this._desc,
    this._descDetails,
  );

  Word(
    this._type,
    this._level,
    this._gender,
    this._native,
    this._nativeDetails,
    this._plural,
    this._past1,
    this._past2,
    this._desc,
    this._descDetails,
  ) : id = Uuid().v4(),
      _practiceCountdown = 0;

  WordType get type => _type;
  set type(WordType value) => _type = value;

  WordLevel get level => _level;
  set level(WordLevel value) => _level = value;

  int get practiceCountdown => _practiceCountdown;
  set practiceCountdown(int value) => _practiceCountdown = value;

  WordGender? get gender => _gender;
  set gender(WordGender value) => _gender = value;

  String? get native => _native;
  set native(String? value) => _native = value;

  String? get nativeDetails => _nativeDetails;
  set nativeDetails(String? value) => _nativeDetails = value;

  String? get plural => _plural;
  set plural(String? value) => _plural = value;

  String? get past1 => _past1;
  set past1(String? value) => _past1 = value;

  String? get past2 => _past2;
  set past2(String? value) => _past2 = value;

  String? get desc => _desc;
  set desc(String? value) => _desc = value;

  String? get descDetails => _descDetails;
  set descDetails(String? value) => _descDetails = value;

  bool containsString(String string, bool strict) {
    string = string.trim();
    String native = _native ?? "";
    String plural = _plural ?? "";
    String past1 = _past1 ?? "";
    String past2 = _past2 ?? "";
    String desc = _desc ?? "";
    if (strict) {
      RegExp regex = RegExp(r'[ ,()]+');

      List<String> nativeSplit = native.split(regex);
      List<String> pluralSplit = plural.split(regex);
      List<String> past1Split = past1.split(regex);
      List<String> past2Split = past2.split(regex);
      List<String> descSplit = desc.split(regex);

      for (List<String> data in [
        nativeSplit,
        pluralSplit,
        past1Split,
        past2Split,
        descSplit,
      ]) {
        if (data.any((elm) => elm.trim() == string)) {
          return true;
        }
      }
      return false;
    } else {
      string = string.toLowerCase();
      for (String data in [native, plural, past1, past2, desc]) {
        if (data.toLowerCase().contains(string)) {
          return true;
        }
      }
      return false;
    }
  }
}
