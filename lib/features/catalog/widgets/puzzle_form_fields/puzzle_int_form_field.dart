import 'package:flutter/services.dart';

import 'abstract_puzzle_form_field.dart';

class PuzzleIntFormField extends AbstractPuzzleFormField {
  PuzzleIntFormField({
    required super.title,
    required super.onChanged,
    super.initialValue,
    super.key,
  }) : super(
            keyboardType: TextInputType.number,
            lengthLimit: 5,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            minValue: 0);
}
