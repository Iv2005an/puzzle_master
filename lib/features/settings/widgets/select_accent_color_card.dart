import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

import 'package:puzzle_master/app/bloc/settings_cubit/settings_cubit.dart';
import 'package:puzzle_master/features/settings/widgets/option_card.dart';

class SelectAccentColorCard extends StatelessWidget {
  const SelectAccentColorCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        List<Widget> children = [
          SizedBox(
            width: double.infinity,
            child: SegmentedButton(
              showSelectedIcon: false,
              segments: const [
                ButtonSegment(value: true, label: Text('Системный')),
                ButtonSegment(value: false, label: Text('Свой')),
              ],
              selected: {state.isSystemAccentColor},
              onSelectionChanged: (value) async {
                await context
                    .read<SettingsCubit>()
                    .setIsSystemAccentColor(value.first);
              },
            ),
          ),
          AnimatedSize(
            duration: Durations.short2,
            clipBehavior: Clip.none,
            child: Visibility(
              visible: !state.isSystemAccentColor,
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: MaterialColorPicker(
                  elevation: 0,
                  allowShades: false,
                  selectedColor: state.accentColor,
                  onMainColorChange: (value) async {
                    if (value != null) {
                      await context.read<SettingsCubit>().setAccentColor(value);
                    }
                  },
                ),
              ),
            ),
          )
        ];
        return OptionCard('Цветовой акцент:', children);
      },
    );
  }
}
