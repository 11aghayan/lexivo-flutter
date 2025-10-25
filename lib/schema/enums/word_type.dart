enum WordType {
  NOUN,
  ADJ_ADV,
  VERB,
  PRON_PREP,
  QUESTION_WORD,
  NUMERAL,
  PHRASE;

  // TODO: Add language support
  @override
  String toString() {
    return switch (this) {
      NOUN => "noun",
      ADJ_ADV => "adjective/adverb",
      VERB => "verb",
      PRON_PREP => "pronoun/preposition",
      QUESTION_WORD => "question word",
      NUMERAL => "numeral",
      _ => "phrase",
    };
  }

  static WordType fromString(String s) {
    s = s.toLowerCase();
    return switch (s) {
      "noun" => NOUN,
      "adjective/adverb" || "adj_adv" => ADJ_ADV,
      "verb" => VERB,
      "pronoun/preposition" || "pron_prep" => PRON_PREP,
      "numeral" => NUMERAL,
      "question word" || "question_word" => QUESTION_WORD,
      _ => PHRASE,
    };
  }
}
