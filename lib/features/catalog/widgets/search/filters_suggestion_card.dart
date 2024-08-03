import 'package:flutter/widgets.dart';

import 'suggestion_card.dart';

class FiltersSuggestionCard extends SuggestionCard {
  FiltersSuggestionCard(String title, List<Widget> filterChips, {super.key})
      : super(
            title,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(spacing: 8, children: filterChips),
            ));
}
