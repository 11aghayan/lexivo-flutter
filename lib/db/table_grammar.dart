import 'dart:convert';

import 'package:lexivo_flutter/db/db.dart';
import 'package:lexivo_flutter/db/query_util.dart';
import 'package:lexivo_flutter/db/table.dart';
import 'package:lexivo_flutter/db/table_grammar_submenu.dart';
import 'package:lexivo_flutter/schema/grammar/grammar.dart';

class TableGrammar extends Table {
  static final name = "grammar";
  static final pk = "id";
  static final colHeader = "header";
  static final colDictId = "dictId";

  TableGrammar(super._db);

  Future<void> insertGrammar(String dictId, List<Grammar> grammarList) async {
    List<List<InsertValue>> submenus = [];

    var grammars = List.generate(grammarList.length, (index) {
      final grammar = grammarList[index];
      for (var submenu in grammar.submenuList) {
        submenus.add([
          InsertValue(col: TableGrammarSubmenu.pk, data: submenu.id),
          InsertValue(col: TableGrammarSubmenu.colGrammarId, data: grammar.id),
          InsertValue(col: TableGrammarSubmenu.colHeader, data: submenu.header),
          InsertValue(
            col: TableGrammarSubmenu.colExplanationsJsonArray,
            data: jsonEncode(submenu.explanations),
          ),
          InsertValue(
            col: TableGrammarSubmenu.colExamplesJsonArray,
            data: jsonEncode(submenu.examples),
          ),
        ]);
      }
      return [
        InsertValue(col: pk, data: grammar.id),
        InsertValue(col: colDictId, data: dictId),
        InsertValue(col: colHeader, data: grammar.header),
      ];
    });

    insertQuery(table: name, valuesList: grammars);
    await insertQuery(
      table: TableGrammarSubmenu.name,
      valuesList: submenus,
    ).commit();
  }

  Future<void> updateGrammar(Grammar grammar) async {
    final query = updateQuery(
      table: name,
      values: [InsertValue(col: colHeader, data: grammar.header)],
      where: QueryWhere(
        col: pk,
        operator: QueryWhereOperator.EQUALS,
        value: grammar.id,
      ),
    );

    for (var submenu in grammar.submenuList) {
      Db.getDb().grammarSubmenu.updateSubmenuWithoutCommit(query, submenu);
    }

    await commit();
  }

  Future<void> deleteGrammar(String grammarId) async {
    await deleteQuery(
      table: name,
      where: QueryWhere(
        col: pk,
        operator: QueryWhereOperator.EQUALS,
        value: grammarId,
      ),
    ).commit();
  }

  Future<List<Grammar>> getAllGrammarOfDict(String dictId) async {
    final res = await selectQuery(
      table: name,
      where: QueryWhere(
        col: colDictId,
        operator: QueryWhereOperator.EQUALS,
        value: dictId,
      ),
    );
    final List<Grammar> grammarList = List.generate(res.length, (index) {
      final row = res[index];
      return Grammar(row[pk], row[colHeader], []);
    });

    for (var grammar in grammarList) {
      final submenuList = await Db.getDb().grammarSubmenu
          .getAllSubmenuListOfGrammar(grammar.id);
      grammar.setSubmenuList(submenuList);
    }

    return grammarList;
  }
}
