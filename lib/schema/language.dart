class Language {
  static final Language english = Language._("english", "english");
  static final Language german = Language._("german", "deutsch");
  static final Language russian = Language._("russian", "русский");
  static final Language french = Language._("french", "français");
  static final Language spanish = Language._("spanish", "español");
  static final Language italian = Language._("italian", "italiano");

  final String name;
  final String nameOriginal;
  final String photoPath;

  Language._(this.name, this.nameOriginal) : photoPath = "assets/flags/$name.png";
}