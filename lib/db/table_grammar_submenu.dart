import 'dart:convert';

import 'package:lexivo_flutter/db/query_util.dart';
import 'package:lexivo_flutter/db/table.dart';
import 'package:lexivo_flutter/schema/grammar/grammar_submenu.dart';

class TableGrammarSubmenu extends Table {
  static final name = "grammarSubmenu";
  static final pk = "id";
  static final colGrammarId = "grammarId";
  static final colHeader = "header";
  static final colExplanationsJsonArray = "explanationsJsonArray";
  static final colExamplesJsonArray = "examplesJsonArray";

  TableGrammarSubmenu(super._db);

  Future<List<GrammarSubmenu>> getAllSubmenuListOfGrammar(
    String grammarId,
  ) async {
    final res = await selectQuery(
      table: name,
      where: QueryWhere(
        col: colGrammarId,
        operator: QueryWhereOperator.EQUALS,
        value: grammarId,
      ),
    );

    return List.generate(res.length, (index) {
      final row = res[index];
      return GrammarSubmenu(
        row[pk],
        row[colHeader],
        (jsonDecode(row[colExplanationsJsonArray]) as List).cast<String>(),
        (jsonDecode(row[colExamplesJsonArray]) as List).cast<String>(),
      );
    });
  }

  void updateSubmenuWithoutCommit(Table query, GrammarSubmenu submenu) {
    query.updateQuery(
      table: name,
      values: [
        InsertValue(col: colHeader, data: submenu.header),
        InsertValue(
          col: colExplanationsJsonArray,
          data: jsonEncode(submenu.explanations),
        ),
        InsertValue(
          col: colExamplesJsonArray,
          data: jsonEncode(submenu.examples),
        ),
      ],
      where: QueryWhere(
        col: pk,
        operator: QueryWhereOperator.EQUALS,
        value: submenu.id,
      ),
    );
  }
}
