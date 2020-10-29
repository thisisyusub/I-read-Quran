// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verse.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VerseAdapter extends TypeAdapter<Verse> {
  @override
  final int typeId = 2;

  @override
  Verse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Verse(
      number: fields[0] as String,
      text: fields[1] as String,
      translation: fields[2] as String,
      surahIndexForBookmark: fields[3] as int,
      surahName: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Verse obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.number)
      ..writeByte(1)
      ..write(obj.text)
      ..writeByte(2)
      ..write(obj.translation)
      ..writeByte(3)
      ..write(obj.surahIndexForBookmark)
      ..writeByte(4)
      ..write(obj.surahName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VerseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
