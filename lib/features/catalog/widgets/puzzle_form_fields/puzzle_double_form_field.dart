import 'package:flutter/services.dart';

import 'abstract_puzzle_form_field.dart';

class PuzzleDoubleFormField extends AbstractPuzzleFormField {
  PuzzleDoubleFormField({
    required super.title,
    required super.onChanged,
    super.initialValue,
    super.key,
  }) : super(
            keyboardType: TextInputType.number,
            lengthLimit: 5,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
              TextInputFormatter.withFunction(
                  (oldValue, newValue) => newValue.text.isEmpty
                      ? newValue
                      : double.tryParse(newValue.text) == null
                          ? oldValue
                          : newValue)
            ],
            minValue: 0);
}
