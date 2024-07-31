part of 'catalog_bloc.dart';

sealed class CatalogEvent extends Equatable {
  const CatalogEvent();

  @override
  List<Object> get props => [];
}

final class CatalogGetPuzzles extends CatalogEvent {}

final class CatalogAddPuzzle extends CatalogEvent {
  const CatalogAddPuzzle(this.newPuzzle);

  final Puzzle newPuzzle;

  @override
  List<Object> get props => [newPuzzle];
}
