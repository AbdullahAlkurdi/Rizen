import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/skeleton_loader.dart';
import '../../../../core/widgets/feature_scaffold.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/rizen_button.dart';
import '../../../todo/presentation/widgets/todo_checklist_widget.dart';
import '../../data/models/habit_model.dart';
import '../cubit/habits_cubit.dart';

class HabitCheckinPage extends StatefulWidget {
  const HabitCheckinPage({super.key, this.habitId});

  final String? habitId;

  @override
  State<HabitCheckinPage> createState() => _HabitCheckinPageState();
}

class _HabitCheckinPageState extends State<HabitCheckinPage> {
  final _noteController = TextEditingController();
  String? _selectedHabitId;
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    _selectedHabitId = widget.habitId;
    if (widget.habitId == null) {
      context.read<HabitsCubit>().loadHabits();
    } else {
      context.read<HabitsCubit>().loadHabit(widget.habitId!);
    }
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FeatureScaffold(
      title: 'Daily Check-in',
      subtitle: 'Instant habit logging in one tap.',
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: Icon(PhosphorIconsFill.microphone),
        label: const Text('Voice Log'),
      ),
      body: BlocConsumer<HabitsCubit, HabitsState>(
        listener: (context, state) {
          if (_submitted && state is HabitsLoaded) {
            context.pop();
          }
          if (state is HabitsError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is HabitsLoading) {
            return ListView(
              padding: const EdgeInsets.all(20),
              children: const [
                SkeletonListTile(),
                SizedBox(height: 10),
                SkeletonListTile(),
                SizedBox(height: 10),
                SkeletonListTile(),
              ],
            );
          }
          if (state is HabitsError) {
            return Center(child: Text(state.message));
          }

final habits = state is HabitsLoaded ? state.all : <Habit>[];
           final selectedHabit = widget.habitId != null && state is HabitsLoaded
               ? state.selectedHabit
               : null;
           final choices = selectedHabit == null ? habits : [selectedHabit];

           return ListView(
             children: [
               if (choices.isEmpty)
                 const GlassCard(child: Text('No habits available to check in.'))
               else
                 ...choices.map(
                   (habit) => Padding(
                     padding: const EdgeInsets.only(bottom: 10),
                     child: _HabitChoice(
                       habit: habit,
                       selected: _selectedHabitId == habit.id,
                       onTap: () => setState(() => _selectedHabitId = habit.id),
                     ),
                   ),
                 ),
               if (_selectedHabitId != null) ...[
                 const SizedBox(height: 16),
                 Builder(
                   builder: (context) {
                     final selectedHabit = habits.firstWhere(
                       (h) => h.id == _selectedHabitId,
                       orElse: () => Habit(
                         id: '',
                         uid: '',
                         name: '',
                         type: HabitType.positive,
                         frequency: HabitFrequency.daily,
                         targetCount: 1,
                         currentStreak: 0,
                         longestStreak: 0,
                         isActive: true,
                         createdAt: DateTime.now(),
                       ),
                     );
                     if (!selectedHabit.hasTodoList) return const SizedBox.shrink();
                     return TodoChecklistWidget(
                       parentId: selectedHabit.id,
                       parentType: 'habit',
                     );
                   },
                 ),
               ],
               const SizedBox(height: 16),
              TextField(
                controller: _noteController,
                minLines: 2,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Note',
                  hintText: 'Optional context for this check-in',
                ),
              ),
              const SizedBox(height: 24),
              RizenButton(
                label: 'Mark Done',
                icon: PhosphorIconsBold.check,
                onPressed: _selectedHabitId == null ? null : _checkIn,
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _checkIn() async {
    _submitted = true;
    await context.read<HabitsCubit>().checkIn(
      habitId: _selectedHabitId!,
      note: _noteController.text.trim().isEmpty
          ? null
          : _noteController.text.trim(),
    );
  }
}

class _HabitChoice extends StatelessWidget {
  const _HabitChoice({
    required this.habit,
    required this.selected,
    required this.onTap,
  });

  final Habit habit;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = habit.type == HabitType.positive
        ? AppColors.success
        : AppColors.shadow;

    return GlassCard(
      onTap: onTap,
      borderColor: selected ? color : null,
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(habit.name, style: Theme.of(context).textTheme.bodyLarge),
                Text(
                  '${habit.currentStreak}-day streak',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Icon(
            selected ? PhosphorIconsFill.checkCircle : PhosphorIconsBold.circle,
            color: selected ? color : AppColors.textMuted,
            size: 22,
          ),
        ],
      ),
    );
  }
}
