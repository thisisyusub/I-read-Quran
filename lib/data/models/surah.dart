import './verse.dart';

class Surah {
  final String arabic;
  final String latin;
  final int verseCount;
  final int index;
  final String type;
  final List<Verse> verses;

  const Surah({
    this.type,
    this.latin,
    this.index,
    this.arabic,
    this.verses,
    this.verseCount,
  });
}
