import 'package:lexivo_flutter/db/query_util.dart';
import 'package:lexivo_flutter/db/db_query.dart';
import 'package:lexivo_flutter/schema/language/language.dart';

class TableLanguage extends DbQuery {
  static final name = "language";
  static final pk = "name";
  static final colNameOriginal = "nameOriginal";

  TableLanguage(super._db);

  Future<void> initLangsToDb(List<Language> langs) async {
    final rows = await selectQuery(table: name);

    if (rows.length == langs.length) return;

    final langsNotInDb = langs
        .where((lang) => rows.indexWhere((r) => r[pk] == lang.name) == -1)
        .toList();
    await insertQuery(
      table: name,
      valuesList: List.generate(langsNotInDb.length, (index) {
        final lang = langsNotInDb[index];
        return [
          InsertValue(col: pk, data: lang.name),
          InsertValue(col: colNameOriginal, data: lang.nameOriginal),
        ];
      }),
    ).commit();
  }
}
