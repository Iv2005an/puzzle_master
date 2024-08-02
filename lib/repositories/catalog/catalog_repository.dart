import 'package:hive_flutter/hive_flutter.dart';

import 'models/puzzle.dart';

class CatalogRepository {
  static const puzzlesStorageName = 'puzzles';
  static final Box<Puzzle> puzzleStorage = Hive.box<Puzzle>(puzzlesStorageName);

  static List<Puzzle> get puzzles {
    final puzzles = puzzleStorage.values.toList();
    return List.generate(
        puzzles.length, (index) => puzzles[index].copyWith(id: index));
  }

  static Future<void> addPuzzle(Puzzle newPuzzle) async =>
      await puzzleStorage.add(newPuzzle);

  static Future<void> deletePuzzle(Puzzle puzzle) async {
    assert(puzzle.id != null, 'Id must not be null');
    await puzzleStorage.deleteAt(puzzle.id!);
  }

  static Future<void> editPuzzle(Puzzle puzzle) async {
    assert(puzzle.id != null, 'Id must not be null');
    await puzzleStorage.putAt(puzzle.id!, puzzle);
  }
}
