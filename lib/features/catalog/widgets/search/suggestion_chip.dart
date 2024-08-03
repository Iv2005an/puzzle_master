import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:puzzle_master/repositories/search/models/filters.dart';
import 'package:puzzle_master/repositories/search/search_repository.dart';

import '../../bloc/catalog_bloc/catalog_bloc.dart';

class SuggestionChip extends StatelessWidget {
  const SuggestionChip(this.title, this.filters, this.controller, {super.key});

  final String title;
  final Filters filters;
  final SearchController controller;

  @override
  Widget build(BuildContext context) {
    return InputChip(
      label: Text(title),
      onPressed: () {
        controller.closeView('');
        SearchRepository.addToHistory(title);
        context.read<CatalogBloc>().add(CatalogAddFilters(filters));
      },
    );
  }
}
