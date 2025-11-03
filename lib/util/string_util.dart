abstract class Strings {
  static String toCapitalized(String str) {
    return str[0].toUpperCase() + str.substring(1);
  }

  static String? toTrimmedOrNull(String? str) {
    String trimmed = str?.trim() ?? "";
    
    if (trimmed.isEmpty) {
      return null;
    }

    return trimmed;
  }
}