import 'package:flutter/material.dart';

import 'puzzle_card.dart';
import 'package:puzzle_master/repositories/catalog/models/puzzle.dart';

class PuzzlesList extends StatelessWidget {
  const PuzzlesList(this.puzzles, {super.key});

  final List<Puzzle> puzzles;

  @override
  Widget build(BuildContext context) {
    if (puzzles.isEmpty) {
      return const Center(child: Text('Пусто'));
    }
    // TODO: Логика отбора
    final verticalPuzzles = List.from(puzzles.where((element) => true));
    // TODO: Логика отбора
    final horizontalPuzzles = List.from(puzzles.where((element) => true));
    List<Widget> items = [];
    int verticalPuzzlesIndex = -1;
    int horizontalPuzzlesIndex = -1;
    while (true) {
      if (verticalPuzzles.length - 1 == verticalPuzzlesIndex &&
          horizontalPuzzles.length - 1 == horizontalPuzzlesIndex) break;
      if (verticalPuzzles.length > verticalPuzzlesIndex + 2) {
        // items.add(PuzzleCard(verticalPuzzles[verticalPuzzlesIndex + 1]));
        verticalPuzzlesIndex += 2;
      } else if (verticalPuzzles.length > verticalPuzzlesIndex + 1) {
        items.add(PuzzleCard(verticalPuzzles[verticalPuzzlesIndex + 1]));
        verticalPuzzlesIndex += 1;
      }
      if (horizontalPuzzles.length > horizontalPuzzlesIndex + 1) {
        items.add(PuzzleCard(horizontalPuzzles[horizontalPuzzlesIndex + 1]));
        horizontalPuzzlesIndex += 1;
      }
    }
    return SingleChildScrollView(child: Wrap(children: items));
  }
}
