// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Word _$WordFromJson(Map<String, dynamic> json) => Word(
  type: $enumDecode(_$WordTypeEnumMap, json['type']),
  level: $enumDecode(_$WordLevelEnumMap, json['level']),
  gender: $enumDecodeNullable(_$WordGenderEnumMap, json['gender']),
  native: json['native'] as String?,
  nativeDetails: json['nativeDetails'] as String?,
  plural: json['plural'] as String?,
  past1: json['past1'] as String?,
  past2: json['past2'] as String?,
  desc: json['desc'] as String?,
  descDetails: json['descDetails'] as String?,
)..practiceCountdown = (json['practiceCountdown'] as num).toInt();

Map<String, dynamic> _$WordToJson(Word instance) => <String, dynamic>{
  'type': _$WordTypeEnumMap[instance.type]!,
  'level': _$WordLevelEnumMap[instance.level]!,
  'practiceCountdown': instance.practiceCountdown,
  'gender': _$WordGenderEnumMap[instance.gender],
  'native': instance.native,
  'nativeDetails': instance.nativeDetails,
  'plural': instance.plural,
  'past1': instance.past1,
  'past2': instance.past2,
  'desc': instance.desc,
  'descDetails': instance.descDetails,
};

const _$WordTypeEnumMap = {
  WordType.NOUN: 'NOUN',
  WordType.ADJ_ADV: 'ADJ_ADV',
  WordType.VERB: 'VERB',
  WordType.PRON_PREP: 'PRON_PREP',
  WordType.QUESTION_WORD: 'QUESTION_WORD',
  WordType.NUMERAL: 'NUMERAL',
  WordType.PHRASE: 'PHRASE',
};

const _$WordLevelEnumMap = {
  WordLevel.A1: 'A1',
  WordLevel.A2: 'A2',
  WordLevel.B1: 'B1',
  WordLevel.B2: 'B2',
  WordLevel.C1: 'C1',
  WordLevel.C2: 'C2',
};

const _$WordGenderEnumMap = {
  WordGender.MASCULINE: 'MASCULINE',
  WordGender.FEMININE: 'FEMININE',
  WordGender.NEUTER: 'NEUTER',
  WordGender.PERSONAL: 'PERSONAL',
  WordGender.PLURAL: 'PLURAL',
  WordGender.NO_GENDER: 'NO_GENDER',
};
