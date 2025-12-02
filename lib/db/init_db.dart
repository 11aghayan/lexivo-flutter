import 'package:lexivo_flutter/db/create_db_util.dart';
import 'package:lexivo_flutter/db/table_dict.dart';
import 'package:lexivo_flutter/db/table_grammar.dart';
import 'package:lexivo_flutter/db/table_grammar_submenu.dart';
import 'package:lexivo_flutter/db/table_language.dart';
import 'package:lexivo_flutter/db/table_word.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> initDb() async {
  var dbPath = await getDatabasesPath();
  String path = join(dbPath, 'local_storage.db');

  Database database = await openDatabase(
    path,
    version: 1,
    onConfigure: (Database db) async {
      await db.execute('PRAGMA foreign_keys = ON');
    },
    onCreate: (Database db, int version) async {
      // Creating table 'language'
      await db.execute(
        createTableQuery(
          TableLanguage.name,
          columns: [
            SqlTableColumn(
              name: TableLanguage.pk,
              type: SqlColumnType.SHORT_TEXT,
              primaryKey: true,
            ),
            SqlTableColumn(
              name: TableLanguage.colNameOriginal,
              type: SqlColumnType.SHORT_TEXT,
              notNull: true,
            ),
          ],
        ),
      );

      // Creating table 'dictionary'
      await db.execute(
        createTableQuery(
          TableDict.name,
          columns: [
            SqlTableColumn(
              name: TableDict.pk,
              type: SqlColumnType.ID,
              primaryKey: true,
            ),
            SqlTableColumn(
              name: TableDict.colLanguage,
              type: SqlColumnType.SHORT_TEXT,
              notNull: true,
              reference: ForeignKeyReference(
                referenceTable: TableLanguage.name,
                referenceTableColumn: TableLanguage.pk,
                onDeleteCascade: false,
              ),
            ),
          ],
        ),
      );

      // Creating table 'word'
      await db.execute(
        createTableQuery(
          TableWord.name,
          columns: [
            SqlTableColumn(
              name: TableWord.pk,
              type: SqlColumnType.ID,
              primaryKey: true,
            ),
            SqlTableColumn(
              name: TableWord.colDictId,
              type: SqlColumnType.ID,
              notNull: true,
              reference: ForeignKeyReference(
                referenceTable: TableDict.name,
                referenceTableColumn: TableDict.pk,
                onDeleteCascade: true,
              ),
            ),
            SqlTableColumn(
              name: TableWord.colType,
              type: SqlColumnType.SHORT_TEXT,
              notNull: true,
            ),
            SqlTableColumn(
              name: TableWord.colLevel,
              type: SqlColumnType.SHORT_TEXT,
              notNull: true,
            ),
            SqlTableColumn(
              name: TableWord.colPracticeCountdown,
              type: SqlColumnType.INT,
              notNull: true,
            ),
            SqlTableColumn(
              name: TableWord.colGender,
              type: SqlColumnType.SHORT_TEXT,
            ),
            SqlTableColumn(name: TableWord.colNative, type: SqlColumnType.TEXT),
            SqlTableColumn(
              name: TableWord.colNativeDetails,
              type: SqlColumnType.TEXT,
            ),
            SqlTableColumn(name: TableWord.colPlural, type: SqlColumnType.TEXT),
            SqlTableColumn(name: TableWord.colPast1, type: SqlColumnType.TEXT),
            SqlTableColumn(name: TableWord.colPast2, type: SqlColumnType.TEXT),
            SqlTableColumn(name: TableWord.colDesc, type: SqlColumnType.TEXT),
            SqlTableColumn(
              name: TableWord.colDescDetails,
              type: SqlColumnType.TEXT,
            ),
          ],
        ),
      );

      // Creating table 'grammar'
      await db.execute(
        createTableQuery(
          TableGrammar.name,
          columns: [
            SqlTableColumn(
              name: TableGrammar.pk,
              type: SqlColumnType.ID,
              primaryKey: true,
            ),
            SqlTableColumn(
              name: TableGrammar.colDictId,
              type: SqlColumnType.ID,
              notNull: true,
              reference: ForeignKeyReference(
                referenceTable: TableDict.name,
                referenceTableColumn: TableDict.pk,
                onDeleteCascade: true,
              ),
            ),
            SqlTableColumn(
              name: TableGrammar.colHeader,
              type: SqlColumnType.SHORT_TEXT,
              notNull: true,
            ),
          ],
        ),
      );

      // Creating table 'grammar_submenu'
      await db.execute(
        createTableQuery(
          TableGrammarSubmenu.name,
          columns: [
            SqlTableColumn(
              name: TableGrammarSubmenu.pk,
              type: SqlColumnType.ID,
              primaryKey: true,
            ),
            SqlTableColumn(
              name: TableGrammarSubmenu.colGrammarId,
              type: SqlColumnType.ID,
              notNull: true,
              reference: ForeignKeyReference(
                referenceTable: TableGrammar.name,
                referenceTableColumn: TableGrammar.pk,
                onDeleteCascade: true,
              ),
            ),
            SqlTableColumn(
              name: TableGrammarSubmenu.colHeader,
              type: SqlColumnType.SHORT_TEXT,
              notNull: true,
            ),
            SqlTableColumn(
              name: TableGrammarSubmenu.colExplanationsJsonArray,
              type: SqlColumnType.TEXT,
              notNull: true,
            ),
            SqlTableColumn(
              name: TableGrammarSubmenu.colExamplesJsonArray,
              type: SqlColumnType.TEXT,
              notNull: true,
            ),
          ],
        ),
      );
    },
  );
  return database;
}
