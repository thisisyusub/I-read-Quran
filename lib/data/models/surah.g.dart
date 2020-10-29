// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surah.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SurahAdapter extends TypeAdapter<Surah> {
  @override
  final int typeId = 1;

  @override
  Surah read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Surah(
      type: fields[4] as String,
      latin: fields[1] as String,
      index: fields[3] as int,
      arabic: fields[0] as String,
      verses: (fields[5] as List)?.cast<Verse>(),
      verseCount: fields[2] as int,
      readVerseCount: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Surah obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.arabic)
      ..writeByte(1)
      ..write(obj.latin)
      ..writeByte(2)
      ..write(obj.verseCount)
      ..writeByte(3)
      ..write(obj.index)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.verses)
      ..writeByte(6)
      ..write(obj.readVerseCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SurahAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
