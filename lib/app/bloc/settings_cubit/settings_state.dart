part of 'settings_cubit.dart';

final class SettingsState extends Equatable {
  const SettingsState(
      this.themeMode, this.isSystemAccentColor, this.accentColor);

  final ThemeMode themeMode;
  final bool isSystemAccentColor;
  final Color accentColor;

  @override
  List<Object> get props => [themeMode, isSystemAccentColor, accentColor];
}
