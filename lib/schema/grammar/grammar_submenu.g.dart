// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grammar_submenu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GrammarSubmenu _$GrammarSubmenuFromJson(
  Map<String, dynamic> json,
  String grammarId,
) => GrammarSubmenu(
  createJoinedId(json['id'] as String, grammarId),
  json['header'] as String,
  (json['explanations'] as List<dynamic>).map((e) => e as String).toList(),
  (json['examples'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$GrammarSubmenuToJson(GrammarSubmenu instance) =>
    <String, dynamic>{
      'id': extractSelfIdFromJoinedId(instance.id),
      'header': instance.header,
      'explanations': instance.explanations,
      'examples': instance.examples,
    };
