import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/color.dart';
import '../../config/extensions/build_context_ext.dart';
import '../../controllers/dashboard_controller.dart';
import '../../model/dashboard_response.dart';
import '../widgets/chart_card.dart';
import '../widgets/screen_headers.dart';
import '../widgets/charts/bar_chart_widget.dart';
import '../widgets/charts/donut_chart_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late final AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardController>().loadDashboard();
    });
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
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

          return Stack(
            children: [
              header,
              RefreshIndicator(
                color: Colors.white,
                backgroundColor: AppColors.primary,
                displacement: contentTopOffset - 20,
                onRefresh: () => context.read<DashboardController>().loadDashboard(),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: contentTopOffset),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 350),
                          switchInCurve: Curves.easeOut,
                          switchOutCurve: Curves.easeIn,
                          transitionBuilder: (child, animation) => FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                          child: dashboard.isLoading
                              ? _SkeletonCards(
                                  key: const ValueKey('skeleton'),
                                  shimmer: _shimmerController,
                                )
                              : _ChartCards(
                                  key: const ValueKey('charts'),
                                  data: dashboard.data,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ChartCards extends StatelessWidget {
  final DashboardResponse? data;

  const _ChartCards({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
          builder: (_, v, child) => Opacity(
            opacity: v,
            child: Transform.translate(offset: Offset(0, 24 * (1 - v)), child: child),
          ),
          child: ChartCard(
            title: l10n.statistics,
            child: SizedBox(height: 200, child: BarChartWidget(data: data?.chartBar ?? [])),
          ),
        ),
        const SizedBox(height: 16),
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 600),
          curve: const Interval(0.25, 1.0, curve: Curves.easeOut),
          builder: (_, v, child) => Opacity(
            opacity: v,
            child: Transform.translate(offset: Offset(0, 24 * (1 - v)), child: child),
          ),
          child: ChartCard(
            title: l10n.distribution,
            child: SizedBox(height: 220, child: DonutChartWidget(data: data?.chartDonut ?? [])),
          ),
        ),
      ],
    );
  }
}

class _SkeletonCards extends StatelessWidget {
  final AnimationController shimmer;

  const _SkeletonCards({super.key, required this.shimmer});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SkeletonChartCard(shimmer: shimmer, chartHeight: 200),
        const SizedBox(height: 16),
        _SkeletonChartCard(shimmer: shimmer, chartHeight: 220),
      ],
    );
  }
}

class _SkeletonChartCard extends StatelessWidget {
  final AnimationController shimmer;
  final double chartHeight;

  const _SkeletonChartCard({required this.shimmer, required this.chartHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
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
          _ShimmerBox(shimmer: shimmer, height: 18, width: 120),
          const SizedBox(height: 16),
          _ShimmerBox(shimmer: shimmer, height: chartHeight, borderRadius: 12),
        ],
      ),
    );
  }
}

class _ShimmerBox extends StatelessWidget {
  final AnimationController shimmer;
  final double height;
  final double borderRadius;
  final double? width;

  const _ShimmerBox({
    required this.shimmer,
    required this.height,
    this.borderRadius = 8,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final base = isDark ? const Color(0xFF2A2A2A) : const Color(0xFFE0E0E0);
    final highlight = isDark ? const Color(0xFF3D3D3D) : const Color(0xFFF5F5F5);

    return AnimatedBuilder(
      animation: shimmer,
      builder: (_, __) {
        final t = shimmer.value;
        return Container(
          width: width ?? double.infinity,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            gradient: LinearGradient(
              colors: [base, highlight, base],
              stops: [
                (t - 0.3).clamp(0.0, 1.0),
                t.clamp(0.0, 1.0),
                (t + 0.3).clamp(0.0, 1.0),
              ],
            ),
          ),
        );
      },
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
