import 'package:json_annotation/json_annotation.dart';

part 'language.g.dart';

@JsonSerializable()
class Language {
  static final List<Language> _allLanguagesList = [];

  static Language? _english;
  static Language? _german;
  static Language? _russian;
  static Language? _french;
  static Language? _spanish;
  static Language? _italian;

  final String name;
  final String nameOriginal;
  final String photoPath;

  Language(this.name, this.nameOriginal)
    : photoPath = "assets/flags/$name.png" {
    _allLanguagesList.add(this);
  }

  static List<Language> get allLanguagesList => _allLanguagesList;
  static Language get english => _english!;
  static Language get german => _german!;
  static Language get russian => _russian!;
  static Language get french => _french!;
  static Language get spanish => _spanish!;
  static Language get italian => _italian!;

  static Language getLanguage(String lang) {
    return allLanguagesList.firstWhere(
      (l) => l.name == lang,
      orElse: () => throw Exception("Invalid language '$lang' provided"),
    );
  }

  static void init() {
    _english = Language("english", "english");
    _german = Language("german", "deutsch");
    _russian = Language("russian", "русский");
    _french = Language("french", "français");
    _spanish = Language("spanish", "español");
    _italian = Language("italian", "italiano");
  }

  bool equals(Language lang) {
    return lang.name == name;
  }

  // JSON
  factory Language.fromJson(Map<String, dynamic> json) =>
      _$LanguageFromJson(json);
  Map<String, dynamic> toJson() => _$LanguageToJson(this);
}
