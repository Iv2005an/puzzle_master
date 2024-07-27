import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum FormFieldType { text, int, double }

class PuzzleFormField extends StatelessWidget {
  const PuzzleFormField(
    this.formFieldType,
    this.title,
    this.onSave, {
    super.key,
    this.isRequired = true,
  });

  final FormFieldType formFieldType;
  final String title;
  final void Function(String) onSave;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter> inputFormatters = [
      LengthLimitingTextInputFormatter(
          formFieldType == FormFieldType.text ? 64 : 5),
    ];
    if (formFieldType == FormFieldType.int) {
      inputFormatters.add(FilteringTextInputFormatter.digitsOnly);
    } else if (formFieldType == FormFieldType.double) {
      inputFormatters.add(FilteringTextInputFormatter.allow(RegExp('[0-9.]')));
    }
    return Padding(
      padding: const EdgeInsets.all(4),
      child: TextFormField(
        keyboardType:
            formFieldType == FormFieldType.text ? null : TextInputType.number,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          labelText: title,
          border: const OutlineInputBorder(),
        ),
        autovalidateMode: AutovalidateMode.always,
        validator: (value) {
          if (value == null || value.isEmpty) {
            if (isRequired) return 'Обязательное поле';
          } else {
            if (formFieldType != FormFieldType.text) {
              final numValue = double.tryParse(value);
              if (numValue == null) return 'Некорректное значение';
              if (numValue == 0) return 'Минимум 1';
            }
          }
          return null;
        },
        onChanged: (value) => onSave(value),
      ),
    );
  }
}
