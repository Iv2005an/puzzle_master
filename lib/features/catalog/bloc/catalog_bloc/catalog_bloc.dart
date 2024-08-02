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
        emit(CatalogLoaded(CatalogRepository.puzzles));
      } catch (e) {
        emit(CatalogFailure(e));
      }
    });
    on<CatalogAddPuzzle>((event, emit) async {
      await CatalogRepository.addPuzzle(event.newPuzzle);
      try {
        emit(CatalogLoaded(CatalogRepository.puzzles));
      } catch (e) {
        emit(CatalogFailure(e));
      }
    });
    on<CatalogDeletePuzzle>((event, emit) async {
      await CatalogRepository.deletePuzzle(event.puzzleToDelete);
      try {
        emit(CatalogLoaded(CatalogRepository.puzzles));
      } catch (e) {
        emit(CatalogFailure(e));
      }
    });
    on<CatalogEditPuzzle>((event, emit) async {
      await CatalogRepository.editPuzzle(event.puzzleToEdit);
      try {
        emit(CatalogLoaded(CatalogRepository.puzzles));
      } catch (e) {
        emit(CatalogFailure(e));
      }
    });
  }
}
