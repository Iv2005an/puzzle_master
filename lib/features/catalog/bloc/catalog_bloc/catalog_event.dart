part of 'catalog_bloc.dart';

sealed class CatalogEvent extends Equatable {
  const CatalogEvent();

  @override
  List<Object> get props => [];
}

final class CatalogGetPuzzles extends CatalogEvent {
  const CatalogGetPuzzles(this.searchText);

  final String searchText;

  @override
  List<Object> get props => [searchText];
}

final class CatalogAddFilters extends CatalogEvent {
  const CatalogAddFilters(
      {this.factoryFilter = '', this.elementsCountFilter = ''});

  final String factoryFilter;
  final String elementsCountFilter;

  @override
  List<Object> get props => [factoryFilter, elementsCountFilter];
}

final class CatalogDeleteFilters extends CatalogEvent {
  const CatalogDeleteFilters(
      {this.factoryFilter = '', this.elementsCountFilter = ''});

  final String factoryFilter;
  final String elementsCountFilter;

  @override
  List<Object> get props => [factoryFilter, elementsCountFilter];
}

final class CatalogAddPuzzle extends CatalogEvent {
  const CatalogAddPuzzle(this.newPuzzle);

  final Puzzle newPuzzle;

  @override
  List<Object> get props => [newPuzzle];
}

final class CatalogDeletePuzzle extends CatalogEvent {
  const CatalogDeletePuzzle(this.puzzleToDelete);

  final Puzzle puzzleToDelete;

  @override
  List<Object> get props => [puzzleToDelete];
}

final class CatalogEditPuzzle extends CatalogEvent {
  const CatalogEditPuzzle(this.puzzleToEdit);

  final Puzzle puzzleToEdit;

  @override
  List<Object> get props => [puzzleToEdit];
}
