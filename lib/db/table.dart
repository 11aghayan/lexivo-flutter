import 'package:lexivo_flutter/db/query_util.dart';
import 'package:sqflite/sqflite.dart';

class Table {
  final Database _db;
  Batch? batch;

  Table(this._db);

  Future<List<Map<String, dynamic>>> selectQuery({
    required String table,
    List<SelectColumn> columns = const [SelectColumn(col: "*")],
    List<JoinTable> joinList = const [],
    QueryWhere? where,
  }) async {
    String cols = "";
    String joinOn = "";
    String onCondition = where == null ? "" : where.queryString();

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

    String sql = "SELECT $cols FROM $table $joinOn $onCondition;";

    return await _db.rawQuery(sql);
  }

  Table insertQuery({
    required String table,
    required List<List<InsertValue>> valuesList,
  }) {
    if (valuesList.isEmpty) {
      throw Exception("Empty valueList");
    }

    batch = batch ?? _db.batch();

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

    batch!.rawQuery("INSERT INTO $table ($cols) VALUES $valueRows;");
    return this;
  }

  Table updateQuery({
    required String table,
    required List<InsertValue> values,
    required QueryWhere where,
  }) {
    batch = batch ?? _db.batch();

    String cols = "";

    for (var val in values) {
      final data = val.data != null ? "'${val.data}'" : "NULL";
      cols += "${val.col} = $data,";
    }
    cols = cols.replaceRange(cols.length - 1, null, "");

    batch!.rawQuery("UPDATE $table SET $cols ${where.queryString()};");
    return this;
  }

  Table deleteQuery({required String table, required QueryWhere where}) {
    batch = batch ?? _db.batch();
    batch!.rawQuery("DELETE FROM $table ${where.queryString()};");
    return this;
  }

  Future<void> commit() async {
    if (batch == null) return;

    await batch!.commit();
    batch = null;
  }
}
