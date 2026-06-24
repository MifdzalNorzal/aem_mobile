import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_service.dart';
import '../../../models/dashboard_response.dart';

final dashboardProvider = FutureProvider<DashboardResponse>((ref) async {
  final response = await ApiService.dio.get('/dashboard');
  return DashboardResponse.fromJson(response.data as Map<String, dynamic>);
});
