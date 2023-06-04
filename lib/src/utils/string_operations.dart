


class StringOperations {

 static String capitalizeEachWord(String input) {
    List<String> words = input.split(' ');

    // Capitalize the first letter of each word
    List<String> capitalizedWords = words.map((word) {
      if (word.isEmpty) {
        return word; // Skip empty words
      }
      String firstLetter = word[0].toUpperCase();
      String restOfWord = word.substring(1).toLowerCase();
      return '$firstLetter$restOfWord';
    }).toList();

    return capitalizedWords.join(' ');
  }

}