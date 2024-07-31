import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class AbstractPuzzleFormField extends StatelessWidget {
  const AbstractPuzzleFormField({
    required this.title,
    required this.onChanged,
    required this.initialValue,
    this.keyboardType,
    this.isRequired = true,
    this.lengthLimit,
    this.inputFormatters,
    this.validatePattern,
    this.minValue,
    super.key,
  });

  final String title;
  final void Function(String) onChanged;
  final String? initialValue;
  final TextInputType? keyboardType;
  final bool isRequired;
  final int? lengthLimit;
  final List<TextInputFormatter>? inputFormatters;
  final String? validatePattern;
  final int? minValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: TextFormField(
        initialValue: initialValue,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters ?? []
          ..add(LengthLimitingTextInputFormatter(lengthLimit)),
        decoration: InputDecoration(
          labelText: title,
          border: const OutlineInputBorder(),
        ),
        autovalidateMode: AutovalidateMode.always,
        validator: (value) {
          if (value == null || value.isEmpty) {
            if (isRequired) return 'Обязательное поле';
          } else {
            if (validatePattern != null) {
              final regexp = RegExp(validatePattern!);
              if (!regexp.hasMatch(value)) return 'Некорректное значение';
            }
            if (minValue != null && minValue! >= double.parse(value)) {
              return 'Минимум $minValue';
            }
          }
          return null;
        },
        onChanged: (value) => onChanged(value),
      ),
    );
  }
}
