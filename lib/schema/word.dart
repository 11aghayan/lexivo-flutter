import 'package:uuid/uuid.dart';

class Word {
  final String id;

  Word.existing(this.id);
  Word() : id = Uuid().v4();
}
