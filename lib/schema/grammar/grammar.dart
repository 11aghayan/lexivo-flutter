import 'package:json_annotation/json_annotation.dart';
import 'package:lexivo_flutter/schema/grammar/grammar_submenu.dart';
import 'package:uuid/uuid.dart';

part 'grammar.g.dart';

@JsonSerializable()
class Grammar {
  final String id;
  String header;
  List<GrammarSubmenu> submenuList;

  Grammar(this.id, this.header, this.submenuList) {
    if (submenuList.isEmpty) {
      throw Exception();
    }
  }
  Grammar.create(this.header, this.submenuList) : id = Uuid().v4() {
    if (submenuList.isEmpty) {
      throw Exception();
    }
  }

  // JSON
  factory Grammar.fromJson(Map<String, dynamic> json) => _$GrammarFromJson(json);
  Map<String, dynamic> toJson() => _$GrammarToJson(this);
}