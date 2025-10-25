enum WordGender {
  MASCULINE,
  FEMININE,
  NEUTER,
  PERSONAL,
  PLURAL,
  NO_GENDER;

  @override
  String toString() {
    return name.toString().split("_").join(" ");
  }
}
