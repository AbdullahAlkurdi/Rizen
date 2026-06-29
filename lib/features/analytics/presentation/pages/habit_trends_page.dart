import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/skeleton_loader.dart';
import '../../../../core/widgets/feature_scaffold.dart';
import '../cubit/analytics_cubit.dart';
import '../cubit/analytics_state.dart';
import '../../data/models/analytics_period.dart';
import '../../data/models/habit_trend_point.dart';

class HabitTrendsPage extends StatelessWidget {
  const HabitTrendsPage({super.key, this.habitId});

  final String? habitId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalyticsCubit, AnalyticsState>(
      builder: (context, state) {
        if (state is! AnalyticsLoaded) {
          return FeatureScaffold(
            title: 'Habit Trends',
            subtitle: 'Temporal tracking of habit velocities.',
            body: const _HabitTrendsLoading(),
          );
        }

        final allTrends = state.habitTrends;
        final filteredTrends = habitId != null
            ? allTrends.where((t) => t.habitId == habitId).toList()
            : allTrends;

        if (filteredTrends.isEmpty) {
          return FeatureScaffold(
            title: 'Habit Trends',
            subtitle: 'Temporal tracking of habit velocities.',
            body: const Center(child: Text('No trend data available.')),
          );
        }

        final habitName = filteredTrends.first.habitName;
        final points = filteredTrends.toList()..sort((a, b) => a.date.compareTo(b.date));

        final bestStreak = _calculateBestStreak(points);
        final currentStreak = points.first.currentStreak;
        final avgCompletion = points.isNotEmpty
            ? points.map((p) => p.completionPct).reduce((a, b) => a + b) / points.length
            : 0.0;
        final totalCompletions = points.where((p) => p.completionPct >= 100).length;

        return FeatureScaffold(
          title: habitName,
          subtitle: 'Completion trend and consistency history.',
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              const SizedBox(height: 12),
              _PeriodSelector(),
              const SizedBox(height: 20),
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Completion Trend',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 200,
                      child: LineChart(
                        LineChartData(
                          minY: 0,
                          maxY: 100,
                          lineTouchData: LineTouchData(
                            touchTooltipData: LineTouchTooltipData(
                              getTooltipItems: (touchedSpots) {
                                return touchedSpots.map((spot) {
                                  final idx = spot.x.toInt();
                                  final point = idx < points.length ? points[idx] : null;
                                  return LineTooltipItem(
                                    point != null ? '${point.completionPct.toStringAsFixed(0)}%' : '',
                                    const TextStyle(fontSize: 12),
                                    children: point != null
                                        ? [TextSpan(text: '\n${_formatDate(point.date)}', style: const TextStyle(fontSize: 10, color: AppColors.textMuted))]
                                        : [],
                                  );
                                }).toList();
                              },
                            ),
                          ),
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
                            LineChartBarData(
                              spots: points
                                  .asMap()
                                  .entries
                                  .map((e) => FlSpot(e.key.toDouble(), 70))
                                  .toList(),
                              isCurved: false,
                              color: AppColors.cardBackground,
                              barWidth: 2,
                              dashArray: [4, 4],
                              dotData: const FlDotData(show: false),
                            ),
                          ],
                          gridData: FlGridData(
                            show: true,
                            getDrawingHorizontalLine: (value) =>
                                FlLine(color: AppColors.cardBackground.withValues(alpha: 0.3), strokeWidth: 1),
                          ),
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 30,
                                interval: (points.length / 6).ceilToDouble(),
                                getTitlesWidget: (value, meta) {
                                  final idx = value.toInt();
                                  if (idx < 0 || idx >= points.length) return const SizedBox();
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text(_formatDate(points[idx].date), style: const TextStyle(fontSize: 10)),
                                  );
                                },
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 40,
                                getTitlesWidget: (value, meta) {
                                  return Text('${value.toInt()}%', style: const TextStyle(fontSize: 10));
                                },
                              ),
                            ),
                            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          ),
                          borderData: FlBorderData(show: false),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Streak History',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: points.map((p) {
                    final day = DateTime(p.date.year, p.date.month, p.date.day);
                    final today = DateTime.now();
                    final isToday = day.year == today.year && day.month == today.month && day.day == today.day;
                    Color dotColor;
                    if (p.completionPct >= 100) {
                      dotColor = AppColors.success;
                    } else if (p.completionPct >= 70) {
                      dotColor = AppColors.warning;
                    } else if (p.completionPct > 0) {
                      dotColor = AppColors.accent;
                    } else {
                      dotColor = AppColors.textMuted;
                    }
                    return Container(
                      margin: EdgeInsets.only(right: isToday ? 0 : 6),
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isToday ? dotColor : dotColor.withValues(alpha: 0.3),
                        border: isToday ? Border.all(color: dotColor, width: 2) : null,
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Statistics',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _StatChip(label: 'Best streak', value: '$bestStreak days'),
                  const SizedBox(width: 10),
                  _StatChip(label: 'Current streak', value: '$currentStreak days'),
                  const SizedBox(width: 10),
                  _StatChip(label: 'Avg completion', value: '${avgCompletion.toStringAsFixed(0)}%'),
                  const SizedBox(width: 10),
                  _StatChip(label: 'Total completions', value: '$totalCompletions'),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        );
      },
    );
  }

  int _calculateBestStreak(List<HabitTrendPoint> points) {
    int best = 0;
    int current = 0;
    for (final p in points) {
      if (p.completionPct >= 70) {
        current++;
        best = max(best, current);
      } else {
        current = 0;
      }
    }
    return best;
  }

  String _formatDate(DateTime date) => '${date.month}/${date.day}';
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

class _StatChip extends StatelessWidget {
  const _StatChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textMuted), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _HabitTrendsLoading extends StatelessWidget {
  const _HabitTrendsLoading();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: const Column(
        children: [
          SkeletonBarChart(barCount: 30),
          SizedBox(height: 20),
          _SkeletonList(),
        ],
      ),
    );
  }
}

class _SkeletonList extends StatelessWidget {
  const _SkeletonList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(7, (_) => const Padding(
        padding: EdgeInsets.only(bottom: 8),
        child: SkeletonChip(width: 28),
      )),
    );
  }
}
