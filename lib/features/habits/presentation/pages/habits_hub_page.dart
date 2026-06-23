import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/nav_glass_tile.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../../data/models/habit_model.dart';
import '../cubit/habits_cubit.dart';

class HabitsHubPage extends StatefulWidget {
  const HabitsHubPage({super.key});

  @override
  State<HabitsHubPage> createState() => _HabitsHubPageState();
}

class _HabitsHubPageState extends State<HabitsHubPage> {
  @override
  void initState() {
    super.initState();
    context.read<HabitsCubit>().loadHabits();
  }

  @override
  Widget build(BuildContext context) {
    return RizenScaffold(
      extendBody: true,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
      body: BlocBuilder<HabitsCubit, HabitsState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () => context.read<HabitsCubit>().loadHabits(),
            child: ListView(
              children: [
                const PageHeader(
                  title: 'Habit Engine',
                  subtitle: 'Positive patterns and shadow behavior tracking.',
                ),
                const SizedBox(height: 20),
                if (state is HabitsLoading)
                  const Center(child: CircularProgressIndicator())
                else if (state is HabitsError)
                  _MessageCard(message: state.message)
                else if (state is HabitsLoaded) ...[
                  _StreakSummary(habits: state.all),
                  const SizedBox(height: 18),
                  _HabitSection(
                    title: 'Positive Habits',
                    emptyText: 'No positive habits yet.',
                    habits: state.positive,
                    color: AppColors.success,
                  ),
                  const SizedBox(height: 18),
                  _HabitSection(
                    title: 'Shadow Habits',
                    emptyText: 'No shadow habits yet.',
                    habits: state.shadow,
                    color: AppColors.shadow,
                  ),
                ] else
                  const _MessageCard(message: 'Habit Engine is ready.'),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: RizenButton(
                        label: 'Add Habit',
                        icon: PhosphorIconsBold.plus,
                        onPressed: () => context.push(AppRoutes.habitAdd),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: RizenButton(
                        label: 'Check In',
                        icon: PhosphorIconsBold.checkCircle,
                        variant: RizenButtonVariant.secondary,
                        onPressed: () => context.push(AppRoutes.habitCheckin),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                NavGlassTile(
                  title: 'Shadow Score',
                  subtitle: 'How much energy negative habits have stolen.',
                  icon: PhosphorIconsBold.skull,
                  iconColor: AppColors.shadow,
                  onTap: () => context.push(AppRoutes.shadowScore),
                ),
                const SizedBox(height: 10),
                NavGlassTile(
                  title: 'Reward Store',
                  subtitle:
                      'Unlock real-life pleasures with discipline points.',
                  icon: PhosphorIconsBold.gift,
                  iconColor: AppColors.accent,
                  onTap: () => context.push(AppRoutes.rewardStore),
                ),
                const SizedBox(height: 10),
                NavGlassTile(
                  title: 'Habit Analytics',
                  subtitle: 'Trend maps and predictive habit charts.',
                  icon: PhosphorIconsBold.chartLineUp,
                  iconColor: const Color(0xFF60A5FA),
                  onTap: () => context.push(AppRoutes.habitAnalytics),
                ),
                const SizedBox(height: 10),
                NavGlassTile(
                  title: 'Emergency Recovery Mode',
                  subtitle: '1-tap workload reduction to prevent burnout.',
                  icon: PhosphorIconsBold.firstAid,
                  iconColor: AppColors.warning,
                  onTap: () => context.push(AppRoutes.emergencyRecovery),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _StreakSummary extends StatelessWidget {
  const _StreakSummary({required this.habits});

  final List<Habit> habits;

  @override
  Widget build(BuildContext context) {
    final best = habits.fold<int>(
      0,
      (value, habit) =>
          habit.longestStreak > value ? habit.longestStreak : value,
    );

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.success.withValues(alpha: 0.15),
            AppColors.glassFill,
          ],
        ),
        borderRadius: AppTheme.cardRadius,
        border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(PhosphorIconsFill.trophy, color: AppColors.success, size: 24),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$best-day best streak',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  '${habits.length} active habit${habits.length == 1 ? '' : 's'} tracked',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HabitSection extends StatelessWidget {
  const _HabitSection({
    required this.title,
    required this.emptyText,
    required this.habits,
    required this.color,
  });

  final String title;
  final String emptyText;
  final List<Habit> habits;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 10),
        if (habits.isEmpty)
          _MessageCard(message: emptyText)
        else
          ...habits.map(
            (habit) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GlassCard(
                onTap: () => context.push(AppRoutes.habitDetailPath(habit.id)),
                child: Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.15),
                        borderRadius: AppTheme.cardRadius,
                      ),
                      child: Icon(
                        habit.type == HabitType.positive
                            ? PhosphorIconsBold.checkCircle
                            : PhosphorIconsBold.skull,
                        color: color,
                        size: 21,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            habit.name,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            '${habit.frequency.name} · ${habit.currentStreak}-day streak · best ${habit.longestStreak}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      habit.isActive
                          ? PhosphorIconsFill.fire
                          : PhosphorIconsBold.pauseCircle,
                      color: habit.isActive
                          ? AppColors.warning
                          : AppColors.textMuted,
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _MessageCard extends StatelessWidget {
  const _MessageCard({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Text(message, style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}
