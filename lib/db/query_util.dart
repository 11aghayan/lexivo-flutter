class QueryWhere {
  final String col;
  final QueryWhereOperator operator;
  final String value;
  final QueryWhere? or;
  final QueryWhere? and;

  QueryWhere({
    required this.col,
    required this.operator,
    required this.value,
    this.or,
    this.and,
  }) {
    if (or != null && and != null) {
      throw Exception("Either 'or' or 'and' may be provided. Provided both");
    }
  }

  String queryString({ bool head = true }) {
    String where = head ? "WHERE " : "";
    where = "$where $col ${operator.toString()} '$value'";

    if (and != null) {
      return "$where AND ${and!.queryString(head: false)}";
    }

    if (or != null) {
      return "$where OR ${or!.queryString(head: false)}";
    }

    return where;
  }
}

enum QueryWhereOperator {
  EQUALS,
  GT,
  LT;

  @override
  String toString() {
    return switch (this) {
      GT => ">",
      LT => "<",
      _ => "=",
    };
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
