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
      _appBox.put('version', version);
    }
  }

  Future<void> _writeAllSurah() async => _appBox.put('surahs', surahs);

  List<Surah> get allSurah => _appBox.get('surahs').cast<Surah>();

  List<Verse> get bookmarks => _appBox.get('bookmarks')?.cast<Verse>();

  Future<void> changeProgress(String verseNumber, int surahIndex) async {
    final number = verseNumber.contains(',')
        ? verseNumber.split(',').last.trim()
        : verseNumber;
    allSurah[surahIndex - 1].readVerseCount = int.parse(number);
    await _appBox.put('surahs', allSurah);
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
