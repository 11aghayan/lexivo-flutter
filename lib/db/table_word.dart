import 'package:lexivo_flutter/db/query_util.dart';
import 'package:lexivo_flutter/db/table.dart';
import 'package:lexivo_flutter/schema/word/word.dart';

class TableWord extends Table {
  static final name = "word";
  static final pk = "id";
  static final colDictId = "dict_id";
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
    await insertQuery(table: name, valuesList: List.generate(words.length, (index) {
      final word = words[index];
      return [
        InsertValue(col: pk, data: word.id),
        InsertValue(col: colDictId, data: dictId),
        InsertValue(col: colType, data: word.type.toString()),
        InsertValue(col: colLevel, data: word.level.toString()),
        InsertValue(col: colGender, data: word.gender?.toString()),
        InsertValue(col: colPracticeCountdown, data: word.practiceCountdown.toString()),
        InsertValue(col: colNative, data: word.native?.toString()),
        InsertValue(col: colNativeDetails, data: word.nativeDetails?.toString()),
        InsertValue(col: colPlural, data: word.plural?.toString()),
        InsertValue(col: colPast1, data: word.past1?.toString()),
        InsertValue(col: colPast2, data: word.past2?.toString()),
        InsertValue(col: colDesc, data: word.desc?.toString()),
        InsertValue(col: colDescDetails, data: word.descDetails?.toString()),
      ];
    },));
  }
}
