import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../data/service/db/local/local_storage.dart';
part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final LocalStorage _localStorage = LocalStorage();

  SettingsBloc() : super(SettingsState.initial()) {
    on<InitializeSettingsEvent>(_onInitializeSettings);
    on<ChangeThemeEvent>(_onChangeTheme);
    on<ChangeFontSizeEvent>(_onChangeFontSize);
    on<ChangeLanguageEvent>(_onChangeLanguage);
    on<ToggleNotificationsEvent>(_onToggleNotifications);
  }

  Future<void> _onInitializeSettings(
      InitializeSettingsEvent event,
      Emitter<SettingsState> emit,
      ) async {
    emit(state.copyWith(isLoading: true));

    try {
      final themeMode = await _localStorage.getThemeMode();
      final fontSize = await _localStorage.getFontSize();
      final language = await _localStorage.getLanguage();
      final notificationsEnabled = await _localStorage.getNotificationsEnabled();

      print('themeMode: $themeMode');
      print('fontSize: $fontSize');
      print('language: $language');
      print('notificationsEnabled: $notificationsEnabled');

      ThemeMode selectedThemeMode;
      switch (themeMode) {
        case 0:
          selectedThemeMode = ThemeMode.light;
          break;
        case 1:
          selectedThemeMode = ThemeMode.dark;
          break;
        case 2:
        default:
          selectedThemeMode = ThemeMode.system;
          break;
      }

      emit(state.copyWith(
        themeMode: selectedThemeMode,
        fontSize: fontSize,
        language: language,
        notificationsEnabled: notificationsEnabled,
        isLoading: false,
      ));
    } catch (e) {
      print('Xatolik: $e'); // Xatolikni terminalga chiqaramiz
      emit(state.copyWith(isLoading: false));
    }
  }


  Future<void> _onChangeTheme(
      ChangeThemeEvent event,
      Emitter<SettingsState> emit,
      ) async {
    int themeModeValue;
    switch (event.themeMode) {
      case ThemeMode.light:
        themeModeValue = 0;
        break;
      case ThemeMode.dark:
        themeModeValue = 1;
        break;
      case ThemeMode.system:
      default:
        themeModeValue = 2;
        break;
    }

    await _localStorage.setThemeMode(themeModeValue);
    emit(state.copyWith(themeMode: event.themeMode));

    // AppTheme classiga ham yangilashni aytish
    AppTheme().setTheme(event.themeMode);
  }

  Future<void> _onChangeFontSize(
      ChangeFontSizeEvent event,
      Emitter<SettingsState> emit,
      ) async {
    await _localStorage.setFontSize(event.fontSize);
    emit(state.copyWith(fontSize: event.fontSize));
  }

  Future<void> _onChangeLanguage(
      ChangeLanguageEvent event,
      Emitter<SettingsState> emit,
      ) async {
    await _localStorage.setLanguage(event.language);
    emit(state.copyWith(language: event.language));
  }

  Future<void> _onToggleNotifications(
      ToggleNotificationsEvent event,
      Emitter<SettingsState> emit,
      ) async {
    await _localStorage.setNotificationsEnabled(event.enabled);
    emit(state.copyWith(notificationsEnabled: event.enabled));
  }
}