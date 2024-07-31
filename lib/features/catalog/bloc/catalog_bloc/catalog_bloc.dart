import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:puzzle_master/repositories/catalog/catalog_repository.dart';
import 'package:puzzle_master/repositories/catalog/models/puzzle.dart';

part 'catalog_event.dart';
part 'catalog_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  CatalogBloc() : super(CatalogInitial()) {
    on<CatalogGetPuzzles>((event, emit) {
      try {
        final puzzles = CatalogRepository.getPuzzles();
        emit(CatalogLoaded(puzzles));
      } catch (e) {
        emit(CatalogFailure(e));
      }
    });
    on<CatalogAddPuzzle>((event, emit) {
      CatalogRepository.addPuzzle(event.newPuzzle);
      try {
        final puzzles = CatalogRepository.getPuzzles();
        emit(CatalogLoaded(puzzles));
      } catch (e) {
        emit(CatalogFailure(e));
      }
    });
  }
}
