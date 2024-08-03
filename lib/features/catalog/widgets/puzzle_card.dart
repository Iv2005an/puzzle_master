import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:puzzle_master/repositories/catalog/models/puzzle.dart';
import 'package:puzzle_master/services/converter_service.dart';

import '../bloc/catalog_bloc/catalog_bloc.dart';

import 'puzzle_data_dialog.dart';
import 'puzzle_deleting_dialog.dart';

class PuzzleCard extends StatelessWidget {
  const PuzzleCard(this.puzzle, {this.isCompact = false, super.key});

  final Puzzle puzzle;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    List<Widget> actionButtons = [
      IconButton.outlined(
        onPressed: () => showModalBottomSheet(
            builder: (context) => PuzzleDeletingDialog(puzzle),
            context: context),
        icon: const Icon(Icons.delete_outline),
      ),
      IconButton.outlined(
        onPressed: () => showModalBottomSheet(
            useRootNavigator: true,
            useSafeArea: true,
            isDismissible: false,
            isScrollControlled: true,
            context: context,
            builder: (context) => Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: PuzzleDataDialog(
                    puzzleToEdit: puzzle,
                  ),
                )),
        icon: const Icon(Icons.edit_outlined),
      ),
      puzzle.isFavorite
          ? IconButton.filled(
              onPressed: () => context
                  .read<CatalogBloc>()
                  .add(CatalogEditPuzzle(puzzle.copyWith(isFavorite: false))),
              icon: const Icon(Icons.favorite))
          : IconButton.outlined(
              onPressed: () => context
                  .read<CatalogBloc>()
                  .add(CatalogEditPuzzle(puzzle.copyWith(isFavorite: true))),
              icon: const Icon(Icons.favorite_outline)),
      const SizedBox(width: 4),
      const Expanded(
        // TODO: Логика вызова сканирования
        child: FilledButton(onPressed: null, child: Text('Сканирование')),
      )
    ];

    List<Widget> children = [
      Text(
        puzzle.title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      Wrap(spacing: 8, children: [
        InputChip(
          avatar: const Icon(Icons.extension_outlined),
          label: Text('${puzzle.elementsCount} эл.'),
          onPressed: () => context.read<CatalogBloc>().add(CatalogAddFilters(
              elementsCountFilter: '${puzzle.elementsCount}')),
        ),
        Chip(
          avatar: const RotatedBox(
              quarterTurns: 1, child: Icon(Icons.height_outlined)),
          label: Text('${ConverterService.doubleToString(puzzle.width)} см'),
        ),
        Chip(
          avatar: const Icon(Icons.height_outlined),
          label: Text('${ConverterService.doubleToString(puzzle.height)} см'),
        ),
      ]),
      Row(children: actionButtons),
    ];
    List<Widget> optionalChips = [];
    if (puzzle.article.isNotEmpty) {
      optionalChips.add(Chip(
        avatar: const Icon(Icons.numbers_outlined),
        label: Text(puzzle.article),
      ));
      if (puzzle.factory.isNotEmpty) {
        optionalChips.add(InputChip(
            avatar: const Icon(Icons.factory_outlined),
            label: Text(puzzle.factory),
            onPressed: () => context
                .read<CatalogBloc>()
                .add(CatalogAddFilters(factoryFilter: puzzle.factory))));
      }
    }
    if (optionalChips.isNotEmpty) {
      children.insert(1, Wrap(spacing: 8, children: optionalChips));
    }

    return Card.outlined(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Column(children: [
        ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.memory(puzzle.image)),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: children),
        )
      ]),
    );
  }
}
