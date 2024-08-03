import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_master/repositories/search/search_repository.dart';

import '../../bloc/catalog_bloc/catalog_bloc.dart';

class SuggestionTile extends StatelessWidget {
  const SuggestionTile(this.title, this.controller, {super.key});

  final String title;
  final SearchController controller;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: () {
        SearchRepository.addToHistory(title);
        context.read<CatalogBloc>().add(CatalogGetPuzzles(title));
        controller.closeView(title);
      },
    );
  }
}
