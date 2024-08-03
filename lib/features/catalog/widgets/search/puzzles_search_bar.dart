import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:puzzle_master/repositories/search/models/filters.dart';
import 'package:puzzle_master/repositories/search/search_repository.dart';

import '../../bloc/catalog_bloc/catalog_bloc.dart';

import 'filters_suggestion_card.dart';
import 'puzzles_suggestion_card.dart';
import 'suggestion_chip.dart';

class PuzzlesSearchBar extends StatelessWidget {
  const PuzzlesSearchBar(this.searchText, this.filters, {super.key});

  final String searchText;
  final Filters filters;

  @override
  Widget build(BuildContext context) {
    final controller = SearchController();
    controller.text = searchText;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SearchAnchor.bar(
        searchController: controller,
        barElevation: const WidgetStatePropertyAll(0),
        viewElevation: 0,
        barPadding:
            const WidgetStatePropertyAll(EdgeInsets.only(left: 16, right: 8)),
        barHintText: 'Поиск',
        barTrailing: const [
          // TODO: Логика вызова поиска по фото
          IconButton(onPressed: null, icon: Icon(Icons.camera_alt_outlined))
        ],
        onChanged: (value) {
          if (value.isEmpty) {
            context.read<CatalogBloc>().add(const CatalogGetPuzzles(''));
          }
        },
        onSubmitted: (value) {
          if (value.trim().isNotEmpty) SearchRepository.addToHistory(value);
          context.read<CatalogBloc>().add(CatalogGetPuzzles(value));
          if (context.canPop()) controller.closeView(value);
        },
        suggestionsBuilder: (context, controller) {
          List<Widget> suggestions = [];
          if (controller.text.isEmpty) {
            final history = SearchRepository.history;
            if (history.isEmpty) {
              suggestions.add(Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text('История пуста',
                          style: Theme.of(context).textTheme.titleMedium))));
            } else {
              suggestions.addAll(history.map((e) => ListTile(
                  leading: const Icon(Icons.history),
                  title: Text(e),
                  onTap: () => controller.text = e)));
            }
          } else {
            final (suggestionTitles, suggestionFilters) =
                SearchRepository.getSuggestions(controller.text, filters);
            if (suggestionFilters.factoryFilters.isNotEmpty) {
              suggestions.add(FiltersSuggestionCard(
                  'Производители:',
                  suggestionFilters.factoryFilters
                      .map((e) =>
                          SuggestionChip(e, controller, factoryFilter: e))
                      .toList()));
            }
            if (suggestionFilters.elementsCountFilters.isNotEmpty) {
              suggestions.add(FiltersSuggestionCard(
                  'Количество элементов:',
                  suggestionFilters.elementsCountFilters
                      .map((e) =>
                          SuggestionChip(e, controller, elementsCountFilter: e))
                      .toList()));
            }
            if (suggestionTitles.isNotEmpty) {
              suggestions.add(PuzzlesSuggestionCard(
                  'Пазлы:', suggestionTitles, controller));
            } else {
              suggestions.add(Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text('Совпадения не найдены',
                          style: Theme.of(context).textTheme.titleMedium))));
            }
          }
          return suggestions;
        },
      ),
    );
  }
}
