import 'package:flutter/material.dart';

class SuggestionCard extends StatelessWidget {
  const SuggestionCard(this.title, this.child, {super.key});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title, style: Theme.of(context).textTheme.titleLarge)),
      child
    ]));
  }
}
