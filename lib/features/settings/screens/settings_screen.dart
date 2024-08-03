import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle('Тема'),
            SelectThemeCard(),
            SelectAccentColorCard(),
            SectionTitle('История'),
            ClearSearchHistoryCard()
          ],
        ),
      ),
    );
  }
}
