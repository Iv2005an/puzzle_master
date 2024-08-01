// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'puzzle.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PuzzleAdapter extends TypeAdapter<Puzzle> {
  @override
  final int typeId = 0;

  @override
  Puzzle read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Puzzle(
      fields[0] as int?,
      fields[1] as Uint8List,
      fields[2] as String,
      fields[3] as int,
      fields[4] as double,
      fields[5] as double,
      fields[6] as String,
      fields[7] as String,
      fields[8] as bool,
      fields[9] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Puzzle obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.elementsCount)
      ..writeByte(4)
      ..write(obj.width)
      ..writeByte(5)
      ..write(obj.height)
      ..writeByte(6)
      ..write(obj.factory)
      ..writeByte(7)
      ..write(obj.article)
      ..writeByte(8)
      ..write(obj.isFavorite)
      ..writeByte(9)
      ..write(obj.isInHistory);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PuzzleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
