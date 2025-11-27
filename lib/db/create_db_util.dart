String createTableQuery(String name, {required List<SqlTableColumn> columns}) {
  String? primaryKey;
  String query = "";

  for (var col in columns) {
    var notNull = col.notNull ? "NOT NULL" : "";
    var pk = col.primaryKey ? "PRIMARY KEY" : "";
    if (col.primaryKey) {
      if (primaryKey != null) {
        throw Exception("There can be only one primary key; $primaryKey was already defined as the PRIMARY KEY");
      }
      primaryKey = col.name;
    }
    
    query += "${col.name} ${col.type.getSqlStringDataType()} $notNull $pk,";
  }

  query = query.replaceRange(query.length - 1, null, "");

  return "CREATE TABLE IF NOT EXISTS $name ($query);";
}

class SqlTableColumn {
  final String name;
  final SqlColumnType type;
  final bool primaryKey;
  final bool notNull;
  final ForeignKeyReference? reference;

  SqlTableColumn({
    required this.name,
    required this.type,
    this.primaryKey = false,
    this.notNull = false,
    this.reference,
  });
}

class ForeignKeyReference {
  final String referenceTable;
  final String referenceTableColumn;

  ForeignKeyReference({
    required this.referenceTable,
    required this.referenceTableColumn,
  });
}

enum SqlColumnType {
  ID,
  INT,
  TEXT,
  SHORT_TEXT;

  String getSqlStringDataType() {
    return switch (this) {
      ID => "VARCHAR(50)",
      INT => "INT",
      SHORT_TEXT => "VARCHAR(100)",
      _ => "TEXT",
    };
  }
}
