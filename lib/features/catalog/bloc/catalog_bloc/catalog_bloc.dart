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
          factoryFilters: List.from(_factoryFilters),
          elementsCountFilters: List.from(_elementsCountFilters));
      try {
        _searchText = event.searchText;
        emit(CatalogLoaded(CatalogRepository.getPuzzles(_searchText, filters),
            _searchText, filters));
      } catch (e) {
        emit(CatalogFailure(e, _searchText, filters));
      }
    });
    on<CatalogAddFilters>((event, emit) {
      if (event.factoryFilter.isNotEmpty ||
          event.elementsCountFilter.isNotEmpty) {
        if (event.factoryFilter.isNotEmpty &&
            !_factoryFilters.contains(event.factoryFilter)) {
          _factoryFilters.add(event.factoryFilter);
        }
        if (event.elementsCountFilter.isNotEmpty &&
            !_elementsCountFilters.contains(event.elementsCountFilter)) {
          _elementsCountFilters.add(event.elementsCountFilter);
        }
        add(CatalogGetPuzzles(_searchText));
      }
    });
    on<CatalogDeleteFilters>((event, emit) {
      if (event.factoryFilter.isNotEmpty ||
          event.elementsCountFilter.isNotEmpty) {
        _factoryFilters.remove(event.factoryFilter);
        _elementsCountFilters.remove(event.elementsCountFilter);
        add(CatalogGetPuzzles(_searchText));
      }
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
