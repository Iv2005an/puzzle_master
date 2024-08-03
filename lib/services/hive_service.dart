import 'package:hive_flutter/hive_flutter.dart';

import 'package:puzzle_master/repositories/catalog/catalog_repository.dart';
import 'package:puzzle_master/repositories/catalog/models/puzzle.dart';
import 'package:puzzle_master/repositories/search/search_repository.dart';

class HiveService {
  static Future<void> init() async {
    await Hive.initFlutter();
    await _registerAdapters();
    await _openBoxes();
  }

  static Future<void> _openBoxes() async {
    await Hive.openBox<Puzzle>(CatalogRepository.puzzlesStorageName);
    await Hive.openBox<String>(SearchRepository.searchStorageName);
  }

  static Future<void> _registerAdapters() async {
    Hive.registerAdapter(PuzzleAdapter());
  }
}
