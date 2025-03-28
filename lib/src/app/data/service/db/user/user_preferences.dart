import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const String _keyUserId = "user_uid";

  static Future<void> saveUserId(String uid) async {
    final prefs = await SharedPreferences.getInstance();

    // Eski UID bo‘lsa, o‘chirib tashlaymiz
    await prefs.remove(_keyUserId);

    // Yangi UID ni saqlaymiz
    await prefs.setString(_keyUserId, uid);

    print("✅ [SHARED PREFERENCES] User ID yangilandi: $uid");
  }

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserId);
  }

  static Future<void> clearUserId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUserId);
    print("❌ [SHARED PREFERENCES] User ID o‘chirildi!");
  }
}
