import 'package:lexivo_flutter/db/db.dart';
import 'package:lexivo_flutter/db/query_util.dart';
import 'package:lexivo_flutter/db/db_query.dart';
import 'package:lexivo_flutter/schema/dictionary/dictionary.dart';
import 'package:lexivo_flutter/schema/language/language.dart';

class TableDict extends DbQuery {
  static final name = "dictionary";
  static final pk = "id";
  static final colLanguage = "language";

  TableDict(super._db);

  Future<List<Dictionary>> getAll() async {
    final res = await selectQuery(table: name);

    final dicts = List.generate(res.length, (index) {
      final row = res[index];
      final dictId = row[pk];
      return Dictionary(dictId, Language.getLanguage(row[colLanguage]), {}, {});
    });

    for (var dict in dicts) {
      final words = await Db.getDb().word.getAllWordsOfDict(dict.id);
      final grammarList = await Db.getDb().grammar.getAllGrammarOfDict(dict.id);
      dict.addWords(words);
      dict.addGrammarList(grammarList);
    }

    return dicts;
  }

  Future<void> addDict(Dictionary dict) async {
    insertQuery(
      table: name,
      valuesList: [
        [
          InsertValue(col: pk, data: dict.id),
          InsertValue(col: colLanguage, data: dict.language.name),
        ],
      ],
    );

    await commit();
  }

  Future<void> importDict(Dictionary dict) async {
    await addDict(dict);
    await Db.getDb().word.insertWords(dict.id, dict.allWords);
    await Db.getDb().grammar.insertGrammar(dict.id, dict.allGrammar);
  }

  Future<bool> addDictFromCloud(Dictionary dict) async {
    // TODO:
    return true;
  }

  Future<void> replaceWithDictFromCloud(Dictionary dict) async {
    // TODO:
  }

  Future<void> updateDict(Dictionary dict) async {
    await updateQuery(
      table: name,
      values: [InsertValue(col: colLanguage, data: dict.language.name)],
      where: QueryWhere(
        col: pk,
        operator: QueryWhereOperator.EQUALS,
        value: dict.id,
      ),
    ).commit();
  }

  Future<void> deleteDictById(String dictId) async {
    await deleteQuery(
      table: name,
      where: QueryWhere(
        col: pk,
        operator: QueryWhereOperator.EQUALS,
        value: dictId,
      ),
    ).commit();
  }
}
