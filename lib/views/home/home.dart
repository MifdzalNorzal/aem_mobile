import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/color.dart';
import '../../config/extensions/build_context_ext.dart';
import '../../controllers/dashboard_controller.dart';
import '../widgets/chart_card.dart';
import '../widgets/screen_header.dart';
import '../widgets/charts/bar_chart_widget.dart';
import '../widgets/charts/donut_chart_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardController>().loadDashboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          ScreenHeader(title: l10n.helloAlex),
          Expanded(
            child: Consumer<DashboardController>(
              builder: (context, dashboard, _) {
                if (dashboard.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  );
                }
                if (dashboard.error != null) {
                  return _ErrorView(
                    onRetry: () => context.read<DashboardController>().loadDashboard(),
                  );
                }
                final data = dashboard.data;
                return SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                  child: Column(
                    children: [
                      ChartCard(
                        title: l10n.statistics,
                        child: SizedBox(
                          height: 200,
                          child: BarChartWidget(
                            data: data?.chartBar ?? [],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ChartCard(
                        title: l10n.distribution,
                        child: SizedBox(
                          height: 220,
                          child: DonutChartWidget(
                            data: data?.chartDonut ?? [],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
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
          Text(
            context.l10n.failedLoadDashboard,
            style: const TextStyle(color: AppColors.textGrey, fontSize: 15),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(
              context.l10n.retry,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
