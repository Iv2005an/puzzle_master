import 'package:flutter/services.dart';

import 'abstract_puzzle_form_field.dart';

class PuzzleTextFormField extends AbstractPuzzleFormField {
  PuzzleTextFormField({
    required super.title,
    required super.onChanged,
    super.initialValue,
    super.isRequired,
    super.key,
  }) : super(
          lengthLimit: 32,
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(r'^\s+')),
            FilteringTextInputFormatter.deny(RegExp(r'\s{2,}'),
                replacementString: ' '),
          ],
        );
}
