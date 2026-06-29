import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/skeleton_loader.dart';
import '../cubit/analytics_cubit.dart';
import '../cubit/analytics_state.dart';
import '../../data/models/analytics_period.dart';
import '../../data/models/domain_score_point.dart';
import '../../data/models/growth_index.dart';
import '../../data/models/habit_trend_point.dart';

class AnalyticsHubPage extends StatelessWidget {
  const AnalyticsHubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AnalyticsCubit()..loadAll(AnalyticsPeriod.week),
      child: const AnalyticsHubView(),
    );
  }
}

class AnalyticsHubView extends StatelessWidget {
  const AnalyticsHubView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalyticsCubit, AnalyticsState>(
      buildWhen: (prev, curr) => prev.runtimeType != curr.runtimeType,
      builder: (context, state) {
        return Scaffold(
          extendBody: true,
          appBar: AppBar(
            title: const Text('Analytics & Growth'),
            actions: [
              _PeriodSelector(),
              IconButton(
                icon: const Icon(PhosphorIconsBold.export),
                onPressed: () => _showExportDialog(context),
              ),
            ],
          ),
          body: state is AnalyticsLoaded
              ? _AnalyticsLoadedView(state: state)
              : state is AnalyticsError
                  ? Center(child: Text('Error: ${state.message}'))
                  : const _AnalyticsLoadingView(),
        );
      },
    );
  }

  void _showExportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        title: const Text('Export Data'),
        content: const Text('Choose export format'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              context.read<AnalyticsCubit>().exportData('json');
            },
            child: const Text('JSON'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              context.read<AnalyticsCubit>().exportData('csv');
            },
            child: const Text('CSV'),
          ),
        ],
      ),
    );
  }
}

class _PeriodSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalyticsCubit, AnalyticsState>(
      builder: (context, state) {
        AnalyticsPeriod period = AnalyticsPeriod.week;
        if (state is AnalyticsLoaded) {
          period = state.selectedPeriod;
        }
        return Row(
          children: AnalyticsPeriod.values.map((p) {
            final selected = period == p;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: GestureDetector(
                onTap: () => context.read<AnalyticsCubit>().changePeriod(p),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: selected ? AppColors.accent : AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    p.name.toUpperCase(),
                    style: const TextStyle(fontSize: 12, color: Colors.white, fontFamily: 'Inter'),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _AnalyticsLoadingView extends StatelessWidget {
  const _AnalyticsLoadingView();

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkeletonCard(height: 260),
          SizedBox(height: 20),
          SkeletonBarChart(barCount: 7),
          SizedBox(height: 20),
          SkeletonLine(width: 160, height: 20),
          SizedBox(height: 12),
          SkeletonListTile(),
          SizedBox(height: 12),
          SkeletonListTile(),
          SizedBox(height: 12),
          SkeletonListTile(),
        ],
      ),
    );
  }
}

class _AnalyticsLoadedView extends StatelessWidget {
  const _AnalyticsLoadedView({required this.state});

  final AnalyticsLoaded state;

  @override
  Widget build(BuildContext context) {
    final growth = state.growthIndex;
    final domainScores = state.domainScores;
    final habitTrends = state.habitTrends;
    final correlations = state.correlations;

    final domainMap = <String, List<DomainScorePoint>>{};
    for (final point in domainScores) {
      domainMap.putIfAbsent(point.domain, () => []).add(point);
    }

    final barCount = switch (state.selectedPeriod) {
      AnalyticsPeriod.week => 7,
      AnalyticsPeriod.month => 30,
      AnalyticsPeriod.quarter => 90,
    };

    final habitGroups = <String, List<HabitTrendPoint>>{};
    for (final point in habitTrends) {
      habitGroups.putIfAbsent(point.habitId, () => []).add(point);
    }

    return ListView(
      children: [
        const SizedBox(height: 16),
        _GrowthIndexCard(growthIndex: growth),
        const SizedBox(height: 24),
        const Text(
          'Domain Activity',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 160,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: domainMap.entries.map((entry) {
              final points = entry.value;
              final totalMinutes = points.fold<int>(0, (sum, p) => sum + p.totalMinutes);
              return Container(
                width: 120,
                margin: const EdgeInsets.only(right: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.key,
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$totalMinutes min',
                      style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceBetween,
                          barGroups: List.generate(
                            min(points.length, barCount),
                            (i) {
                              final value = points[i].score;
                              return BarChartGroupData(
                                x: i,
                                barRods: [
                                  BarChartRodData(
                                    toY: value,
                                    color: AppColors.accent,
                                    width: 4,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ],
                              );
                            },
                          ),
                          titlesData: const FlTitlesData(show: false),
                          borderData: FlBorderData(show: false),
                          gridData: const FlGridData(show: false),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Habit Consistency',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...habitGroups.entries.map((entry) {
          final points = entry.value.toList()..sort((a, b) => a.date.compareTo(b.date));
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          entry.value.first.habitName,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      if (entry.value.first.streakActive)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.accent.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${entry.value.first.currentStreak}🔥',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 160,
                    child: LineChart(
                      LineChartData(
                        minY: 0,
                        maxY: 100,
                        lineBarsData: [
                          LineChartBarData(
                            spots: points
                                .asMap()
                                .entries
                                .map((e) => FlSpot(e.key.toDouble(), e.value.completionPct))
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
                ],
              ),
            ),
          );
        }),
        const SizedBox(height: 24),
        const Text(
          'What Drives Your Performance',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        if (correlations.isEmpty)
          GlassCard(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Keep logging for 7 days to unlock correlation insights.',
                  style: TextStyle(color: AppColors.textMuted),
                ),
              ),
            ),
          )
        else
          ...correlations.map((c) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GlassCard(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 4,
                        height: 40,
                        decoration: BoxDecoration(
                          color: c.isPositive ? AppColors.success : AppColors.accent,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(PhosphorIconsBold.arrowsLeftRight, size: 16),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    '${c.domainA} ↔ ${c.domainB}',
                                    style: const TextStyle(fontWeight: FontWeight.w600),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  c.correlationScore.abs() > 0.6 ? 'Strong' : 'Moderate',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              c.insight,
                              style: const TextStyle(fontSize: 14),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _GrowthIndexCard extends StatelessWidget {
  const _GrowthIndexCard({required this.growthIndex});

  final GrowthIndex growthIndex;

  @override
  Widget build(BuildContext context) {
    final score = growthIndex.overallScore;
    final color = score >= 70
        ? AppColors.success
        : score >= 40
            ? AppColors.warning
            : AppColors.accent;

    return GlassCard(
      child: Column(
        children: [
          Center(
            child: SizedBox(
              width: 160,
              height: 160,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 160,
                    height: 160,
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
                          style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
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
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _SubScoreChip(label: 'Habits', value: growthIndex.habitScore),
              const SizedBox(width: 8),
              _SubScoreChip(label: 'Domains', value: growthIndex.domainScore),
              const SizedBox(width: 8),
              _SubScoreChip(label: 'Todos', value: growthIndex.todoScore),
            ],
          ),
          const SizedBox(height: 12),
          _BurnoutBadge(risk: growthIndex.burnoutRisk),
          const SizedBox(height: 6),
          Text(
            growthIndex.burnoutReason,
            style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: AppColors.textMuted),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _SubScoreChip extends StatelessWidget {
  const _SubScoreChip({required this.label, required this.value});

  final String label;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text('$label: ${value.toStringAsFixed(0)}%', style: const TextStyle(fontSize: 12)),
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
