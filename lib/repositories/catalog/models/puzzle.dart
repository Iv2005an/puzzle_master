import 'package:flutter/services.dart';

class Puzzle {
  Puzzle.lateInit();
  Puzzle(
    this.image,
    this.title,
    this.elementsCount,
    this.width,
    this.height, {
    this.article,
    this.factory,
    this.isFavorite = false,
  });
  late Uint8List image;
  late String title;
  String? article;
  String? factory;
  late int elementsCount;
  late double width;
  late double height;
  bool isFavorite = false;
}
