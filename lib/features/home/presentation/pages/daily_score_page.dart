import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../../../routines/presentation/bloc/routines_bloc.dart';

class DailyScorePage extends StatelessWidget {
  const DailyScorePage({super.key});

  static const _metrics = [
    _ScoreMetric('Routine Completion', 82, AppColors.success),
    _ScoreMetric('Habit Adherence', 71, Color(0xFF60A5FA)),
    _ScoreMetric('Domain Balance', 68, Color(0xFF818CF8)),
    _ScoreMetric('Sleep Discipline', 55, AppColors.warning),
    _ScoreMetric('Shadow Resistance', 74, AppColors.shadow),
  ];

  @override
  Widget build(BuildContext context) {
    final state = context.watch<RoutineCubit>().state;
    return RizenScaffold(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
      body: ListView(
        children: [
          Text(
            'Daily Score Card',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Your discipline snapshot for today.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 28),
          Center(
            child: GlassCard(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  SizedBox(
                    width: 140,
                    height: 140,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 140,
                          height: 140,
                          child: CircularProgressIndicator(
                            value: (state.routines.isNotEmpty ? 78 : 0) / 100,
                            strokeWidth: 10,
                            backgroundColor: AppColors.glassFill,
                            color: AppColors.accent,
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${(state.routines.isNotEmpty ? 78 : 0)}',
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            Text(
                              'Discipline',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        PhosphorIconsFill.fire,
                        color: AppColors.warning,
                        size: 18,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '12-day resilient streak',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 28),
          Text(
            'Score Breakdown',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 14),
          ..._metrics.map((metric) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GlassCard(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          metric.label,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          '${metric.value}%',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(color: metric.color),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: metric.value / 100,
                      backgroundColor: AppColors.glassFill,
                      color: metric.color,
                      borderRadius: BorderRadius.circular(4),
                      minHeight: 6,
                    ),
                  ],
                ),
              ),
            );
          }),
          GlassCard(
            gradient: LinearGradient(
              colors: [
                AppColors.accent.withValues(alpha: 0.12),
                AppColors.cardBackground.withValues(alpha: 0.7),
              ],
            ),
            child: Row(
              children: [
                Icon(PhosphorIconsFill.gift, color: AppColors.accent),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reward Points: 340',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        '60 points until you unlock "Coffee reward"',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ScoreMetric {
  const _ScoreMetric(this.label, this.value, this.color);

  final String label;
  final int value;
  final Color color;
}
