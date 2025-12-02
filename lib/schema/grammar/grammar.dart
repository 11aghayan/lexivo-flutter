import 'package:json_annotation/json_annotation.dart';
import 'package:lexivo_flutter/schema/grammar/grammar_submenu.dart';
import 'package:lexivo_flutter/util/json_util.dart';
import 'package:uuid/uuid.dart';

part 'grammar.g.dart';

@JsonSerializable()
class Grammar {
  final String id;
  String header;
  List<GrammarSubmenu> submenuList;

  Grammar(this.id, this.header, this.submenuList);

  Grammar.create(String dictId)
    : header = "",
      id = createJoinedId(Uuid().v4(), dictId),
      submenuList = [] {
    submenuList = [GrammarSubmenu.create(id)];
  }

  Grammar.copy(Grammar g)
    : id = g.id,
      header = g.header,
      submenuList = g.submenuList.map((gs) => GrammarSubmenu.copy(gs)).toList();

  int get submenuListLength => submenuList.length;

  void setSubmenuList(List<GrammarSubmenu> submenuList) =>
      this.submenuList = submenuList;

  void addSubmenu() {
    submenuList.add(GrammarSubmenu.create(id));
  }

  void deleteSubmenu(GrammarSubmenu submenu) {
    submenuList.remove(submenu);
  }

  // JSON
  factory Grammar.fromJson(Map<String, dynamic> json, String dictId) =>
      _$GrammarFromJson(json, dictId);
  Map<String, dynamic> toJson() => _$GrammarToJson(this);
}
