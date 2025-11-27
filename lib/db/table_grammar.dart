import 'package:lexivo_flutter/db/table.dart';

class TableGrammar extends Table {
  static final name = "grammar";
  static final pk = "id";
  static final colHeader = "header";

  TableGrammar(super._db);
}