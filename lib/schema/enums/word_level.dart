enum WordLevel {
  A1,
  A2,
  B1,
  B2,
  C1,
  C2;

  @override
  String toString() {
    return name.toUpperCase();
  }

  static WordLevel fromString(String s) {
    return switch (s.toLowerCase()) {
      "a1" => A1,
      "a2" => A2,
      "b1" => B1,
      "b2" => B2,
      "c1" => C1,
      _ => C2,
    };
  }
}
