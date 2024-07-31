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
      fields[0] as Uint8List,
      fields[1] as String,
      fields[2] as int,
      fields[3] as double,
      fields[4] as double,
      fields[5] as String,
      fields[6] as String,
      fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Puzzle obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.image)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.elementsCount)
      ..writeByte(3)
      ..write(obj.width)
      ..writeByte(4)
      ..write(obj.height)
      ..writeByte(5)
      ..write(obj.factory)
      ..writeByte(6)
      ..write(obj.article)
      ..writeByte(7)
      ..write(obj.isFavorite);
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
