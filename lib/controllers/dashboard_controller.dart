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
      _data = DashboardResponse.fromJson(response.data as Map<String, dynamic>);
    } catch (_) {
      _error = 'Failed to load dashboard.';
    }

    _isLoading = false;
    notifyListeners();
  }
}
