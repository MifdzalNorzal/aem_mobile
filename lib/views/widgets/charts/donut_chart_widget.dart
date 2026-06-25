import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../config/color.dart';
import '../../../model/chart_donut_model.dart';

class DonutChartWidget extends StatelessWidget {
  final List<ChartDonutModel> data;

  const DonutChartWidget({super.key, required this.data});

  List<ChartDonutModel> get _effectiveData {
    if (data.isNotEmpty) return data;
    return const [
      ChartDonutModel(label: 'Category A', value: 40),
      ChartDonutModel(label: 'Category B', value: 30),
      ChartDonutModel(label: 'Category C', value: 30),
    ];
  }

  static const _colors = [
    AppColors.chartBlue,
    AppColors.chartRed,
    AppColors.chartGreen,
    AppColors.chartOrange,
    AppColors.chartPurple,
  ];

  @override
  Widget build(BuildContext context) {
    final items = _effectiveData;
    return Row(
      children: [
        Expanded(
          flex: 70,
          child: PieChart(
            PieChartData(
              sections: List.generate(items.length, (i) {
                final color = _colors[i % _colors.length];
                return PieChartSectionData(
                  value: items[i].value,
                  color: color,
                  radius: 65,
                  showTitle: false,
                );
              }),
              centerSpaceRadius: 48,
              sectionsSpace: 2,
              startDegreeOffset: -90,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 25,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(items.length, (i) {
              final color = _colors[i % _colors.length];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        items[i].label ?? 'Item ${i + 1}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
