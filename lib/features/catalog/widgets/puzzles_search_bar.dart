import 'package:flutter/material.dart';

class PuzzlesSearchBar extends StatelessWidget {
  const PuzzlesSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SearchAnchor.bar(
        isFullScreen: false,
        barElevation: const WidgetStatePropertyAll(0),
        viewElevation: 0,
        barPadding:
            const WidgetStatePropertyAll(EdgeInsets.only(left: 16, right: 8)),
        barHintText: 'Поиск',
        barTrailing: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.camera_alt_outlined))
        ],
        suggestionsBuilder: (context, controller) => [],
      ),
    );
  }
}
