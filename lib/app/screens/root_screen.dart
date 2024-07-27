import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../widgets/bottom_nav_bar.dart';

class RootScreen extends StatelessWidget {
  const RootScreen(this.navigationShell, {super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavBar(navigationShell),
    );
  }
}
