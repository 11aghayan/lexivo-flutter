import 'package:lexivo_flutter/db/table.dart';

class TableGrammarSubmenu extends Table {
  static final name = "grammar_submenu";
  static final pk = "id";
  static final colGrammarId = "grammar_id";
  static final colHeader = "header";
  static final colExplanationsJsonArray = "explanations_json_array";
  static final colExamplesJsonArray = "examples_json_array";

  TableGrammarSubmenu(super._db);
}
