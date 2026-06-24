import 'package:flutter/foundation.dart';
import '../config/constants.dart';
import '../services/storage_service.dart';

class SettingsController with ChangeNotifier {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;

  bool get notificationsEnabled => _notificationsEnabled;
  bool get darkModeEnabled => _darkModeEnabled;

  Future<void> load() async {
    _notificationsEnabled = Storage.getBool(kNotificationsKey) ?? true;
    _darkModeEnabled = Storage.getBool(kDarkModeKey) ?? false;
    notifyListeners();
  }

  Future<void> toggleNotifications() async {
    _notificationsEnabled = !_notificationsEnabled;
    await Storage.setBool(kNotificationsKey, _notificationsEnabled);
    notifyListeners();
  }

  Future<void> toggleDarkMode() async {
    _darkModeEnabled = !_darkModeEnabled;
    await Storage.setBool(kDarkModeKey, _darkModeEnabled);
    notifyListeners();
  }
}
