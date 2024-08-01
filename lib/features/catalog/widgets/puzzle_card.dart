import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:puzzle_master/repositories/catalog/models/puzzle.dart';
import 'package:puzzle_master/services/converter_service.dart';

import '../bloc/catalog_bloc/catalog_bloc.dart';

class PuzzleCard extends StatelessWidget {
  const PuzzleCard(this.puzzle, {super.key});

  final Puzzle puzzle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    List<Widget> items = [
      Text(
        puzzle.title,
        style: textTheme.titleLarge,
      ),
      Text(
        'Характеристики:',
        style: textTheme.bodySmall,
      ),
      Wrap(
        spacing: 8,
        children: [
          Chip(
            avatar: const Icon(Icons.extension_outlined),
            label: Text('${puzzle.elementsCount}'),
          ),
          Chip(
            avatar:
                const RotatedBox(quarterTurns: 1, child: Icon(Icons.height)),
            label: Text(ConverterService.doubleToString(puzzle.width)),
          ),
          Chip(
            avatar: const Icon(Icons.height),
            label: Text(ConverterService.doubleToString(puzzle.height)),
          ),
        ],
      ),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(children: [
          // TODO: Логика
          IconButton.outlined(
              onPressed: () =>
                  context.read<CatalogBloc>().add(CatalogDeletePuzzle(puzzle)),
              icon: const Icon(Icons.delete_outline)),
          // TODO: Логика
          IconButton.outlined(
              onPressed: () {}, icon: const Icon(Icons.edit_outlined)),
        ]),
        Row(children: [
          puzzle.isFavorite
              // TODO: Логика
              ? IconButton.filled(
                  onPressed: () {}, icon: const Icon(Icons.favorite))
              // TODO: Логика
              : IconButton.outlined(
                  onPressed: () {}, icon: const Icon(Icons.favorite_outline)),
          const SizedBox(width: 4),
          // TODO: Логика
          FilledButton(onPressed: () {}, child: const Text('Сканирование')),
        ]),
      ])
    ];
    if (puzzle.article.isNotEmpty) items.insert(2, Text(puzzle.article));
    if (puzzle.factory.isNotEmpty) items.insert(2, Text(puzzle.factory));
    // return FractionallySizedBox(
    //   widthFactor: 0.5,
    //   heightFactor: 0.5,
    //   child: Container(
    //       color: Color((Random().nextDouble() * 0xFFFFFF).toInt())
    //           .withOpacity(1.0)),
    // );
    return Card.outlined(
        child: Column(children: [
      // ClipRRect(
      //     borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      //     child: Image.memory(puzzle.image, fit: BoxFit.fitWidth)),
      Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, children: items))
    ]));
  }
}
