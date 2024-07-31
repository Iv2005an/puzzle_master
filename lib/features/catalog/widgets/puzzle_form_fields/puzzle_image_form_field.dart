import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:puzzle_master/services/image_service.dart';

class PuzzleImageFormField extends StatelessWidget {
  const PuzzleImageFormField({
    required this.initialValue,
    required this.onChanged,
    super.key,
  });

  final Uint8List? initialValue;
  final void Function(Uint8List) onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FormField<Uint8List>(
        initialValue: initialValue,
        validator: (value) => value == null ? '' : null,
        builder: (field) {
          RoundedRectangleBorder? cardBorder;
          cardBorder = const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ).copyWith(
              side: BorderSide(
                  width: field.isValid ? 1 : 2,
                  color: field.isValid
                      ? theme.colorScheme.outlineVariant
                      : theme.colorScheme.error));
          return Card.outlined(
            shape: cardBorder,
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  field.value == null
                      ? Row(children: [
                          Text('Выберите изображение*',
                              style: TextStyle(color: theme.colorScheme.error))
                        ])
                      : ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          child: Image.memory(field.value!)),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () async {
                              Uint8List? image =
                                  await ImageService.pickImageFromCamera();
                              if (image != null) {
                                onChanged(image);
                                field.didChange(image);
                              }
                            },
                            child: const Text('Камера'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton(
                              onPressed: () async {
                                Uint8List? image =
                                    await ImageService.pickImageFromGallery();
                                if (image != null) {
                                  onChanged(image);
                                  field.didChange(image);
                                }
                              },
                              child: const Text('Галерея')),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
