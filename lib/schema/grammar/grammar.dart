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

  Grammar.create()
    : id = Uuid().v4(),
      header = "",
      submenuList = [GrammarSubmenu.create()];

  Grammar.copy(Grammar g)
    : id = g.id,
      header = g.header,
      submenuList = g.submenuList.map((gs) => GrammarSubmenu.copy(gs)).toList();

  int get submenuListLength => submenuList.length;

  void addSubmenu() {
    submenuList.add(GrammarSubmenu.create());
  }

  void deleteSubmenu(GrammarSubmenu submenu) {
    submenuList.remove(submenu);
  }

  // JSON
  factory Grammar.fromJson(Map<String, dynamic> json) =>
      _$GrammarFromJson(json);
  Map<String, dynamic> toJson() => _$GrammarToJson(this);
}
