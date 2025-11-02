// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grammar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Grammar _$GrammarFromJson(Map<String, dynamic> json) => Grammar(
  json['id'] as String,
  json['header'] as String,
  (json['submenuList'] as List<dynamic>)
      .map((e) => GrammarSubmenu.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$GrammarToJson(Grammar instance) => <String, dynamic>{
  'id': instance.id,
  'header': instance.header,
  'submenuList': instance.submenuList,
};
