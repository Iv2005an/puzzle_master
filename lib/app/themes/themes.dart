import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

(ThemeData, ThemeData) getThemes(
  ColorScheme? lightDynamic,
  ColorScheme? darkDynamic,
  bool isSystemAccent,
  Color accentColor,
) {
  if (isSystemAccent && lightDynamic != null) {
    accentColor = lightDynamic.primary;
  }
  return (
    ThemeData.from(
      colorScheme: ColorScheme.fromSeed(
        seedColor: accentColor,
      ),
    ),
    ThemeData.from(
      colorScheme: ColorScheme.fromSeed(
        seedColor: accentColor,
        brightness: Brightness.dark,
      ),
    )
  );
}

SystemUiOverlayStyle getSystemUiOverlayStyle(ThemeData theme) =>
    SystemUiOverlayStyle(
      systemNavigationBarColor: theme.colorScheme.surfaceContainer,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: theme.brightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark,
    );
