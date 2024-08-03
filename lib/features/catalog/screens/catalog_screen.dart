import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_master/repositories/search/models/filters.dart';

import '../bloc/catalog_bloc/catalog_bloc.dart';
import '../widgets/widgets.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogBloc, CatalogState>(
      builder: (context, state) {
        final bloc = context.read<CatalogBloc>();
        if (state is CatalogInitial) bloc.add(const CatalogGetPuzzles(''));
        if (state is CatalogLoaded) {
          return DefaultTabController(
            length: 3,
            child: Column(
              children: [
                const SizedBox(height: 32),
                PuzzlesSearchBar(state.searchText, state.filters),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(spacing: 8, children: [
                    ...state.filters.factoryFilters.map((e) => FilterChip(
                        label: Text(e),
                        selected: true,
                        onSelected: (value) => context.read<CatalogBloc>().add(
                            CatalogDeleteFilters(
                                Filters(factoryFilters: [e]))))),
                    ...state.filters.elementsCountFilters.map((e) => FilterChip(
                        label: Text(e),
                        selected: true,
                        onSelected: (value) => context.read<CatalogBloc>().add(
                            CatalogDeleteFilters(
                                Filters(elementsCountFilters: [e]))))),
                  ]),
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
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Произошла ошибка, попробуйте снова',
                    style: Theme.of(context).textTheme.titleMedium),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                          onPressed: () =>
                              bloc.add(CatalogGetPuzzles(state.searchText)),
                          child: const Text('Обновить')),
                    ),
                  ],
                )
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
