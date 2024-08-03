part of 'catalog_bloc.dart';

sealed class CatalogState extends Equatable {
  const CatalogState();

  @override
  List<Object> get props => [];
}

final class CatalogInitial extends CatalogState {}

final class CatalogLoaded extends CatalogState {
  const CatalogLoaded(this.puzzles, this.searchText, this.filters);

  final List<Puzzle> puzzles;
  final String searchText;
  final Filters filters;

  @override
  List<Object> get props => [puzzles, searchText, filters];
}

final class CatalogFailure extends CatalogState {
  const CatalogFailure(this.exception, this.searchText, this.filters);

  final Object exception;
  final String searchText;
  final Filters filters;

  @override
  List<Object> get props => [exception, searchText, filters];
}
