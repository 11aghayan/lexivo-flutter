import 'package:lexivo_flutter/db/query_util.dart';
import 'package:sqflite/sqflite.dart';

class DbQuery {
  final Database _db;
  Batch? batch;

  DbQuery(this._db);

  Future<List<Map<String, dynamic>>> selectQuery({
    required String table,
    List<SelectColumn> columns = const [SelectColumn(col: "*")],
    List<JoinTable> joinList = const [],
    QueryWhere? where,
  }) async {
    String cols = "";
    String joinOn = "";
    String onCondition = where == null
        ? ""
        : where.queryString(attachWhere: true);

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

    final sqlQuery = "SELECT $cols FROM $table $joinOn $onCondition;";

    return await _db.rawQuery(sqlQuery);
  }

  DbQuery insertQuery({
    required String table,
    required List<List<InsertValue>> valuesList,
  }) {
    if (valuesList.isEmpty) {
      throw Exception("Empty valueList");
    }

    batch = batch ?? _db.batch();

    for (var row in valuesList) {
      Map<String, String?> rowMap = {};

      for (var value in row) {
        rowMap[value.col] = value.data;
      }

      batch!.insert(table, rowMap);
    }

    return this;
  }

  DbQuery updateQuery({
    required String table,
    required List<InsertValue> values,
    required QueryWhere where,
  }) {
    batch = batch ?? _db.batch();

    Map<String, String?> valuesMap = {};

    for (var val in values) {
      valuesMap[val.col] = val.data;
    }
    batch!.update(table, valuesMap, where: where.queryString());

    return this;
  }

  DbQuery deleteQuery({required String table, required QueryWhere where}) {
    batch = batch ?? _db.batch();
    batch!.delete(table, where: where.queryString());
    return this;
  }

  Future<void> commit() async {
    if (batch == null) return;

    await batch!.commit();
    batch = null;
  }
}
