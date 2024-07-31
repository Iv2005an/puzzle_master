import 'package:hive_flutter/hive_flutter.dart';

import 'package:puzzle_master/repositories/catalog/catalog_repository.dart';
import 'package:puzzle_master/repositories/catalog/models/puzzle.dart';

class HiveService {
  static Future<void> init() async {
    await Hive.initFlutter();
    await _registerAdapters();
    await _openBoxes();
  }

  static Future<void> _openBoxes() async {
    await Hive.openBox<Puzzle>(CatalogRepository.puzzlesStorageName);
  }

  static Future<void> _registerAdapters() async {
    Hive.registerAdapter(PuzzleAdapter());
  }
}
