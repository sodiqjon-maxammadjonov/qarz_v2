import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static final LocalStorage _instance = LocalStorage._internal();
  factory LocalStorage() => _instance;
  LocalStorage._internal();

  static const String _themeKey = 'app_theme';
  static const String _fontSizeKey = 'font_size';
  static const String _langKey = 'app_language';
  static const String _notificationKey = 'notifications_enabled';

  // Theme settings
  Future<int> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    // Default: 0 = light, 1 = dark, 2 = system
    return prefs.getInt(_themeKey) ?? 2;
  }

  Future<bool> setThemeMode(int themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setInt(_themeKey, themeMode);
  }

  // Font size settings
  Future<double> getFontSize() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_fontSizeKey) ?? 14.0; // Default normal size
  }

  Future<bool> setFontSize(double fontSize) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setDouble(_fontSizeKey, fontSize);
  }

  // Language settings
  Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_langKey) ?? 'uz'; // Default uzbek
  }

  Future<bool> setLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(_langKey, language);
  }

  // Notifications settings
  Future<bool> getNotificationsEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_notificationKey) ?? true; // Default enabled
  }

  Future<bool> setNotificationsEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_notificationKey, enabled);
  }
}