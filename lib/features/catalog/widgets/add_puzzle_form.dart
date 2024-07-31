import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:puzzle_master/repositories/catalog/models/puzzle.dart';

import '../bloc/catalog_bloc/catalog_bloc.dart';

import 'puzzle_form_fields/puzzle_form_fields.dart';

class AddPuzzleForm extends StatefulWidget {
  const AddPuzzleForm({super.key});

  @override
  State<AddPuzzleForm> createState() => _AddPuzzleFormState();
}

class _AddPuzzleFormState extends State<AddPuzzleForm> {
  final formKey = GlobalKey<FormState>();
  bool isAddButtonEnabled = false;

  Uint8List? image;
  String? title;
  int? elementsCount;
  double? width;
  double? height;
  String article = '';
  String factory = '';

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
                    onChanged: (value) => image = value,
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
                          ? () {
                              context
                                  .read<CatalogBloc>()
                                  .add(CatalogAddPuzzle(Puzzle(
                                    image!,
                                    title!,
                                    elementsCount!,
                                    width!,
                                    height!,
                                    factory,
                                    article,
                                    false,
                                  )));
                              context.pop();
                            }
                          : null,
                      child: const Text('Добавить пазл')),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
