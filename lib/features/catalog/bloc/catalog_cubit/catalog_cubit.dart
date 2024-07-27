import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:puzzle_master/repositories/catalog/catalog_repository.dart';
import 'package:puzzle_master/repositories/catalog/models/puzzle.dart';

part 'catalog_state.dart';

class CatalogCubit extends Cubit<CatalogState> {
  CatalogCubit(this._catalogRepository) : super(CatalogInitial());

  final CatalogRepository _catalogRepository;

  void addPuzzle(Puzzle newPuzzle) {
    _catalogRepository.addPuzzle(newPuzzle);
  }
}
