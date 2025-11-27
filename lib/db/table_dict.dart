import 'package:lexivo_flutter/db/query_util.dart';
import 'package:lexivo_flutter/db/table.dart';
import 'package:lexivo_flutter/db/table_grammar.dart';
import 'package:lexivo_flutter/db/table_grammar_submenu.dart';
import 'package:lexivo_flutter/db/table_word.dart';
import 'package:lexivo_flutter/schema/dictionary/dictionary.dart';
import 'package:lexivo_flutter/schema/enums/word_gender.dart';
import 'package:lexivo_flutter/schema/enums/word_level.dart';
import 'package:lexivo_flutter/schema/enums/word_type.dart';
import 'package:lexivo_flutter/schema/language/language.dart';
import 'package:lexivo_flutter/schema/word/word.dart';

class TableDict extends Table {
  static final name = "dictionary";
  static final pk = "id";
  static final colLanguage = "language";

  TableDict(super._db);

  Future<List<Dictionary>> getAll() async {
    final tempIdDict = "dict_id";

    final queryResult = await selectQuery(
      table: name,
      columns: [
        SelectColumn(col: "*"),
        SelectColumn(col: "$name.$pk", as: tempIdDict),
      ],
      joinList: [
        JoinTable(
          table: TableWord.name,
          thisCol: pk,
          withCol: TableWord.colDictId,
        ),
      ],
    );

    final dicts = _dictsFromQueryResult(queryResult, tempIdDict);

    String? lastDictId;
    List<Word> lastWords = [];

    int count = 0;
    for (var wordObj in queryResult) {
      count++;
      if (wordObj[tempIdDict] != null || count == queryResult.length) {
        if (lastDictId != null) {
          dicts.firstWhere((d) => d.id == lastDictId).addWords(lastWords);
          lastWords = [];
        }
        lastDictId = wordObj[tempIdDict];
        continue;
      }
      Word word = _wordFromWordObj(wordObj);
      lastWords.add(word);
    }

    // TODO: Add grammar to dict

    return dicts;
  }

  List<Dictionary> _dictsFromQueryResult(
    List<Map<String, dynamic>> queryResult,
    String tempIdDict,
  ) {
    return queryResult
        .where((obj) => obj[tempIdDict] != null)
        .map(
          (obj) => Dictionary(
            obj[tempIdDict],
            Language.allLanguagesList.firstWhere(
              (l) => l.name == obj[colLanguage],
            ),
            [],
            [],
          ),
        )
        .toList();
  }

  Word _wordFromWordObj(Map<String, dynamic> wordObj) {
    return Word(
      id: wordObj[TableWord.pk],
      type: WordType.fromString(wordObj[TableWord.colType]),
      level: WordLevel.fromString(wordObj[TableWord.colLevel]),
      practiceCountdown: wordObj[TableWord.colPracticeCountdown],
      gender: WordGender.fromString(wordObj[TableWord.colGender]),
      native: wordObj[TableWord.colNative],
      nativeDetails: wordObj[TableWord.colNativeDetails],
      plural: wordObj[TableWord.colPlural],
      past1: wordObj[TableWord.colPast1],
      past2: wordObj[TableWord.colPast2],
      desc: wordObj[TableWord.colDesc],
      descDetails: wordObj[TableWord.colDescDetails],
    );
  }

  Future<void> addDict(Dictionary dict) async {
    await insertQuery(
      table: name,
      valuesList: [
        [
          InsertValue(col: pk, data: dict.id),
          InsertValue(col: colLanguage, data: dict.language.name),
        ],
      ],
    );
  }
}
