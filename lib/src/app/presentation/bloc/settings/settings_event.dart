part of 'settings_bloc.dart';

@immutable
sealed class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class InitializeSettingsEvent extends SettingsEvent {}

class ChangeThemeEvent extends SettingsEvent {
  final ThemeMode themeMode;

  const ChangeThemeEvent(this.themeMode);

  @override
  List<Object> get props => [themeMode];
}

class ChangeFontSizeEvent extends SettingsEvent {
  final double fontSize;

  const ChangeFontSizeEvent(this.fontSize);

  @override
  List<Object> get props => [fontSize];
}

class ChangeLanguageEvent extends SettingsEvent {
  final String language;

  const ChangeLanguageEvent(this.language);

  @override
  List<Object> get props => [language];
}

class ToggleNotificationsEvent extends SettingsEvent {
  final bool enabled;

  const ToggleNotificationsEvent(this.enabled);

  @override
  List<Object> get props => [enabled];
}
