import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:puzzle_master/repositories/catalog/models/puzzle.dart';

import '../bloc/catalog_bloc/catalog_bloc.dart';

import 'puzzle_form_fields/puzzle_form_fields.dart';

class PuzzleDataDialog extends StatefulWidget {
  const PuzzleDataDialog({this.puzzleToEdit, super.key});

  final Puzzle? puzzleToEdit;

  @override
  State<PuzzleDataDialog> createState() => _PuzzleDataDialogState();
}

class _PuzzleDataDialogState extends State<PuzzleDataDialog> {
  final formKey = GlobalKey<FormState>();
  bool isAddButtonEnabled = false;
  bool isEditMode = false;

  int? id;
  Uint8List? image;
  String? title;
  int? elementsCount;
  double? width;
  double? height;
  String article = '';
  String factory = '';

  @override
  void initState() {
    if (widget.puzzleToEdit != null) {
      isEditMode = true;
      final puzzleToEdit = widget.puzzleToEdit!;
      id = puzzleToEdit.id;
      image = puzzleToEdit.image;
      title = puzzleToEdit.title;
      elementsCount = puzzleToEdit.elementsCount;
      width = puzzleToEdit.width;
      height = puzzleToEdit.height;
      article = puzzleToEdit.article;
      factory = puzzleToEdit.factory;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: formKey,
              onChanged: () {
                final formStatus = formKey.currentState!.validate();
                if (isAddButtonEnabled != formStatus) {
                  setState(() => isAddButtonEnabled = formStatus);
                }
              },
              child: Column(
                children: [
                  PuzzleImageFormField(
                    initialValue: image,
                    onChanged: (value) async {
                      image = value;
                    },
                  ),
                  PuzzleTextFormField(
                    title: 'Название*',
                    initialValue: title,
                    onChanged: (value) => title = value,
                  ),
                  PuzzleIntFormField(
                    title: 'Количество(эл.)*',
                    initialValue: elementsCount?.toString(),
                    onChanged: (value) =>
                        elementsCount = int.tryParse(value) ?? 0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: PuzzleDoubleFormField(
                          title: 'Ширина(см)*',
                          initialValue: width?.toString(),
                          onChanged: (value) =>
                              width = double.tryParse(value) ?? 0,
                        ),
                      ),
                      Expanded(
                        child: PuzzleDoubleFormField(
                          title: 'Высота(см)*',
                          initialValue: height?.toString(),
                          onChanged: (value) =>
                              height = double.tryParse(value) ?? 0,
                        ),
                      ),
                    ],
                  ),
                  PuzzleTextFormField(
                    title: 'Производитель',
                    isRequired: false,
                    initialValue: factory,
                    onChanged: (value) => factory = value,
                  ),
                  PuzzleTextFormField(
                    title: 'Артикул',
                    isRequired: false,
                    initialValue: article,
                    onChanged: (value) => article = value,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                      onPressed: isAddButtonEnabled
                          ? () async {
                              final puzzle = Puzzle(
                                  id,
                                  image!,
                                  title!.trim(),
                                  elementsCount!,
                                  width!,
                                  height!,
                                  factory.trim(),
                                  article.trim(),
                                  false,
                                  false);
                              if (isEditMode) {
                                context
                                    .read<CatalogBloc>()
                                    .add(CatalogEditPuzzle(puzzle));
                              } else {
                                context
                                    .read<CatalogBloc>()
                                    .add(CatalogAddPuzzle(puzzle));
                              }
                              context.pop();
                            }
                          : null,
                      child:
                          Text('${isEditMode ? 'Изменить' : 'Добавить'} пазл')),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
