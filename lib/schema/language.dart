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

  Language._(this.name, this.nameOriginal)
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

  static void init() {
    _english = Language._("english", "english");
    _german = Language._("german", "deutsch");
    _russian = Language._("russian", "русский");
    _french = Language._("french", "français");
    _spanish = Language._("spanish", "español");
    _italian = Language._("italian", "italiano");
  }
}
