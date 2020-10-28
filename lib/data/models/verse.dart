class Verse {
  Verse({
    this.verseNumber,
    this.text,
  });

  final String verseNumber;
  final String text;

  @override
  String toString() => '''{
    verseNumber: $verseNumber,
    text: $text,
    }''';
}
