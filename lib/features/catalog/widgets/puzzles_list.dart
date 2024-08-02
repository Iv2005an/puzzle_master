import 'package:flutter/material.dart';

import 'puzzle_data_dialog.dart';
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
                        child: const PuzzleDataDialog(),
                      ),
                    ),
                child: const Icon(Icons.add_photo_alternate_outlined))
            : null,
        body: puzzles.isEmpty
            ? Center(
                child: Text(
                'Добавьте пазлы',
                style: Theme.of(context).textTheme.displaySmall,
              ))
            : SingleChildScrollView(
                child: Column(
                    children: List.generate(
                        puzzles.length, (index) => PuzzleCard(puzzles[index]))),
              ));
  }
}
