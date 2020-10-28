import './verse.dart';

class Surah {
  Surah({
    this.surahName,
    this.surahNumber,
    this.verses,
    this.ayahCount,
  });

  final String surahNumber;
  final String surahName;
  List<Verse> verses;
  int ayahCount;
  String surahDescription;

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      surahName: json['surah_name'],
      surahNumber: json['surah_number'],
    );
  }

  @override
  String toString() => '''{
    surahName: $surahName,
    surahNumber: $surahNumber,
    verses: $verses,
    ayahCount: $ayahCount,
    surahDescription: $surahDescription,
    }''';
}
