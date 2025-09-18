
import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static const _accessKey = 'ACCESS_TOKEN';

  Future<void> saveToken(String access) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessKey, access);
  }

  Future<String?> readToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessKey);
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessKey);
  }
}
