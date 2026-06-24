import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../config/color.dart';
import '../../../model/chart_bar_model.dart';

class BarChartWidget extends StatelessWidget {
  final List<ChartBarModel> data;

  const BarChartWidget({super.key, required this.data});

  List<ChartBarModel> get _effectiveData {
    if (data.isNotEmpty) return data;
    return const [
      ChartBarModel(label: 'Mon', value: 5, value2: 3, value3: 7),
      ChartBarModel(label: 'Tue', value: 8, value2: 6, value3: 4),
      ChartBarModel(label: 'Wed', value: 4, value2: 9, value3: 6),
      ChartBarModel(label: 'Thu', value: 7, value2: 5, value3: 8),
      ChartBarModel(label: 'Fri', value: 6, value2: 7, value3: 5),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final items = _effectiveData;
    final hasMulti = items.any((e) => e.value2 != null);
    final maxY = items.fold<double>(0, (max, e) {
      final vals = [e.value, e.value2 ?? 0, e.value3 ?? 0];
      final localMax = vals.reduce((a, b) => a > b ? a : b);
      return localMax > max ? localMax : max;
    });

    return BarChart(
      BarChartData(
        maxY: maxY * 1.25,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (_) => FlLine(
            color: Colors.grey.withAlpha(40),
            strokeWidth: 1,
          ),
        ),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final idx = value.toInt();
                if (idx < 0 || idx >= items.length) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    items[idx].label ?? '${idx + 1}',
                    style: const TextStyle(fontSize: 11, color: AppColors.textGrey),
                  ),
                );
              },
            ),
          ),
        ),
        barGroups: List.generate(items.length, (i) {
          final item = items[i];
          return BarChartGroupData(
            x: i,
            barRods: hasMulti
                ? [
                    _rod(item.value, AppColors.chartBlue),
                    _rod(item.value2 ?? 0, AppColors.chartRed),
                    _rod(item.value3 ?? 0, AppColors.chartGreen),
                  ]
                : [_rod(item.value, AppColors.chartBlue)],
            barsSpace: 3,
          );
        }),
        barTouchData: BarTouchData(enabled: true),
      ),
    );
  }

  BarChartRodData _rod(double value, Color color) {
    return BarChartRodData(
      toY: value,
      color: color,
      width: 8,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
    );
  }
}
