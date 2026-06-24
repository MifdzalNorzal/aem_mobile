import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../model/dashboard_response.dart';
import '../services/api_service.dart';

class DashboardController with ChangeNotifier {
  DashboardResponse? _data;
  bool _isLoading = false;
  String? _error;

  DashboardResponse? get data => _data;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadDashboard() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await ApiService.request(
        method: Method.get,
        url: '/dashboard',
      );
      debugPrint('[Dashboard] Status: ${response.statusCode}');
      debugPrint('[Dashboard] Data: ${response.data}');

      final raw = response.data;
      if (raw is! Map<String, dynamic>) {
        _error = 'Unexpected response type: ${raw.runtimeType}';
        debugPrint('[Dashboard] $_error');
      } else {
        _data = DashboardResponse.fromJson(raw);
      }
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      final body = e.response?.data?.toString() ?? e.message;
      _error = 'API error $status: $body';
      debugPrint('[Dashboard] DioException — status: $status, body: $body');
    } catch (e) {
      _error = 'Unexpected error: $e';
      debugPrint('[Dashboard] Unexpected error: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
