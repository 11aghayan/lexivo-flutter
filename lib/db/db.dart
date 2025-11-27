import 'package:lexivo_flutter/db/init_db.dart';
import 'package:lexivo_flutter/db/table_dict.dart';
import 'package:lexivo_flutter/db/table_grammar.dart';
import 'package:lexivo_flutter/db/table_grammar_submenu.dart';
import 'package:lexivo_flutter/db/table_language.dart';
import 'package:lexivo_flutter/db/table_word.dart';
import 'package:sqflite/sqflite.dart';

class Db {
  static Db? _db;
  final TableDict dict;
  final TableLanguage lang;
  final TableWord word;
  final TableGrammar grammar;
  final TableGrammarSubmenu grammarSubmenu;

  Db._(Database database)
    : dict = TableDict(database),
      lang = TableLanguage(database),
      word = TableWord(database),
      grammar = TableGrammar(database),
      grammarSubmenu = TableGrammarSubmenu(database);

  static Future<Db> init() async {
    _db ??= Db._(await initDb());
    return _db!;
  }

  static Db getDb() => _db!;
}
