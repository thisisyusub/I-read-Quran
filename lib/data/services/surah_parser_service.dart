import 'dart:convert' show json;

import 'package:flutter/services.dart';

import '../models/surah.dart';
import '../models/verse.dart';

class SurahParserService {
  SurahParserService._();

  static final _instance = SurahParserService._();

  factory SurahParserService() {
    return _instance;
  }

  List<Surah> allSurah = [];

  Future<List<Surah>> fetchAllSurah() async {
    /// first get all info of Quran surah

    final allSurahInfo = await _getAllSurahInfo();

    final allSurahOfQuran = <Surah>[];

    final allSurahJson =
        await rootBundle.loadString('assets/quran/allsurah.json');

    final allSurah = json.decode(allSurahJson) as List<dynamic>;

    var tempVerses = <Verse>[];
    Surah tempSurah;
    int surahCounter = 0;

    allSurah.map((surah) {
      /// convert current surah to object
      final convertedSurah = Surah.fromJson(surah);

      /// set first surah
      if (tempSurah == null) {
        tempSurah = convertedSurah;
      }

      /// check for new surah
      /// record previous surah to List
      if (tempSurah.surahName != convertedSurah.surahName) {
        allSurahOfQuran.add(
          _setParameters(
            tempSurah,
            tempVerses,
            allSurahInfo[surahCounter],
          ),
        );
        tempVerses = <Verse>[];
        tempSurah = convertedSurah;
        surahCounter++;
      }

      /// convert each text and number of verse
      final currentVerseText = surah['translation'];
      final currentVerseNumber = surah['verse_number'];

      /// create new verse
      final newVerse = Verse(
        text: currentVerseText,
        verseNumber: currentVerseNumber,
      );

      /// add new verse to [tempVerses]
      tempVerses.add(newVerse);
    }).toList();

    /// add logic to add last surah of Quran
    allSurahOfQuran.add(
      _setParameters(
        tempSurah,
        tempVerses,
        allSurahInfo[surahCounter],
      ),
    );

    return allSurahOfQuran;
  }

  Surah _setParameters(
      Surah tempSurah, List<Verse> verses, String surahDescription) {
    tempSurah.verses = verses;
    tempSurah.ayahCount = verses.length;
    tempSurah.surahDescription = surahDescription;

    return tempSurah;
  }

  Future<List<String>> _getAllSurahInfo() async {
    final allSurahInfoOfQuran = <String>[];

    final allSurahInfoJson =
        await rootBundle.loadString('assets/quran/surah-info.json');

    final allSurahInfo = json.decode(allSurahInfoJson) as List<dynamic>;

    allSurahInfo.map((surahInfo) {
      allSurahInfoOfQuran.add(surahInfo['type']);
    }).toList();

    return allSurahInfoOfQuran;
  }
}
