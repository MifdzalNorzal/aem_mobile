import 'chart_bar_model.dart';
import 'chart_donut_model.dart';
import 'table_user_model.dart';

class DashboardResponse {
  final List<ChartBarModel> chartBar;
  final List<ChartDonutModel> chartDonut;
  final List<TableUserModel> tableUsers;

  const DashboardResponse({
    required this.chartBar,
    required this.chartDonut,
    required this.tableUsers,
  });

  factory DashboardResponse.fromJson(Map<String, dynamic> json) {
    List<T> parseList<T>(String key, T Function(Map<String, dynamic>) fromJson) {
      final raw = json[key];
      if (raw == null || raw is! List) return [];
      return raw.whereType<Map<String, dynamic>>().map(fromJson).toList();
    }

    return DashboardResponse(
      chartBar: parseList('chartbar', ChartBarModel.fromJson),
      chartDonut: parseList('chartDonut', ChartDonutModel.fromJson),
      tableUsers: parseList('tableUsers', TableUserModel.fromJson),
    );
  }
}
