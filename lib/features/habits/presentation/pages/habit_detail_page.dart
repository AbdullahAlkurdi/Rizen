import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../../../core/widgets/rizen_scaffold.dart';
import '../../../../core/widgets/skeleton_loader.dart';
import '../../../../core/tutorials/tutorial_mixin.dart';
import '../../../../core/services/tutorial_service.dart';
import '../../../../core/tutorials/rizen_tutorial.dart';
import '../../../todo/presentation/widgets/todo_checklist_widget.dart';
import '../../data/models/habit_log_model.dart';
import '../../data/models/habit_model.dart';
import '../cubit/habits_cubit.dart';

class HabitDetailPage extends StatefulWidget {
  const HabitDetailPage({super.key, required this.habitId});

  final String habitId;

  @override
  State<HabitDetailPage> createState() => _HabitDetailPageState();
}

class _HabitDetailPageState extends State<HabitDetailPage> with TutorialMixin {
  @override
  String get tutorialKey => TutorialService.keys['habit_detail']!;

  @override
  List<TargetFocus> buildTargets() => RizenTutorial.habitDetail(_tutorialKeys);

  final Map<String, GlobalKey> _tutorialKeys = {
    'streak': GlobalKey(),
    'checklist': GlobalKey(),
    'manage': GlobalKey(),
  };

  @override
  void initState() {
    super.initState();
    context.read<HabitsCubit>().loadHabit(widget.habitId);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) maybeShowTutorial();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RizenScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(PhosphorIconsBold.arrowLeft),
          onPressed: () => context.pop(),
        ),
        title: const Text('Habit Detail'),
        actions: [
          IconButton(
            onPressed: () =>
                context.push(AppRoutes.habitEditPath(widget.habitId)),
            icon: const Icon(PhosphorIconsBold.pencilSimple),
          ),
          IconButton(
            onPressed: showTutorialNow,
            icon: const Icon(PhosphorIconsBold.question),
            color: const Color(0xFF9CA3AF),
            tooltip: 'Help',
          ),
        ],
      ),
      body: BlocBuilder<HabitsCubit, HabitsState>(
        builder: (context, state) {
          if (state is HabitsLoading) {
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                SkeletonCard(height: 120),
                const SizedBox(height: 20),
                SkeletonCard(height: 80),
                const SizedBox(height: 20),
                const SkeletonListTile(),
                const SizedBox(height: 10),
                const SkeletonListTile(),
                const SizedBox(height: 10),
                const SkeletonListTile(),
                const SizedBox(height: 20),
                SkeletonBarChart(barCount: 7),
              ],
            );
          }
          if (state is HabitsError) {
            return Center(child: Text(state.message));
          }
          if (state is! HabitsLoaded || state.selectedHabit == null) {
            return const Center(child: Text('Habit not found'));
          }

          final habit = state.selectedHabit!;
          return ListView(
            children: [
              Container(
                key: _tutorialKeys['streak'],
                child: _HabitHeader(habit: habit),
              ),
              const SizedBox(height: 20),
              if (habit.hasTodoList) ...[
                Container(
                  key: _tutorialKeys['checklist'],
                  child: TodoChecklistWidget(
                    parentId: habit.id,
                    parentType: 'habit',
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  key: _tutorialKeys['manage'],
                  child: RizenButton(
                    label: 'Manage Checklist',
                    icon: PhosphorIconsBold.list,
                    variant: RizenButtonVariant.secondary,
                    onPressed: () => context.push(
                      AppRoutes.todoEditor
                          .replaceAll(':parentId', habit.id)
                          .replaceAll(':parentType', 'habit'),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
              RizenButton(
                label: 'Check In',
                icon: PhosphorIconsBold.checkCircle,
                onPressed: () =>
                    context.push(AppRoutes.habitCheckinPath(habit.id)),
              ),
              const SizedBox(height: 24),
              Text(
                'Streak Matrix',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              _StreakMatrix(logs: state.logs, color: _habitColor(habit)),
              const SizedBox(height: 24),
              Text(
                'Log History',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              if (state.logs.isEmpty)
                const GlassCard(child: Text('No check-ins logged yet.'))
              else
                ...state.logs.map(
                  (log) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _LogTile(log: log),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _HabitHeader extends StatelessWidget {
  const _HabitHeader({required this.habit});

  final Habit habit;

  @override
  Widget build(BuildContext context) {
    final color = _habitColor(habit);
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: AppTheme.cardRadius,
                ),
                child: Icon(
                  habit.type == HabitType.positive
                      ? PhosphorIconsBold.checkCircle
                      : PhosphorIconsBold.skull,
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      habit.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      '${habit.frequency.name} · target ${habit.targetCount}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _Metric(label: 'Current', value: habit.currentStreak.toString()),
              _Metric(label: 'Longest', value: habit.longestStreak.toString()),
              _Metric(
                label: 'Status',
                value: habit.isActive ? 'Active' : 'Paused',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: Theme.of(context).textTheme.titleMedium),
          Text(label, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}

class _StreakMatrix extends StatelessWidget {
  const _StreakMatrix({required this.logs, required this.color});

  final List<HabitLog> logs;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final completed = logs
        .map(
          (log) => DateTime(
            log.completedAt.year,
            log.completedAt.month,
            log.completedAt.day,
          ),
        )
        .toSet();
    final today = DateTime.now();

    return GlassCard(
      child: Column(
        children: List.generate(4, (week) {
          return Padding(
            padding: EdgeInsets.only(bottom: week == 3 ? 0 : 12),
            child: Row(
              children: List.generate(7, (day) {
                final offset = 27 - ((week * 7) + day);
                final date = today.subtract(Duration(days: offset));
                final key = DateTime(date.year, date.month, date.day);
                final complete = completed.contains(key);
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Container(
                      height: 28,
                      decoration: BoxDecoration(
                        color: complete
                            ? color.withValues(alpha: 0.36)
                            : AppColors.glassFill,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: complete
                              ? color.withValues(alpha: 0.48)
                              : Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
        }),
      ),
    );
  }
}

class _LogTile extends StatelessWidget {
  const _LogTile({required this.log});

  final HabitLog log;

  @override
  Widget build(BuildContext context) {
    final date = log.completedAt;
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      child: Row(
        children: [
          Icon(PhosphorIconsFill.checkCircle, color: AppColors.success),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${date.year}-${_two(date.month)}-${_two(date.day)}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                if (log.note != null && log.note!.trim().isNotEmpty)
                  Text(log.note!, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Color _habitColor(Habit habit) {
  return habit.type == HabitType.positive
      ? AppColors.success
      : AppColors.shadow;
}

String _two(int value) => value.toString().padLeft(2, '0');
