import 'package:flutter/material.dart';

import 'package:puzzle_master/app/themes/themes.dart';
import '../widgets/widgets.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppBar(
              title: const Text('Настройки'),
              systemOverlayStyle: getSystemUiOverlayStyle(theme),
            ),
            const SelectThemeCard(),
            const SelectAccentColorCard(),
          ],
        ),
      ),
    );
  }
}
