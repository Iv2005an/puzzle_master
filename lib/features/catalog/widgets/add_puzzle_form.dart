import 'package:flutter/material.dart';

import 'package:puzzle_master/features/catalog/widgets/puzzle_form_field.dart';
import 'package:puzzle_master/repositories/catalog/models/puzzle.dart';

import 'image_form_field.dart';

class AddPuzzleForm extends StatelessWidget {
  const AddPuzzleForm(this._formKey, this._newPuzzle, {super.key});

  final GlobalKey<FormState> _formKey;
  final Puzzle _newPuzzle;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ImageFormField(_newPuzzle),
          PuzzleFormField(
            FormFieldType.text,
            'Название*',
            (value) => _newPuzzle.title = value,
          ),
          PuzzleFormField(
            FormFieldType.int,
            'Количество(эл.)*',
            (value) => _newPuzzle.elementsCount = int.tryParse(value) ?? 0,
          ),
          Row(
            children: [
              Expanded(
                child: PuzzleFormField(
                  FormFieldType.double,
                  'Ширина(см)*',
                  (value) => _newPuzzle.width = double.tryParse(value) ?? 0,
                ),
              ),
              Expanded(
                child: PuzzleFormField(
                  FormFieldType.double,
                  'Высота(см)*',
                  (value) => _newPuzzle.height = double.tryParse(value) ?? 0,
                ),
              ),
            ],
          ),
          PuzzleFormField(
            FormFieldType.text,
            isRequired: false,
            'Производитель',
            (value) => _newPuzzle.factory = value,
          ),
          PuzzleFormField(
            FormFieldType.text,
            isRequired: false,
            'Артикул',
            (value) => _newPuzzle.article = value,
          ),
        ],
      ),
    );
  }
}
