import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/rizen_scaffold.dart';

class WeeklyOverviewPage extends StatelessWidget {
  const WeeklyOverviewPage({super.key});

  static const _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  static const _scores = [72, 85, 68, 91, 78, 55, 82];

  @override
  Widget build(BuildContext context) {
    final maxScore = _scores.reduce((a, b) => a > b ? a : b).toDouble();

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
                    children: List.generate(_days.length, (index) {
                      final score = _scores[index];
                      final heightFactor = score / maxScore;
                      final isToday = index == DateTime.now().weekday - 1;

                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '$score',
                                style: Theme.of(context).textTheme.labelSmall
                                    ?.copyWith(
                                      color: isToday
                                          ? AppColors.accent
                                          : AppColors.textMuted,
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
                                _days[index],
                                style: Theme.of(context).textTheme.labelSmall
                                    ?.copyWith(
                                      color: isToday
                                          ? AppColors.textPrimary
                                          : AppColors.textMuted,
                                      fontWeight: isToday
                                          ? FontWeight.w700
                                          : FontWeight.w500,
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
                  value: '76',
                  color: AppColors.success,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  icon: PhosphorIconsFill.fire,
                  label: 'Best Streak',
                  value: '12d',
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
                  label: 'Top Domain',
                  value: 'Coding',
                  color: Color(0xFF60A5FA),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  icon: PhosphorIconsFill.skull,
                  label: 'Shadow Trend',
                  value: '-8%',
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
                  'Your coding consistency peaked mid-week. Saturday dip suggests burnout risk — consider activating Recovery Mode proactively.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
