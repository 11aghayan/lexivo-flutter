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

  Word.existing({
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

  Word({
    required this.type,
    required this.level,
    required this.gender,
    required this.native,
    required this.nativeDetails,
    required this.plural,
    required this.past1,
    required this.past2,
    required this.desc,
    required this.descDetails,
  }) : id = Uuid().v4(),
       practiceCountdown = 0;

  set setType(WordType value) => type = value;
  set setLevel(WordLevel value) => level = value;
  set setPracticeCountdown(int value) => practiceCountdown = value;
  set setGender(WordGender value) => gender = value;
  set setNative(String? value) => native = value;
  set setNativeDetails(String? value) => nativeDetails = value;
  set setPlural(String? value) => plural = value;
  set setPast1(String? value) => past1 = value;
  set setPast2(String? value) => past2 = value;
  set setDesc(String? value) => desc = value;
  set setDescDetails(String? value) => descDetails = value;

  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);

  Map<String, dynamic> toJson() => _$WordToJson(this);

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
}
