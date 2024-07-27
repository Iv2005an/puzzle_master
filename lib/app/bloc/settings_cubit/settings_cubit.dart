import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:puzzle_master/repositories/settings/settings_repository.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._settingsRepository)
      : super(
          SettingsState(
            _settingsRepository.themeMode,
            _settingsRepository.isSystemAccentColor,
            _settingsRepository.accentColor ?? Colors.transparent,
          ),
        );

  final SettingsRepository _settingsRepository;

  Future<void> setThemeMode(ThemeMode themeMode) async {
    await _settingsRepository.setThemeMode(themeMode);
    emit(SettingsState(
      themeMode,
      _settingsRepository.isSystemAccentColor,
      _settingsRepository.accentColor ?? Colors.transparent,
    ));
  }

  Future<void> setIsSystemAccentColor(bool isSystemAccentColor) async {
    await _settingsRepository.setIsSystemAccentColor(isSystemAccentColor);
    emit(SettingsState(
      _settingsRepository.themeMode,
      isSystemAccentColor,
      _settingsRepository.accentColor ?? Colors.transparent,
    ));
  }

  Future<void> setAccentColor(Color accentColor) async {
    await _settingsRepository.setAccentColor(accentColor);
    emit(SettingsState(
      _settingsRepository.themeMode,
      false,
      accentColor,
    ));
  }
}
