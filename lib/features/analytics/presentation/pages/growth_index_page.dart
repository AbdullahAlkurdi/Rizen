import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/skeleton_loader.dart';
import '../../../../core/widgets/feature_scaffold.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../cubit/analytics_cubit.dart';
import '../cubit/analytics_state.dart';
import '../../data/models/growth_index.dart';
import '../../../../core/router/app_routes.dart';

class GrowthIndexPage extends StatelessWidget {
  const GrowthIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalyticsCubit, AnalyticsState>(
      builder: (context, state) {
        if (state is! AnalyticsLoaded) {
          return FeatureScaffold(
            title: 'Growth Index & Burnout Risk',
            subtitle: 'Predictive indicators showing burnout windows.',
            body: const _GrowthIndexLoading(),
          );
        }

        final growth = state.growthIndex;
        final dailyScores = _computeDailyScores(state);

        return FeatureScaffold(
          title: 'Growth Index & Burnout Risk',
          subtitle: 'Predictive indicators showing burnout windows.',
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              const SizedBox(height: 20),
              _CircularGauge(score: growth.overallScore),
              const SizedBox(height: 20),
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Score Breakdown',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 16),
                    _ScoreRow(label: 'Habit Score', value: growth.habitScore, color: AppColors.success),
                    const SizedBox(height: 12),
                    _ScoreRow(label: 'Domain Score', value: growth.domainScore, color: AppColors.cardBackground),
                    const SizedBox(height: 12),
                    _ScoreRow(label: 'Todo Score', value: growth.todoScore, color: AppColors.warning),
                    const SizedBox(height: 12),
                    _ScoreRow(label: 'Shadow Penalty', value: growth.shadowPenalty, color: AppColors.accent, isPenalty: true),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          growth.burnoutRisk == BurnoutRisk.low
                              ? PhosphorIconsBold.checkCircle
                              : PhosphorIconsBold.warning,
                          color: _burnoutColor(growth.burnoutRisk),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Burnout Risk',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _BurnoutBadge(risk: growth.burnoutRisk),
                    const SizedBox(height: 12),
                    Text(
                      growth.burnoutReason,
                      style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                    ),
                    if (growth.burnoutRisk == BurnoutRisk.high || growth.burnoutRisk == BurnoutRisk.critical) ...[
                      const SizedBox(height: 16),
                      RizenButton(
                        label: 'Activate Recovery Mode',
                        variant: RizenButtonVariant.primary,
                        onPressed: () => context.push(AppRoutes.emergencyRecovery),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                '7-Day Trend',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              GlassCard(
                child: SizedBox(
                  height: 180,
                  child: LineChart(
                    LineChartData(
                      minY: 0,
                      maxY: 100,
                      lineBarsData: [
                        LineChartBarData(
                          spots: dailyScores
                              .asMap()
                              .entries
                              .map((e) => FlSpot(e.key.toDouble(), e.value))
                              .toList(),
                          isCurved: true,
                          color: AppColors.accent,
                          barWidth: 3,
                          dotData: const FlDotData(show: false),
                        ),
                      ],
                      gridData: FlGridData(
                        show: true,
                        getDrawingHorizontalLine: (value) =>
                            FlLine(color: AppColors.cardBackground.withValues(alpha: 0.3), strokeWidth: 1),
                      ),
                      titlesData: const FlTitlesData(show: false),
                      borderData: FlBorderData(show: false),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        );
      },
    );
  }

  Color _burnoutColor(BurnoutRisk risk) {
    switch (risk) {
      case BurnoutRisk.low:
        return AppColors.success;
      case BurnoutRisk.moderate:
        return AppColors.warning;
      case BurnoutRisk.high:
      case BurnoutRisk.critical:
        return AppColors.accent;
    }
  }
}

class _CircularGauge extends StatelessWidget {
  const _CircularGauge({required this.score});

  final double score;

  @override
  Widget build(BuildContext context) {
    final color = score >= 70
        ? AppColors.success
        : score >= 40
            ? AppColors.warning
            : AppColors.accent;

    return Center(
      child: SizedBox(
        width: 200,
        height: 200,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: CircularProgressIndicator(
                value: score / 100,
                strokeWidth: 14,
                backgroundColor: AppColors.cardBackground,
                valueColor: AlwaysStoppedAnimation(color),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  score.toStringAsFixed(0),
                  style: const TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Growth Index',
                  style: TextStyle(fontSize: 14, color: AppColors.textMuted),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ScoreRow extends StatelessWidget {
  const _ScoreRow({
    required this.label,
    required this.value,
    required this.color,
    this.isPenalty = false,
  });

  final String label;
  final double value;
  final Color color;
  final bool isPenalty;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontSize: 14)),
            Text(
              isPenalty ? '-${value.toStringAsFixed(1)}' : '${value.toStringAsFixed(1)}%',
              style: TextStyle(fontSize: 14, color: isPenalty ? AppColors.accent : null),
            ),
          ],
        ),
        const SizedBox(height: 6),
        AnimatedFractionallySizedBox(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
          widthFactor: (value / 100).clamp(0.0, 1.0),
          child: Container(
            height: 8,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ],
    );
  }
}

class _BurnoutBadge extends StatelessWidget {
  const _BurnoutBadge({required this.risk});

  final BurnoutRisk risk;

  @override
  Widget build(BuildContext context) {
    String label;
    Color color;
    bool pulse = false;
    switch (risk) {
      case BurnoutRisk.low:
        label = 'Low Risk';
        color = AppColors.success;
        break;
      case BurnoutRisk.moderate:
        label = 'Monitor';
        color = AppColors.warning;
        break;
      case BurnoutRisk.high:
        label = 'High Risk';
        color = AppColors.accent;
        break;
      case BurnoutRisk.critical:
        label = 'Critical';
        color = AppColors.accent;
        pulse = true;
        break;
    }

    Widget badge = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontWeight: FontWeight.w600),
      ),
    );

    if (pulse) {
      return TweenAnimationBuilder<double>(
        tween: Tween(begin: 1.0, end: 1.3),
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
        builder: (context, scale, child) {
          return Transform.scale(scale: scale, child: badge);
        },
        onEnd: () {},
      );
    }

    return badge;
  }
}

List<double> _computeDailyScores(AnalyticsLoaded state) {
  final now = DateTime.now();
  final scores = <double>[];
  for (int i = 6; i >= 0; i--) {
    final day = DateTime(now.year, now.month, now.day - i);
    final dayStart = DateTime(day.year, day.month, day.day);

    final dayHabits = state.habitTrends.where((t) {
      final d = DateTime(t.date.year, t.date.month, t.date.day);
      return d == dayStart;
    }).toList();

    final dayDomains = state.domainScores.where((t) {
      final d = DateTime(t.date.year, t.date.month, t.date.day);
      return d == dayStart;
    }).toList();

    final hScore = dayHabits.isNotEmpty
        ? dayHabits.map((t) => t.completionPct).reduce((a, b) => a + b) / dayHabits.length
        : 0.0;
    final dScore = dayDomains.isNotEmpty ? 100.0 : 0.0;

    scores.add(((hScore * 0.5) + (dScore * 0.5)).clamp(0.0, 100.0));
  }
  return scores;
}

class _GrowthIndexLoading extends StatelessWidget {
  const _GrowthIndexLoading();

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          SkeletonCard(height: 240),
          SizedBox(height: 20),
          SkeletonLine(width: double.infinity, height: 60),
          SizedBox(height: 12),
          SkeletonLine(width: double.infinity, height: 60),
          SizedBox(height: 12),
          SkeletonLine(width: double.infinity, height: 60),
          SizedBox(height: 12),
          SkeletonLine(width: double.infinity, height: 60),
        ],
      ),
    );
  }
}
