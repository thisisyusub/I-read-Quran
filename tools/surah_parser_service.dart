import 'dart:convert' show json;
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';

import '../lib/data/models/surah.dart';
import '../lib/data/models/verse.dart';

void main() async {
  await SurahParserService().fetchAllSurah();
}

class SurahParserService {
  SurahParserService._();

  static final _instance = SurahParserService._();

  factory SurahParserService() {
    return _instance;
  }

  List<Surah> allSurah = [];

  Future<void> fetchAllSurah() async {
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

    /// write all Surah to File as List of Object
    _writeToFile(allSurahOfQuran);
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

  Future<void> _writeToFile(List<Surah> allSurah) async {
    final sb = StringBuffer();
    var tempVerseSb = StringBuffer();

    // import
    sb.writeln('import \'../models/surah.dart\'');
    sb.writeln('import \'../models/verse.dart\'');
    sb.writeln();

    /// start list
    sb.writeln('const allSurah = <Surah>[');

    for (int i = 0; i < allSurah.length; i++) {
      final currentSurah = allSurah[i];

      tempVerseSb.writeln('<Verse>[');
      for (int j = 0; j < currentSurah.verses.length; j++) {
        final currentVerse = currentSurah.verses[j];

        tempVerseSb.writeln('''Verse(
          verseNumber: ${currentVerse.verseNumber},
          text: ${currentVerse.text},
        ),''');
      }
      tempVerseSb.writeln(']');

      sb.writeln('''Surah(
        surahName: ${currentSurah.surahName},
        surahNumber: ${currentSurah.surahNumber},
        ayahCount: ${currentSurah.ayahCount},
        surahDescription: ${currentSurah.surahDescription},
        verses: ${tempVerseSb.toString()},
      ),''');

      tempVerseSb = StringBuffer();
    }

    /// end list
    sb.writeln('];');

    final projectDirectory = dirname(dirname(Platform.script.toFilePath()));
    print(projectDirectory);
  }
}
