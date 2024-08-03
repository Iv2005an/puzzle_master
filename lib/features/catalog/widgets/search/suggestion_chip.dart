import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:puzzle_master/repositories/search/search_repository.dart';

import '../../bloc/catalog_bloc/catalog_bloc.dart';

class SuggestionChip extends StatelessWidget {
  const SuggestionChip(this.title, this.controller,
      {this.factoryFilter = '', this.elementsCountFilter = '', super.key});

  final String title;
  final SearchController controller;
  final String factoryFilter;
  final String elementsCountFilter;

  @override
  Widget build(BuildContext context) {
    return InputChip(
      label: Text(title),
      onPressed: () {
        controller.closeView('');
        SearchRepository.addToHistory(title);
        context.read<CatalogBloc>().add(CatalogAddFilters(
            factoryFilter: factoryFilter,
            elementsCountFilter: elementsCountFilter));
      },
    );
  }
}
