// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dictionary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dictionary _$DictionaryFromJson(Map<String, dynamic> json) => Dictionary(
  json['id'] as String,
  Language.fromJson(json['language'] as Map<String, dynamic>),
  (json['allWords'] as List<dynamic>)
      .map((e) => Word.fromJson(e as Map<String, dynamic>))
      .toList(),
  (json['allGrammar'] as List<dynamic>)
      .map((e) => Grammar.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$DictionaryToJson(Dictionary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'allWords': instance.allWords,
      'allGrammar': instance.allGrammar,
      'language': instance.language,
    };
