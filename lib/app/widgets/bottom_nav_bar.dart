import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar(this.navigationShell, {super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.grid_view),
          selectedIcon: Icon(Icons.grid_view_rounded),
          label: 'Каталог',
          tooltip: '',
        ),
        NavigationDestination(
          icon: Icon(Icons.camera_alt_outlined),
          selectedIcon: Icon(Icons.camera_alt),
          label: 'Сканер',
          tooltip: '',
        ),
        NavigationDestination(
          icon: Icon(Icons.settings_outlined),
          selectedIcon: Icon(Icons.settings),
          label: 'Настройки',
          tooltip: '',
        ),
      ],
      selectedIndex: navigationShell.currentIndex,
      onDestinationSelected: (value) => navigationShell.goBranch(
        value,
        initialLocation: value == navigationShell.currentIndex,
      ),
    );
  }
}
