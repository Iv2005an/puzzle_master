import 'package:flutter/material.dart';

import 'suggestion_card.dart';
import 'suggestion_tile.dart';

class PuzzlesSuggestionCard extends SuggestionCard {
  PuzzlesSuggestionCard(
      String title, List<String> puzzles, SearchController controller,
      {super.key})
      : super(
            title,
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                  children: puzzles
                      .map((title) => SuggestionTile(title, controller))
                      .toList()),
            ));
}
