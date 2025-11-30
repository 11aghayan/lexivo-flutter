import 'package:lexivo_flutter/db/db.dart';
import 'package:lexivo_flutter/schema/enums/word_gender.dart';
import 'package:lexivo_flutter/schema/enums/word_level.dart';
import 'package:lexivo_flutter/schema/enums/word_type.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'word.g.dart';

@JsonSerializable()
class Word {
  final String id;

  WordType type;
  WordLevel level;
  int practiceCountdown;
  WordGender? gender;
  String? native;
  String? nativeDetails;
  String? plural;
  String? past1;
  String? past2;
  String? desc;
  String? descDetails;

  Word({
    required this.id,
    required this.type,
    required this.level,
    required this.practiceCountdown,
    required this.gender,
    required this.native,
    required this.nativeDetails,
    required this.plural,
    required this.past1,
    required this.past2,
    required this.desc,
    required this.descDetails,
  });

  Word.create()
    : id = Uuid().v4(),
      type = WordType.NOUN,
      level = WordLevel.A1,
      practiceCountdown = 0,
      gender = WordGender.MASCULINE,
      native = null,
      nativeDetails = null,
      plural = null,
      past1 = null,
      past2 = null,
      desc = null,
      descDetails = null;

  Word.copy(Word w)
    : id = w.id,
      type = w.type,
      level = w.level,
      practiceCountdown = w.practiceCountdown,
      gender = w.gender,
      native = w.native,
      nativeDetails = w.nativeDetails,
      plural = w.plural,
      past1 = w.past1,
      past2 = w.past2,
      desc = w.desc,
      descDetails = w.descDetails;

  void setType(WordType value) => type = value;
  void setLevel(WordLevel value) => level = value;
  void setGender(WordGender? value) => gender = value;
  set setNative(String? value) => native = value?.trim();
  set setNativeDetails(String? value) => nativeDetails = value?.trim();
  set setPlural(String? value) => plural = value?.trim();
  set setPast1(String? value) => past1 = value?.trim();
  set setPast2(String? value) => past2 = value?.trim();
  set setDesc(String? value) => desc = value?.trim();
  set setDescDetails(String? value) => descDetails = value?.trim();

  Future<void> resetPracticeCountdown(String dictId) async {
    practiceCountdown = 7;
    await Db.getDb().word.updateWord(dictId, this);
  }

  Future<void> decrementPracticeCountdown(String dictId) async {
    if (practiceCountdown > 0) {
      practiceCountdown--;
      await Db.getDb().word.updateWord(dictId, this);
    }
  }

  bool containsString(String string, bool strict) {
    string = string.trim();
    String nativeLocal = native ?? "";
    String pluralLocal = plural ?? "";
    String past1Local = past1 ?? "";
    String past2Local = past2 ?? "";
    String descLocal = desc ?? "";
    if (strict) {
      RegExp regex = RegExp(r'[ ,()]+');

      List<String> nativeSplit = nativeLocal.split(regex);
      List<String> pluralSplit = pluralLocal.split(regex);
      List<String> past1Split = past1Local.split(regex);
      List<String> past2Split = past2Local.split(regex);
      List<String> descSplit = descLocal.split(regex);
      for (List<String> data in [
        nativeSplit,
        pluralSplit,
        past1Split,
        past2Split,
        descSplit,
      ]) {
        if (data.any((elm) {
          return elm.trim().toLowerCase() == string;
        })) {
          return true;
        }
      }
      return false;
    } else {
      string = string.toLowerCase();
      for (String data in [
        nativeLocal,
        pluralLocal,
        past1Local,
        past2Local,
        descLocal,
      ]) {
        if (data.toLowerCase().contains(string)) {
          return true;
        }
      }
      return false;
    }
  }

  // JSON
  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);
  Map<String, dynamic> toJson() => _$WordToJson(this);
}
