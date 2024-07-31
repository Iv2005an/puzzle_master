part of 'catalog_bloc.dart';

sealed class CatalogState extends Equatable {
  const CatalogState();

  @override
  List<Object> get props => [];
}

final class CatalogInitial extends CatalogState {}

final class CatalogLoaded extends CatalogState {
  const CatalogLoaded(this.puzzles);

  final List<Puzzle> puzzles;

  @override
  List<Object> get props => [puzzles];
}

final class CatalogFailure extends CatalogState {
  const CatalogFailure(this.exception);

  final Object exception;

  @override
  List<Object> get props => [exception];
}
