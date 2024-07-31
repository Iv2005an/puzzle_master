import 'package:hive_flutter/hive_flutter.dart';

import 'models/puzzle.dart';

class CatalogRepository {
  static const puzzlesStorageName = 'puzzles';

  static List<Puzzle> getPuzzles() =>
      Hive.box<Puzzle>(puzzlesStorageName).values.toList();

  static void addPuzzle(Puzzle newPuzzle) =>
      Hive.box<Puzzle>(puzzlesStorageName).add(newPuzzle);

//TODO: Логика удаления пазла
  static void deletePuzzle(Puzzle puzzle) {
    throw UnimplementedError();
  }

  //TODO: Логика изменения пазла
  static void editPuzzle(Puzzle puzzle) {
    throw UnimplementedError();
  }
}
