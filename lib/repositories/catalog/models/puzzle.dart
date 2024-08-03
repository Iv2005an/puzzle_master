import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'puzzle.g.dart';

@HiveType(typeId: 0)
class Puzzle extends Equatable {
  const Puzzle(
      this.id,
      this.image,
      this.title,
      this.article,
      this.factory,
      this.elementsCount,
      this.width,
      this.height,
      this.isFavorite,
      this.isInHistory);

  @HiveField(0)
  final int? id;

  @HiveField(1)
  final Uint8List image;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String article;

  @HiveField(4)
  final String factory;

  @HiveField(5)
  final int elementsCount;

  @HiveField(6)
  final double width;

  @HiveField(7)
  final double height;

  @HiveField(8)
  final bool isFavorite;

  @HiveField(9)
  final bool isInHistory;

  @override
  List<Object?> get props => [
        image,
        title,
        article,
        factory,
        elementsCount,
        width,
        height,
        isFavorite,
        isInHistory
      ];

  Puzzle copyWith({int? id, bool? isFavorite}) => Puzzle(
      id ?? this.id,
      image,
      title,
      article,
      factory,
      elementsCount,
      width,
      height,
      isFavorite ?? this.isFavorite,
      isInHistory);
}
