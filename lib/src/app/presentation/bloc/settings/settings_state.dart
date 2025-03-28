part of 'settings_bloc.dart';

@immutable
class SettingsState extends Equatable {
  final ThemeMode themeMode;
  final double fontSize;
  final String language;
  final bool notificationsEnabled;
  final bool isLoading;

  const SettingsState({
    required this.themeMode,
    required this.fontSize,
    required this.language,
    required this.notificationsEnabled,
    required this.isLoading,
  });

  factory SettingsState.initial() {
    return const SettingsState(
      themeMode: ThemeMode.system,
      fontSize: 1.0,
      language: 'uz',
      notificationsEnabled: true,
      isLoading: true,
    );
  }

  SettingsState copyWith({
    ThemeMode? themeMode,
    double? fontSize,
    String? language,
    bool? notificationsEnabled,
    bool? isLoading,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      fontSize: fontSize ?? this.fontSize,
      language: language ?? this.language,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [
    themeMode,
    fontSize,
    language,
    notificationsEnabled,
    isLoading,
  ];
}