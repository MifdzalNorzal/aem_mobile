import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import '../config/constants.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';

class AuthController with ChangeNotifier {
  String? _token;
  bool _isLoading = false;
  String? _error;

  String? get token => _token;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _token != null && _token!.isNotEmpty;

  Future<void> loadStoredToken() async {
    _token = await SecureStorage.getString(kTokenKey);
    notifyListeners();
  }

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await ApiService.request(
        method: Method.post,
        url: '/account/login',
        data: {'username': username, 'password': password},
      );

      final token = _extractToken(response.data);
      if (token != null && token.isNotEmpty) {
        await SecureStorage.setString(kTokenKey, token);
        _token = token;
        _isLoading = false;
        notifyListeners();
        return true;
      }

      _error = 'Invalid response from server.';
    } on DioException catch (e) {
      _error = _extractErrorMessage(e);
    } catch (_) {
      _error = 'An unexpected error occurred.';
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<void> logout() async {
    await SecureStorage.remove(kTokenKey);
    _token = null;
    notifyListeners();
  }

  String? _extractToken(dynamic data) {
    debugPrint('[Auth] Raw response: $data');
    if (data is String && data.isNotEmpty) return data;
    if (data is Map) {
      for (final key in [
        'token',
        'accessToken',
        'access_token',
        'bearerToken',
        'jwt',
        'result',
        'value',
      ]) {
        if (data[key] is String && (data[key] as String).isNotEmpty) {
          return data[key] as String;
        }
      }
      final nested = data['data'];
      if (nested != null) {
        final t = _extractToken(nested);
        if (t != null) return t;
      }
      for (final v in data.values) {
        if (v is String && v.length > 20) return v;
      }
      debugPrint('[Auth] Token extraction failed. Keys: ${data.keys.toList()}');
    }
    return null;
  }

  String _extractErrorMessage(DioException e) {
    final data = e.response?.data;
    if (data is Map) {
      return data['message']?.toString() ??
          data['error']?.toString() ??
          'Login failed. Please try again.';
    }
    if (data is String && data.isNotEmpty) return data;
    return 'Login failed. Please try again.';
  }
}
