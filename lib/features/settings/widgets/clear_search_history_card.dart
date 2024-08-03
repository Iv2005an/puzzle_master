import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:puzzle_master/repositories/search/search_repository.dart';

import 'option_card.dart';

class ClearSearchHistoryCard extends StatelessWidget {
  const ClearSearchHistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return OptionCard('История поиска:', [
      Row(children: [
        Expanded(
            child: FilledButton(
                onPressed: () async {
                  await SearchRepository.clearHistory();
                  if (context.mounted) {
                    await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                          title: const Text('История поиска очищена.'),
                          actions: [
                            FilledButton(
                                onPressed: () => context.pop(),
                                child: const Text('ОК')),
                          ]),
                    );
                  }
                },
                child: const Text('Очистить')))
      ])
    ]);
  }
}
