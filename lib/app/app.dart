import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/catalog/bloc/catalog_bloc/catalog_bloc.dart';
import '../repositories/settings/settings_repository.dart';

import 'bloc/bloc.dart';
import 'routing/router.dart';
import 'themes/themes.dart';

class App extends StatelessWidget {
  const App(this._sharedPreferences, {super.key});

  final SharedPreferences _sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              SettingsCubit(SettingsRepository(_sharedPreferences)),
        ),
        BlocProvider(
          create: (context) => CatalogBloc(),
        ),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return DynamicColorBuilder(builder: (lightDynamic, darkDynamic) {
            final (lightTheme, darkTheme) = getThemes(
              lightDynamic,
              darkDynamic,
              state.isSystemAccentColor,
              state.accentColor,
            );
            bool isDarkMode = state.themeMode == ThemeMode.system
                ? PlatformDispatcher.instance.platformBrightness ==
                    Brightness.dark
                : state.themeMode == ThemeMode.dark;
            SystemChrome.setSystemUIOverlayStyle(
                getSystemUiOverlayStyle(isDarkMode ? darkTheme : lightTheme));
            return MaterialApp.router(
              routerConfig: router,
              themeMode: state.themeMode,
              theme: lightTheme,
              darkTheme: darkTheme,
            );
          });
        },
      ),
    );
  }
}
