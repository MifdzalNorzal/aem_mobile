import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../../core/network/api_service.dart';
import '../../../core/storage/storage_service.dart';

class AuthState {
  final String? token;
  final bool isLoading;
  final String? error;

  const AuthState({this.token, this.isLoading = false, this.error});

  AuthState copyWith({String? token, bool? isLoading, String? error}) {
    return AuthState(
      token: token ?? this.token,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState());

  Future<void> loadStoredToken() async {
    final token = await StorageService.getToken();
    state = AuthState(token: token);
  }

  Future<bool> login(String username, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ApiService.dio.post(
        '/account/login',
        data: {'username': username, 'password': password},
      );

      final token = _extractToken(response.data);
      if (token != null && token.isNotEmpty) {
        await StorageService.saveToken(token);
        state = AuthState(token: token);
        return true;
      }

      state = const AuthState(error: 'Invalid response from server.');
      return false;
    } on DioException catch (e) {
      final message = _extractErrorMessage(e);
      state = AuthState(error: message);
      return false;
    } catch (_) {
      state = const AuthState(error: 'An unexpected error occurred.');
      return false;
    }
  }

  Future<void> logout() async {
    await StorageService.deleteToken();
    state = const AuthState();
  }

  String? _extractToken(dynamic data) {
    debugPrint('[Auth] Raw response: $data');
    if (data is String && data.isNotEmpty) return data;
    if (data is Map) {
      for (final key in ['token', 'accessToken', 'access_token', 'bearerToken', 'jwt', 'result', 'value']) {
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

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
