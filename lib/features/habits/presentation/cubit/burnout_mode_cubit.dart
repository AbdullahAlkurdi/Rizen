import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/habit_model.dart';
import '../../data/repositories/habits_repository.dart';

class Task {
  const Task({
    required this.id,
    required this.title,
    required this.isCritical,
  });

  final String id;
  final String title;
  final bool isCritical;
}

sealed class BurnoutModeState {}

final class BurnoutModeInitial extends BurnoutModeState {}

final class BurnoutModeLoading extends BurnoutModeState {}

final class BurnoutModeActive extends BurnoutModeState {
  BurnoutModeActive({required this.survivalTasks, required this.message});
  final List<Task> survivalTasks;
  final String message;
}

final class BurnoutModeInactive extends BurnoutModeState {}

final class BurnoutModeError extends BurnoutModeState {
  BurnoutModeError(this.message);
  final String message;
}

class BurnoutModeCubit extends Cubit<BurnoutModeState> {
  BurnoutModeCubit({HabitsRepository? habitsRepository})
      : _habitsRepository = habitsRepository ?? HabitsRepository(),
        super(BurnoutModeInitial());

  final HabitsRepository _habitsRepository;

  Future<void> activateEmergencyMode() async {
    emit(BurnoutModeLoading());
    try {
      final habits = await _habitsRepository.getAllHabits();
      final positiveHabits = habits
          .where((h) => h.type == HabitType.positive && h.isActive)
          .toList();

      final criticalTasks = positiveHabits
          .take(3)
          .map((h) => Task(
                id: h.id,
                title: h.name,
                isCritical: true,
              ))
          .toList();

      emit(BurnoutModeActive(
        survivalTasks: criticalTasks,
        message: 'Emergency mode activated. Focus on survival baseline only.',
      ));
    } catch (e) {
      emit(BurnoutModeError(e.toString()));
    }
  }

  Future<void> deactivateEmergencyMode() async {
    emit(BurnoutModeInactive());
  }

  Future<List<Task>> getCurrentRoutine() async {
    if (state is BurnoutModeActive) {
      return (state as BurnoutModeActive).survivalTasks;
    }

    final habits = await _habitsRepository.getAllHabits();
    final activeHabits = habits.where((h) => h.isActive).toList();
    return activeHabits
        .map((h) => Task(
              id: h.id,
              title: h.name,
              isCritical: h.type == HabitType.positive,
            ))
        .toList();
  }
}
