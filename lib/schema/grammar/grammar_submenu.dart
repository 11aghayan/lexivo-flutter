import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'grammar_submenu.g.dart';

@JsonSerializable()
class GrammarSubmenu {
  final String id;
  String header;
  List<String> explanations;
  List<String> examples;

  GrammarSubmenu(this.id, this.header, this.explanations, this.examples);
  GrammarSubmenu.create(this.header, this.explanations, this.examples)
    : id = Uuid().v4();
  GrammarSubmenu.copy(GrammarSubmenu gs)
    : id = gs.id,
      header = gs.header,
      explanations = gs.explanations.toList(),
      examples = gs.examples.toList();

  // JSON
  factory GrammarSubmenu.fromJson(Map<String, dynamic> json) =>
      _$GrammarSubmenuFromJson(json);
  Map<String, dynamic> toJson() => _$GrammarSubmenuToJson(this);
}
