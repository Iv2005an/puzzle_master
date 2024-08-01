import 'package:flutter/material.dart';

import 'add_puzzle_form.dart';
import 'puzzle_card.dart';
import 'package:puzzle_master/repositories/catalog/models/puzzle.dart';

class PuzzlesList extends StatelessWidget {
  const PuzzlesList(this.puzzles, {this.isAddButton = false, super.key});

  final List<Puzzle> puzzles;
  final bool isAddButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: isAddButton
            ? FloatingActionButton(
                elevation: 0,
                tooltip: 'Добавить пазл',
                onPressed: () => showModalBottomSheet(
                      useRootNavigator: true,
                      useSafeArea: true,
                      isDismissible: false,
                      isScrollControlled: true,
                      context: context,
                      builder: (context) => Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: const AddPuzzleForm(),
                      ),
                    ),
                child: const Icon(Icons.add_photo_alternate_outlined))
            : null,
        body: Builder(
          builder: (context) {
            if (puzzles.isEmpty) {
              return const Center(child: Text('Пусто'));
            }
            // TODO: Логика отбора
            final verticalPuzzles = List.from(puzzles.where((element) => true));
            // TODO: Логика отбора
            final horizontalPuzzles =
                List.from(puzzles.where((element) => true));
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
                items
                    .add(PuzzleCard(verticalPuzzles[verticalPuzzlesIndex + 1]));
                verticalPuzzlesIndex += 1;
              }
              if (horizontalPuzzles.length > horizontalPuzzlesIndex + 1) {
                items.add(
                    PuzzleCard(horizontalPuzzles[horizontalPuzzlesIndex + 1]));
                horizontalPuzzlesIndex += 1;
              }
            }
            return SingleChildScrollView(child: Wrap(children: items));
          },
        ));
  }
}
