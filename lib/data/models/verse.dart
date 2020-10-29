import 'package:hive/hive.dart';

part 'verse.g.dart';

@HiveType(typeId: 2)
class Verse {
  @HiveField(0)
  final String number;
  @HiveField(1)
  final String text;
  @HiveField(2)
  final String translation;
  @HiveField(3)
  int surahIndexForBookmark;
  @HiveField(4)
  String surahName;

  Verse({
    this.number,
    this.text,
    this.translation,
    this.surahIndexForBookmark,
    this.surahName,
  });
}
