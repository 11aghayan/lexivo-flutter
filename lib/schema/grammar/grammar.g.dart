// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grammar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Grammar _$GrammarFromJson(Map<String, dynamic> json, String dictId) {
  String id = createJoinedId(json['id'] as String, dictId);
  return Grammar(
    id,
    json['header'] as String,
    (json['submenuList'] as List<dynamic>)
        .map((e) => GrammarSubmenu.fromJson(e as Map<String, dynamic>, id))
        .toList(),
  );
}

Map<String, dynamic> _$GrammarToJson(Grammar instance) => <String, dynamic>{
  'id': extractSelfIdFromJoinedId(instance.id),
  'header': instance.header,
  'submenuList': instance.submenuList,
};
