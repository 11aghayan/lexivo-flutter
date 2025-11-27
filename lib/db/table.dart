import 'package:lexivo_flutter/db/query_util.dart';
import 'package:sqflite/sqflite.dart';

class Table {
  final Database _db;

  Table(this._db);

  Future<List<Map<String, dynamic>>> selectQuery({
    required String table,
    List<SelectColumn> columns = const [SelectColumn(col: "*")],
    SelectWhere? condition,
    List<JoinTable> joinList = const [],
  }) async {
    String cols = "";
    String joinOn = "";
    String where = "";

    for (int i = 0; i < columns.length; i++) {
      var col = columns[i];
      cols += col.queryString();
      if (i < columns.length - 1) {
        cols += ", ";
      }
    }

    for (var join in joinList) {
      joinOn += join.queryString(table);
    }

    if (condition != null) {
      where += "WHERE ";
      SelectWhere? cond = condition;
      do {
        where += cond!.queryString();

        if (cond.and != null) {
          where += " AND ";
          cond = cond.and;
        } else if (cond.or != null) {
          where += " OR ";
          cond = cond.or;
        } else {
          cond = null;
        }
      } while (cond != null);
    }

    String sql = "SELECT $cols FROM $table $joinOn $where;";

    return await _db.rawQuery(sql);
  }

  Future<void> insertQuery({
    required String table,
    required List<List<InsertValue>> valuesList,
  }) async {
    if (valuesList.isEmpty) {
      throw Exception("Empty valueList");
    }
    String cols = "";
    String valueRows = "";

    for (int i = 0; i < valuesList.length; i++) {
      final data = valuesList[i];
      String values = "(";

      for (int j = 0; j < data.length; j++) {
        var val = data[j];
        bool isLastElm = j == data.length - 1;
        if (i == 0) {
          cols += val.col;
          if (!isLastElm) {
            cols += ",";
          }
        }
        values += val.data != null ? "'${val.data}'" : "NULL";
        if (!isLastElm) {
          values += ",";
        } else {
          values += ")";
        }
      }

      valueRows += values;
      values = "(";
      if (i < valuesList.length - 1) {
        valueRows += ",";
      }
    }

    await _db.rawQuery("INSERT INTO $table ($cols) VALUES $valueRows;");
  }
}
