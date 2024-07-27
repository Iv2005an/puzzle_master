import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:puzzle_master/app/bloc/settings_cubit/settings_cubit.dart';

import 'option_card.dart';

class SelectThemeCard extends StatelessWidget {
  const SelectThemeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return OptionCard('Выбор темы:', [
      SizedBox(
        width: double.infinity,
        child: SegmentedButton(
            showSelectedIcon: false,
            segments: const [
              ButtonSegment(value: ThemeMode.system, label: Text('Системная')),
              ButtonSegment(value: ThemeMode.light, label: Text('Светлая')),
              ButtonSegment(value: ThemeMode.dark, label: Text('Тёмная')),
            ],
            selected: {context.watch<SettingsCubit>().state.themeMode},
            onSelectionChanged: (value) async =>
                await context.read<SettingsCubit>().setThemeMode(value.first)),
      ),
    ]);
  }
}
