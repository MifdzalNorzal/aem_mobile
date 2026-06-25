import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/color.dart';
import '../../config/extensions/build_context_ext.dart';
import '../../controllers/dashboard_controller.dart';
import '../widgets/chart_card.dart';
import '../widgets/screen_headers.dart';
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
    final statusBarHeight = MediaQuery.of(context).padding.top;
    
    final contentTopOffset = statusBarHeight + 100.0;

    final header = ScreenHeader(
      child: Text(
        l10n.helloAlex,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Consumer<DashboardController>(
        builder: (context, dashboard, _) {
          if (dashboard.isLoading) {
            return Column(
              children: [
                header,
                const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                ),
              ],
            );
          }
          if (dashboard.error != null) {
            return Column(
              children: [
                header,
                Expanded(
                  child: _ErrorView(
                    onRetry: () => context.read<DashboardController>().loadDashboard(),
                  ),
                ),
              ],
            );
          }
          final data = dashboard.data;
          return Stack(
            children: [
              
              header,
              SingleChildScrollView(
                child: Column(
                  children: [
                   
                    SizedBox(height: contentTopOffset),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                      child: Column(
                        children: [
                          TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0.0, end: 1.0),
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeOut,
                            builder: (_, v, child) => Opacity(
                              opacity: v,
                              child: Transform.translate(
                                offset: Offset(0, 24 * (1 - v)),
                                child: child,
                              ),
                            ),
                            child: ChartCard(
                              title: l10n.statistics,
                              child: SizedBox(
                                height: 200,
                                child: BarChartWidget(data: data?.chartBar ?? []),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0.0, end: 1.0),
                            duration: const Duration(milliseconds: 600),
                            curve: const Interval(0.25, 1.0, curve: Curves.easeOut),
                            builder: (_, v, child) => Opacity(
                              opacity: v,
                              child: Transform.translate(
                                offset: Offset(0, 24 * (1 - v)),
                                child: child,
                              ),
                            ),
                            child: ChartCard(
                              title: l10n.distribution,
                              child: SizedBox(
                                height: 220,
                                child: DonutChartWidget(data: data?.chartDonut ?? []),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
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
