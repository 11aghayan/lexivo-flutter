import 'package:lexivo_flutter/db/query_util.dart';
import 'package:lexivo_flutter/db/db_query.dart';
import 'package:lexivo_flutter/schema/enums/word_gender.dart';
import 'package:lexivo_flutter/schema/enums/word_level.dart';
import 'package:lexivo_flutter/schema/enums/word_type.dart';
import 'package:lexivo_flutter/schema/word/word.dart';

class TableWord extends DbQuery {
  static final name = "word";
  static final pk = "id";
  static final colDictId = "dictId";
  static final colType = "type";
  static final colLevel = "level";
  static final colGender = "gender";
  static final colPracticeCountdown = "practiceCountdown";
  static final colNative = "native";
  static final colNativeDetails = "nativeDetails";
  static final colPlural = "plural";
  static final colPast1 = "past1";
  static final colPast2 = "past2";
  static final colDesc = "desc";
  static final colDescDetails = "descDetails";

  TableWord(super._db);

  Future<void> insertWords(String dictId, List<Word> words) async {
    await insertQuery(
      table: name,
      valuesList: List.generate(words.length, (index) {
        final word = words[index];
        return _getInsertValuesFromWord(word, dictId);
      }),
    ).commit();
  }

  Future<void> updateWord(String dictId, Word word) async {
    await updateQuery(
      table: name,
      values: _getInsertValuesFromWord(word, dictId),
      where: QueryWhere(
        col: pk,
        operator: QueryWhereOperator.EQUALS,
        value: word.id,
      ),
    ).commit();
  }

  Future<void> deleteWord(String wordId) async {
    await deleteQuery(
      table: name,
      where: QueryWhere(
        col: pk,
        operator: QueryWhereOperator.EQUALS,
        value: wordId,
      ),
    ).commit();
  }

  Future<List<Word>> getAllWordsOfDict(String dictId) async {
    final res = await selectQuery(
      table: name,
      where: QueryWhere(
        col: colDictId,
        operator: QueryWhereOperator.EQUALS,
        value: dictId,
      ),
    );

    return List.generate(res.length, (index) {
      final row = res[index];
      return Word(
        id: row[TableWord.pk],
        type: WordType.fromString(row[TableWord.colType]),
        level: WordLevel.fromString(row[TableWord.colLevel]),
        practiceCountdown: row[TableWord.colPracticeCountdown],
        gender: WordGender.fromString(row[TableWord.colGender]),
        native: row[TableWord.colNative],
        nativeDetails: row[TableWord.colNativeDetails],
        plural: row[TableWord.colPlural],
        past1: row[TableWord.colPast1],
        past2: row[TableWord.colPast2],
        desc: row[TableWord.colDesc],
        descDetails: row[TableWord.colDescDetails],
      );
    });
  }

  List<InsertValue> _getInsertValuesFromWord(Word word, String dictId) {
    return [
      InsertValue(col: pk, data: word.id),
      InsertValue(col: colDictId, data: dictId),
      InsertValue(col: colType, data: word.type.toString()),
      InsertValue(col: colLevel, data: word.level.toString()),
      InsertValue(col: colGender, data: word.gender?.toString()),
      InsertValue(
        col: colPracticeCountdown,
        data: word.practiceCountdown.toString(),
      ),
      InsertValue(col: colNative, data: word.native),
      InsertValue(col: colNativeDetails, data: word.nativeDetails),
      InsertValue(col: colPlural, data: word.plural),
      InsertValue(col: colPast1, data: word.past1),
      InsertValue(col: colPast2, data: word.past2),
      InsertValue(col: colDesc, data: word.desc),
      InsertValue(col: colDescDetails, data: word.descDetails),
    ];
  }
}
