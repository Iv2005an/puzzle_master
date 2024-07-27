import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository {
  const SettingsRepository(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  static const _themeModeKey = 'theme_mode';
  static const _isSystemAccentColorKey = 'is_system_accent_color';
  static const _accentColorKey = 'accent_color';

  ThemeMode get themeMode {
    int themeModeIndex = _sharedPreferences.getInt(_themeModeKey) ?? 0;
    return ThemeMode.values[themeModeIndex];
  }

  Future<void> setThemeMode(ThemeMode themeMode) async =>
      await _sharedPreferences.setInt(_themeModeKey, themeMode.index);

  bool get isSystemAccentColor =>
      _sharedPreferences.getBool(_isSystemAccentColorKey) ?? false;

  Future<void> setIsSystemAccentColor(bool isSystemAccentColor) async =>
      await _sharedPreferences.setBool(
          _isSystemAccentColorKey, isSystemAccentColor);

  Color? get accentColor {
    int? accentColorValue = _sharedPreferences.getInt(_accentColorKey);
    return accentColorValue != null ? Color(accentColorValue) : null;
  }

  Future<void> setAccentColor(Color accentColor) async =>
      await _sharedPreferences.setInt(_accentColorKey, accentColor.value);
}
