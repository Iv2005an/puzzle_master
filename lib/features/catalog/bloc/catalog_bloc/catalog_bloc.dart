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
      try {
        _searchText = event.searchText;
        emit(CatalogLoaded(CatalogRepository.getPuzzles(_searchText, _filters),
            _searchText, _filters));
      } catch (e) {
        emit(CatalogFailure(e, _searchText, _filters));
      }
    });
    on<CatalogAddFilters>((event, emit) {
      try {
        _filters.factoryFilters.addAll(event.filters.factoryFilters);
        _filters.elementsCountFilters
            .addAll(event.filters.elementsCountFilters);
        emit(CatalogLoaded(CatalogRepository.getPuzzles(_searchText, _filters),
            _searchText, _filters));
      } catch (e) {
        emit(CatalogFailure(e, _searchText, _filters));
      }
    });
    on<CatalogDeleteFilters>((event, emit) {
      try {
        _filters.factoryFilters.removeWhere(
            (element) => event.filters.factoryFilters.contains(element));
        _filters.elementsCountFilters.removeWhere(
            (element) => event.filters.elementsCountFilters.contains(element));
        emit(CatalogLoaded(CatalogRepository.getPuzzles(_searchText, _filters),
            _searchText, _filters));
      } catch (e) {
        emit(CatalogFailure(e, _searchText, _filters));
      }
    });
    on<CatalogAddPuzzle>((event, emit) async {
      await CatalogRepository.addPuzzle(event.newPuzzle);
      try {
        emit(CatalogLoaded(CatalogRepository.getPuzzles(_searchText, _filters),
            _searchText, _filters));
      } catch (e) {
        emit(CatalogFailure(e, _searchText, _filters));
      }
    });
    on<CatalogDeletePuzzle>((event, emit) async {
      await CatalogRepository.deletePuzzle(event.puzzleToDelete);
      try {
        emit(CatalogLoaded(CatalogRepository.getPuzzles(_searchText, _filters),
            _searchText, _filters));
      } catch (e) {
        emit(CatalogFailure(e, _searchText, _filters));
      }
    });
    on<CatalogEditPuzzle>((event, emit) async {
      await CatalogRepository.editPuzzle(event.puzzleToEdit);
      try {
        emit(CatalogLoaded(CatalogRepository.getPuzzles(_searchText, _filters),
            _searchText, _filters));
      } catch (e) {
        emit(CatalogFailure(e, _searchText, _filters));
      }
    });
  }
  String _searchText = '';
  final _filters = const Filters();
}
