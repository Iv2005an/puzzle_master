import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:puzzle_master/repositories/catalog/models/puzzle.dart';

import '../bloc/catalog_bloc/catalog_bloc.dart';

class PuzzleDeletingDialog extends StatelessWidget {
  const PuzzleDeletingDialog(this.puzzle, {super.key});

  final Puzzle puzzle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(puzzle.title, style: Theme.of(context).textTheme.titleLarge),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                    onPressed: () {
                      context
                          .read<CatalogBloc>()
                          .add(CatalogDeletePuzzle(puzzle));
                      context.pop();
                    },
                    child: const Text('Удалить')),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FilledButton(
                    onPressed: () => context.pop(),
                    child: const Text('Отмена')),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
