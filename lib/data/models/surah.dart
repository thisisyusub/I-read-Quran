import 'package:hive/hive.dart';

import './verse.dart';

part 'surah.g.dart';

@HiveType(typeId: 1)
class Surah {
  @HiveField(0)
  final String arabic;
  @HiveField(1)
  final String latin;
  @HiveField(2)
  final int verseCount;
  @HiveField(3)
  final int index;
  @HiveField(4)
  final String type;
  @HiveField(5)
  final List<Verse> verses;
  @HiveField(6)
  int readVerseCount;

  Surah({
    this.type,
    this.latin,
    this.index,
    this.arabic,
    this.verses,
    this.verseCount,
    this.readVerseCount = 0,
  });
}
