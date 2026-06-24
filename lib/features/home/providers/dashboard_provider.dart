import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/api_service.dart';
import '../../../model/dashboard_response.dart';

final dashboardProvider = FutureProvider<DashboardResponse>((ref) async {
  final response = await ApiService.request(
    method: Method.get,
    url: '/dashboard',
  );
  return DashboardResponse.fromJson(response.data as Map<String, dynamic>);
});
