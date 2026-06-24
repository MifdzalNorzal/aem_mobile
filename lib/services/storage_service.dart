import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool? getBool(String key) => _prefs.getBool(key);

  static Future<void> setBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }
}

class SecureStorage {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static Future<String?> getString(String key) => _storage.read(key: key);

  static Future<void> setString(String key, String value) =>
      _storage.write(key: key, value: value);

  static Future<void> remove(String key) => _storage.delete(key: key);
}
