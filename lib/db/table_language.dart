import 'package:lexivo_flutter/db/table.dart';

class TableLanguage extends Table {
  static final name = "language";
  static final pk = "name";
  static final colNameOriginal = "nameOriginal";

  TableLanguage(super._db);
}