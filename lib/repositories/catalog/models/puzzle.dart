import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'puzzle.g.dart';

@HiveType(typeId: 0)
class Puzzle extends Equatable {
  const Puzzle(
    this.image,
    this.title,
    this.elementsCount,
    this.width,
    this.height,
    this.factory,
    this.article,
    this.isFavorite,
  );
  @HiveField(0)
  final Uint8List image;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final int elementsCount;

  @HiveField(3)
  final double width;

  @HiveField(4)
  final double height;

  @HiveField(5)
  final String factory;

  @HiveField(6)
  final String article;

  @HiveField(7)
  final bool isFavorite;

  @override
  List<Object?> get props => [
        image,
        title,
        elementsCount,
        width,
        height,
        factory,
        article,
        isFavorite
      ];
}
