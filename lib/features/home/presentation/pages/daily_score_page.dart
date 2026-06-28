import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../../../../features/dashboard/presentation/cubit/dashboard_todo_cubit.dart';
import '../../../../features/dashboard/presentation/cubit/dashboard_todo_state.dart';
import '../../../../features/todo/domain/repositories/todo_repository_interface.dart';
import '../cubit/home_cubit.dart';

final GetIt sl = GetIt.instance;

class DailyScorePage extends StatelessWidget {
  const DailyScorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final score = state is HomeLoaded ? state.dailyScore : null;

        final routineCompletion = score?.routineCompletionPercent ?? 0;
        final habitAdherence = score?.habitAdherencePercent ?? 0;
        final domainBalance = score?.domainBalancePercent ?? 0;
        final sleepDiscipline = score?.sleepDisciplinePercent ?? 0;
        final shadowResistance = score?.shadowResistancePercent ?? 0;
        final totalScore = score?.totalScore ?? 0;
        final streak = score?.streak ?? 0;
        final rewardPoints = score?.rewardPoints ?? 0;

        return BlocProvider(
          create: (_) => DashboardTodoCubit(
            getTodoListsByDate: sl<TodoRepositoryInterface>().getTodoListsByDate,
          )..loadTodayChecklists(),
          child: RizenScaffold(
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
                                  value: totalScore / 100,
                                  strokeWidth: 10,
                                  backgroundColor: AppColors.glassFill,
                                  color: AppColors.accent,
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '$totalScore',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.displayMedium,
                                  ),
                                  Text(
                                    'Discipline',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.labelMedium,
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
                              '$streak-day resilient streak',
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
                _buildMetric(
                  context,
                  'Routine Completion',
                  routineCompletion,
                  AppColors.success,
                ),
                _buildMetric(
                  context,
                  'Habit Adherence',
                  habitAdherence,
                  const Color(0xFF60A5FA),
                ),
                BlocSelector<DashboardTodoCubit, DashboardTodoState,
                    ({double score, bool loaded})>(
                  selector: (state) {
                    if (state is DashboardTodoLoaded) {
                      return (score: state.checklistScore, loaded: true);
                    }
                    return (score: 0.0, loaded: false);
                  },
                  builder: (context, data) {
                    final checklistPct = data.loaded ? data.score.round() : 0;
                    final color = data.score == 0
                        ? const Color(0xFFE94560)
                        : data.score < 70
                            ? const Color(0xFFFFB300)
                            : const Color(0xFF4CAF50);
                    return _ChecklistMetric(
                      checklistPct: checklistPct,
                      color: color,
                    );
                  },
                ),
                _buildMetric(
                  context,
                  'Domain Balance',
                  domainBalance,
                  const Color(0xFF818CF8),
                ),
                _buildMetric(
                  context,
                  'Sleep Discipline',
                  sleepDiscipline,
                  AppColors.warning,
                ),
                _buildMetric(
                  context,
                  'Shadow Resistance',
                  shadowResistance,
                  AppColors.shadow,
                ),
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
                              'Reward Points: $rewardPoints',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              'Continue building streaks to unlock rewards',
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
          ),
        );
      },
    );
  }

  Widget _buildMetric(
    BuildContext context,
    String label,
    int value,
    Color color,
  ) {
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
                Text(label, style: Theme.of(context).textTheme.titleMedium),
                Text(
                  '$value%',
                  style:
                      Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(color: color) ??
                      TextStyle(color: color),
                ),
              ],
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: value / 100,
              backgroundColor: AppColors.glassFill,
              color: color,
              borderRadius: BorderRadius.circular(4),
              minHeight: 6,
            ),
          ],
        ),
      ),
    );
  }
}

class _ChecklistMetric extends StatelessWidget {
  const _ChecklistMetric({
    required this.checklistPct,
    required this.color,
  });

  final int checklistPct;
  final Color color;

  @override
  Widget build(BuildContext context) {
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
                Row(
                  children: [
                    Icon(PhosphorIconsFill.listChecks, color: const Color(0xFF0F3460), size: 18),
                    const SizedBox(width: 8),
                    const Text(
                      'Checklist Discipline',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Text(
                  '$checklistPct%',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            LayoutBuilder(
              builder: (context, constraints) {
                final isRtl = Directionality.of(context) == TextDirection.rtl;
                return Stack(
                  children: [
                    Container(
                      width: constraints.maxWidth,
                      height: 6,
                      decoration: BoxDecoration(
                        color: AppColors.glassFill,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    AnimatedFractionallySizedBox(
                      widthFactor: checklistPct / 100,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeOut,
                      alignment: isRtl ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
