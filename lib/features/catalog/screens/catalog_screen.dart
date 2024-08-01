import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/catalog_bloc/catalog_bloc.dart';
import '../widgets/widgets.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogBloc, CatalogState>(
      builder: (context, state) {
        final bloc = context.read<CatalogBloc>();
        if (state is CatalogInitial) bloc.add(CatalogGetPuzzles());
        if (state is CatalogLoaded) {
          return DefaultTabController(
            length: 3,
            child: Column(
              children: [
                const SizedBox(height: 32),
                const PuzzlesSearchBar(),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Wrap(
                    spacing: 8,
                    children: [
                      Chip(label: Text('data')),
                      Chip(label: Text('data')),
                      Chip(label: Text('data')),
                      Chip(label: Text('data')),
                      Chip(label: Text('data')),
                      Chip(label: Text('data')),
                    ],
                  ),
                ),
                const TabBar(
                  tabs: [
                    Tab(child: Text('Все')),
                    Tab(child: Text('Избранное')),
                    Tab(child: Text('История')),
                  ],
                ),
                Expanded(
                  child: TabBarView(children: [
                    PuzzlesList(
                      state.puzzles,
                      isAddButton: true,
                    ),
                    PuzzlesList(
                      state.puzzles
                          .where((element) => element.isFavorite)
                          .toList(),
                    ),
                    PuzzlesList(
                      state.puzzles
                          .where((element) => element.isInHistory)
                          .toList(),
                    ),
                  ]),
                )
              ],
            ),
          );
        }
        if (state is CatalogFailure) {
          return Center(
            child: Column(
              children: [
                const Text('Произошла ошибка, попробуйте снова'),
                FilledButton(
                    onPressed: () => bloc.add(CatalogGetPuzzles()),
                    child: const Text('Обновить'))
              ],
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
