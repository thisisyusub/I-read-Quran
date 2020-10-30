import 'package:hive/hive.dart';

import '../all-surah/all_surah.dart';
import '../models/surah.dart';
import '../models/verse.dart';

class HiveService {
  HiveService._();

  static final _instance = HiveService._();

  factory HiveService() {
    return _instance;
  }

  final _appBox = Hive.box('appBox');

  Future<void> configDatabase({int version}) async {
    if (_appBox.containsKey('version')) {
      final currentVersion = _appBox.get('version');

      if (currentVersion != version) {
        // todo: make migration logic and write all surah
      }
    } else {
      // todo: write all surah and set version to 1
      await _writeAllSurah();
      _appBox.put('readSurahCount', 0);
      _appBox.put('readAyahCount', 0);
      _appBox.put('version', version);
    }
  }

  Future<void> _writeAllSurah() async => _appBox.put('surahs', surahs);

  List<Surah> get allSurah => _appBox.get('surahs').cast<Surah>();

  List<Verse> get bookmarks => _appBox.get('bookmarks')?.cast<Verse>();

  int get readSurahCount => _appBox.get('readSurahCount');

  int get readAyahCount => _appBox.get('readAyahCount');

  Future<void> changeProgress(String verseNumber, Surah surah) async {
    final number = verseNumber.contains(',')
        ? verseNumber.split(',').last.trim()
        : verseNumber;

    final convertedNumber = int.tryParse(number);

    /// logic for surah progress
    int prevSurahCount = _appBox.get('readSurahCount');

    if (convertedNumber == surah.verseCount) {
      await _appBox.put('readSurahCount', ++prevSurahCount);
    } else if (surah.readVerseCount == surah.verseCount &&
        convertedNumber < surah.verseCount) {
      await _appBox.put('readSurahCount', --prevSurahCount);
    }

    /// logic for ayah progress
    int prevAyahCount = _appBox.get('readAyahCount');

    if (convertedNumber > surah.readVerseCount) {
      final newCount = prevAyahCount + (convertedNumber - surah.readVerseCount);

      await _appBox.put('readAyahCount', newCount);
    } else if (convertedNumber < surah.readVerseCount) {
      await _appBox.put(
        'readAyahCount',
        prevAyahCount - (surah.readVerseCount - convertedNumber),
      );
    }

    allSurah[surah.index - 1].readVerseCount = int.parse(number);
    await _appBox.put('surahs', allSurah);
  }

  Future<void> resetProgress() async {
    await _appBox.put('readSurahCount', 0);
    await _appBox.put('readAyahCount', 0);

    final resettedAllSurah = allSurah.map((surah) {
      surah.readVerseCount = 0;
      return surah;
    }).toList();
    await _appBox.put('surahs', resettedAllSurah);
  }

  Future<void> deleteBookmark(Verse verse) async {
    final bookmarks = _appBox.get('bookmarks').cast<Verse>();
    (bookmarks as List).remove(verse);
    await _appBox.put('bookmarks', bookmarks);
  }

  Future<bool> addToBookmark(
      int surahIndex, String surahName, Verse verse) async {
    verse.surahIndexForBookmark = surahIndex;
    verse.surahName = surahName;

    if (_appBox.containsKey('bookmarks')) {
      final bookmarks = _appBox.get('bookmarks').cast<Verse>();

      if ((bookmarks as List).contains(verse)) {
        return false;
      }

      (bookmarks as List).add(verse);
      await _appBox.put('bookmarks', bookmarks);
      return true;
    } else {
      await _appBox.put('bookmarks', <Verse>[verse]);
      return true;
    }
  }
}
