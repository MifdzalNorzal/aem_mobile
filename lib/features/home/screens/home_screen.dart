import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../providers/dashboard_provider.dart';
import '../../../models/chart_bar_model.dart';
import '../../../models/chart_donut_model.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardAsync = ref.watch(dashboardProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: dashboardAsync.when(
              loading: () => const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
              error: (error, _) => _ErrorView(onRetry: () => ref.refresh(dashboardProvider)),
              data: (dashboard) => SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                child: Column(
                  children: [
                    _ChartCard(
                      title: AppStrings.statistics,
                      child: SizedBox(
                        height: 200,
                        child: _BarChartWidget(data: dashboard.chartBar),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _ChartCard(
                      title: AppStrings.distribution,
                      child: SizedBox(
                        height: 220,
                        child: _DonutChartWidget(data: dashboard.chartDonut),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: AppColors.primary,
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 20,
        bottom: 28,
        left: 24,
        right: 24,
      ),
      child: const Text(
        AppStrings.helloAlex,
        style: TextStyle(
          color: Colors.white,
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _ChartCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _ChartCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _BarChartWidget extends StatelessWidget {
  final List<ChartBarModel> data;

  const _BarChartWidget({required this.data});

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

class _DonutChartWidget extends StatelessWidget {
  final List<ChartDonutModel> data;

  const _DonutChartWidget({required this.data});

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
          flex: 3,
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
          flex: 2,
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
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textDark,
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

class _ErrorView extends StatelessWidget {
  final VoidCallback onRetry;

  const _ErrorView({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 52, color: Colors.grey),
          const SizedBox(height: 12),
          const Text(
            AppStrings.failedLoadDashboard,
            style: TextStyle(color: AppColors.textGrey, fontSize: 15),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text(AppStrings.retry, style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
