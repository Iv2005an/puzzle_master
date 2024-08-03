import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:puzzle_master/repositories/catalog/catalog_repository.dart';
import 'package:puzzle_master/repositories/catalog/models/puzzle.dart';
import 'package:puzzle_master/repositories/search/models/filters.dart';

part 'catalog_event.dart';
part 'catalog_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  CatalogBloc() : super(CatalogInitial()) {
    on<CatalogGetPuzzles>((event, emit) {
      final filters = Filters(
          factoryFilters: _factoryFilters,
          elementsCountFilters: _elementsCountFilters);
      try {
        _searchText = event.searchText;
        emit(CatalogLoaded(CatalogRepository.getPuzzles(_searchText, filters),
            _searchText, filters));
      } catch (e) {
        emit(CatalogFailure(e, _searchText, filters));
      }
    });
    on<CatalogAddFilters>((event, emit) {
      _factoryFilters.addAll(event.filters.factoryFilters);
      _elementsCountFilters.addAll(event.filters.elementsCountFilters);
      add(CatalogGetPuzzles(_searchText));
    });
    on<CatalogDeleteFilters>((event, emit) {
      _factoryFilters.removeWhere(
          (element) => event.filters.factoryFilters.contains(element));
      _elementsCountFilters.removeWhere(
          (element) => event.filters.elementsCountFilters.contains(element));
      add(CatalogGetPuzzles(_searchText));
    });
    on<CatalogAddPuzzle>((event, emit) async {
      await CatalogRepository.addPuzzle(event.newPuzzle);
      add(CatalogGetPuzzles(_searchText));
    });
    on<CatalogDeletePuzzle>((event, emit) async {
      await CatalogRepository.deletePuzzle(event.puzzleToDelete);
      add(CatalogGetPuzzles(_searchText));
    });
    on<CatalogEditPuzzle>((event, emit) async {
      await CatalogRepository.editPuzzle(event.puzzleToEdit);
      add(CatalogGetPuzzles(_searchText));
    });
  }
  String _searchText = '';
  final List<String> _factoryFilters = [];
  final List<String> _elementsCountFilters = [];
}
