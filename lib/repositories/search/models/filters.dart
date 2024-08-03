import 'package:equatable/equatable.dart';

class Filters extends Equatable {
  const Filters({
    this.factoryFilters = const [],
    this.elementsCountFilters = const [],
  });

  final List<String> factoryFilters;
  final List<String> elementsCountFilters;

  @override
  List<Object?> get props =>
      [factoryFilters, elementsCountFilters];
}
