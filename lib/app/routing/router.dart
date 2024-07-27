import 'package:go_router/go_router.dart';

import '../../features/catalog/screens/catalog_screen.dart';
import '../../features/scanner/screens/scanner_screen.dart';
import '../../features/settings/screens/settings_screen.dart';
import '../screens/root_screen.dart';

final router = GoRouter(initialLocation: '/catalog', routes: [
  StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => RootScreen(navigationShell),
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/catalog',
            builder: (context, state) => const CatalogScreen(),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/scanner',
            builder: (context, state) => const ScannerScreen(),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/settings',
            builder: (context, state) => const SettingsScreen(),
          ),
        ])
      ])
]);
