import 'package:hive_flutter/hive_flutter.dart';

import '../catalog/catalog_repository.dart';
import 'models/filters.dart';

class SearchRepository {
  static const searchStorageName = 'search';
  static final Box<String> _searchStorage = Hive.box<String>(searchStorageName);

  static List<String> get history =>
      _searchStorage.values.toList().reversed.toList();
  static Future<void> addToHistory(String s) async {
    int repeatableValueIndex = _searchStorage.values.toList().indexOf(s);
    if (repeatableValueIndex != -1) {
      await _searchStorage.deleteAt(repeatableValueIndex);
    }
    await _searchStorage.add(s);
  }

  static Future<void> clearHistory() async => await _searchStorage.clear();

  static (List<String>, Filters) getSuggestions(
    String searchText,
    Filters filters,
  ) {
    if (searchText.isEmpty) return (const [], const Filters());
    searchText = searchText.toLowerCase();
    final factoryFilters = <String>[];
    final elementsCountFilters = <String>[];
    for (var puzzle in CatalogRepository.getPuzzles('', const Filters())) {
      if (!factoryFilters.contains(puzzle.factory) &&
          puzzle.factory.toLowerCase().contains(searchText)) {
        factoryFilters.add(puzzle.factory);
      }
      if (!elementsCountFilters.contains('${puzzle.elementsCount}') &&
          '${puzzle.elementsCount}'.toLowerCase().contains(searchText)) {
        elementsCountFilters.add('${puzzle.elementsCount}');
      }
    }
    return (
      (CatalogRepository.getPuzzles(searchText, filters)
          .map((puzzle) => puzzle.title)
          .toList()),
      Filters(
          factoryFilters: factoryFilters,
          elementsCountFilters: elementsCountFilters)
    );
  }
}
