import 'package:json_annotation/json_annotation.dart';
import 'package:lexivo_flutter/util/json_util.dart';
import 'package:uuid/uuid.dart';

part 'grammar_submenu.g.dart';

@JsonSerializable()
class GrammarSubmenu {
  final String id;
  String header;
  List<String> explanations;
  List<String> examples;

  GrammarSubmenu(this.id, this.header, this.explanations, this.examples);
  GrammarSubmenu.create(String grammarId)
    : id = createJoinedId(Uuid().v4(), grammarId),
      header = "",
      explanations = [""],
      examples = [""];
  GrammarSubmenu.copy(GrammarSubmenu gs)
    : id = gs.id,
      header = gs.header,
      explanations = gs.explanations.toList(),
      examples = gs.examples.toList();

  // JSON
  factory GrammarSubmenu.fromJson(Map<String, dynamic> json, String grammarId) =>
      _$GrammarSubmenuFromJson(json, grammarId);
  Map<String, dynamic> toJson() => _$GrammarSubmenuToJson(this);
}
