import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:puzzle_master/features/catalog/bloc/catalog_cubit/catalog_cubit.dart';
import 'package:puzzle_master/features/catalog/widgets/add_puzzle_form.dart';
import 'package:puzzle_master/features/catalog/widgets/puzzles_search_bar.dart';
import 'package:puzzle_master/repositories/catalog/models/puzzle.dart';
import 'package:puzzle_master/services/orientation_service.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogCubit, CatalogState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
              elevation: 0,
              tooltip: 'Добавить пазл',
              onPressed: () => _showAddPuzzleDialog(context),
              child: const Icon(Icons.add_photo_alternate_outlined)),
          body: const DefaultTabController(
            length: 3,
            child: Column(
              children: [
                SizedBox(height: 32),
                PuzzlesSearchBar(),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Wrap(
                    spacing: 8,
                    children: [
                      Chip(label: Text('data')),
                      Chip(label: Text('data')),
                      Chip(label: Text('data')),
                      Chip(label: Text('data')),
                      Chip(label: Text('data')),
                      Chip(label: Text('data')),
                    ],
                  ),
                ),
                TabBar(
                  tabs: [
                    Tab(child: Text('Все')),
                    Tab(child: Text('Избранное')),
                    Tab(child: Text('История')),
                  ],
                ),
                Expanded(
                  child: TabBarView(children: [
                    Placeholder(),
                    Placeholder(),
                    Placeholder(),
                  ]),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> _showAddPuzzleDialog(BuildContext context) {
    OrientationService.lockPortraitOrientation();
    final formKey = GlobalKey<FormState>();
    return showAdaptiveDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        final newPuzzle = Puzzle.lateInit();
        return AlertDialog(
          scrollable: true,
          title: const Text('Добавление пазла'),
          content: AddPuzzleForm(formKey, newPuzzle),
          actions: [
            OutlinedButton(
              onPressed: () {
                OrientationService.unlockScreenOrientation();
                context.pop();
              },
              child: const Text('Отмена'),
            ),
            FilledButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  context.read<CatalogCubit>().addPuzzle(newPuzzle);
                  OrientationService.unlockScreenOrientation();
                  context.pop();
                }
              },
              child: const Text('Добавить'),
            ),
          ],
        );
      },
    );
  }
}
