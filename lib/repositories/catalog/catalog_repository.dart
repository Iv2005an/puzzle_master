import 'package:hive_flutter/hive_flutter.dart';

import '../search/models/filters.dart';
import 'models/puzzle.dart';

class CatalogRepository {
  static const puzzlesStorageName = 'puzzles';
  static final Box<Puzzle> _puzzleStorage =
      Hive.box<Puzzle>(puzzlesStorageName);

  static List<Puzzle> getPuzzles(String searchText, Filters filters) {
    final puzzles = _puzzleStorage.values
        .where((puzzle) =>
            (filters.factoryFilters.isEmpty ||
                filters.factoryFilters.contains(puzzle.factory)) &&
            (filters.elementsCountFilters.isEmpty ||
                filters.elementsCountFilters
                    .contains('${puzzle.elementsCount}')) &&
            (searchText.isEmpty ||
                puzzle.title.toLowerCase().contains(searchText.toLowerCase())))
        .toList();
    return List.generate(
        puzzles.length, (index) => puzzles[index].copyWith(id: index));
  }

  static Future<void> addPuzzle(Puzzle newPuzzle) async =>
      await _puzzleStorage.add(newPuzzle);

  static Future<void> deletePuzzle(Puzzle puzzle) async {
    assert(puzzle.id != null, 'Id must not be null');
    await _puzzleStorage.deleteAt(puzzle.id!);
  }

  static Future<void> editPuzzle(Puzzle puzzle) async {
    assert(puzzle.id != null, 'Id must not be null');
    await _puzzleStorage.putAt(puzzle.id!, puzzle);
  }
}
