import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../../data/models/daily_score_model.dart';
import '../cubit/home_cubit.dart';

class WeeklyOverviewPage extends StatelessWidget {
  const WeeklyOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final scores = state is HomeLoaded
            ? state.weeklyScores
            : <WeeklyScore>[];
        final avgScore = scores.isNotEmpty
            ? (scores.map((s) => s.score).reduce((a, b) => a + b) /
                      scores.length)
                  .round()
            : 0;
        final maxScore = scores.isNotEmpty
            ? scores.map((s) => s.score).reduce((a, b) => a > b ? a : b)
            : 0;

        return RizenScaffold(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
          body: ListView(
            children: [
              Text(
                'Weekly Overview',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Macro performance across your discipline metrics.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 28),
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Daily Scores',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 180,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: List.generate(scores.length, (index) {
                          final score = scores[index];
                          final heightFactor = maxScore > 0
                              ? score.score / maxScore
                              : 0.0;
                          final dayOfWeek = score.date.weekday;
                          final isToday = dayOfWeek == DateTime.now().weekday;

                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '${score.score}',
                                    style:
                                        Theme.of(
                                          context,
                                        ).textTheme.labelSmall?.copyWith(
                                          color: isToday
                                              ? AppColors.accent
                                              : AppColors.textMuted,
                                        ) ??
                                        TextStyle(
                                          color: isToday
                                              ? AppColors.accent
                                              : AppColors.textMuted,
                                          fontSize: 12,
                                        ),
                                  ),
                                  const SizedBox(height: 6),
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 400),
                                    height: 120 * heightFactor,
                                    decoration: BoxDecoration(
                                      color: isToday
                                          ? AppColors.accent
                                          : AppColors.accent.withValues(
                                              alpha: 0.45,
                                            ),
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(8),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    _dayLabel(dayOfWeek),
                                    style:
                                        Theme.of(
                                          context,
                                        ).textTheme.labelSmall?.copyWith(
                                          color: isToday
                                              ? AppColors.textPrimary
                                              : AppColors.textMuted,
                                          fontWeight: isToday
                                              ? FontWeight.w700
                                              : FontWeight.w500,
                                        ) ??
                                        TextStyle(
                                          color: isToday
                                              ? AppColors.textPrimary
                                              : AppColors.textMuted,
                                          fontWeight: isToday
                                              ? FontWeight.w700
                                              : FontWeight.w500,
                                          fontSize: 12,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      icon: PhosphorIconsFill.chartLineUp,
                      label: 'Weekly Avg',
                      value: '$avgScore',
                      color: AppColors.success,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      icon: PhosphorIconsFill.fire,
                      label: 'Best Streak',
                      value: state is HomeLoaded
                          ? '${state.dailyScore.streak}d'
                          : '0d',
                      color: AppColors.warning,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      icon: PhosphorIconsFill.barbell,
                      label: 'Active Domains',
                      value: scores.isNotEmpty
                          ? '${scores.where((s) => s.domainActivities > 0).length}'
                          : '0',
                      color: const Color(0xFF60A5FA),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      icon: PhosphorIconsFill.skull,
                      label: 'Shadow Trend',
                      value: scores.length >= 2
                          ? '${((scores.last.score - scores.first.score) / scores.first.score * 100).toStringAsFixed(0)}%'
                          : '0%',
                      color: AppColors.shadow,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(PhosphorIconsFill.robot, color: AppColors.accent),
                        const SizedBox(width: 10),
                        Text(
                          'AI Weekly Insight',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _buildWeeklyInsight(scores),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _dayLabel(int weekday) {
    switch (weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  String _buildWeeklyInsight(List<WeeklyScore> scores) {
    if (scores.isEmpty) {
      return 'Keep logging your activities to unlock AI insights.';
    }
    final bestDayIndex = scores.indexWhere(
      (s) =>
          s.score == scores.map((x) => x.score).reduce((a, b) => a > b ? a : b),
    );
    final worstDayIndex = scores.indexWhere(
      (s) =>
          s.score == scores.map((x) => x.score).reduce((a, b) => a < b ? a : b),
    );
    final bestDay = bestDayIndex >= 0 ? scores[bestDayIndex] : null;
    final worstDay = worstDayIndex >= 0 ? scores[worstDayIndex] : null;
    if (bestDay != null && worstDay != null) {
      return 'Peak performance on ${_dayLabel(bestDay.date.weekday)}. ${_dayLabel(worstDay.date.weekday)} shows room for growth — maintain consistency to sustain gains.';
    }
    return 'Consistent effort this week. Keep tracking daily for personalized insights.';
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: AppTheme.cardRadius,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 14),
          Text(value, style: Theme.of(context).textTheme.headlineSmall),
          Text(label, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
