class SelectWhere {
  final String col;
  final String equals;
  final SelectWhere? or;
  final SelectWhere? and;

  SelectWhere({required this.col, required this.equals, this.or, this.and}) {
    if (or != null && and != null) {
      throw Exception("Either 'or' or 'and' may be provided. Provided both");
    }
  }

  String queryString() {
    return "$col = $equals";
  }
}

class JoinTable {
  final String table;
  final String thisCol;
  final String withCol;

  JoinTable({
    required this.table,
    required this.thisCol,
    required this.withCol,
  });

  String queryString(String thisTable) {
    return "FULL OUTER JOIN $table ON $table.id = $withCol";
  }
}

class SelectColumn {
  final String col;
  final String? as;

  const SelectColumn({required this.col, this.as});

  String queryString() {
    String as = this.as != null ? " as ${this.as}" : "";
    return "$col$as";
  }
}

class InsertValue {
  final String col;
  final String? data;

  InsertValue({required this.col, required this.data});
}
