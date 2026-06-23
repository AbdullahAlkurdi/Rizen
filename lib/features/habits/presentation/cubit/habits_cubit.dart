import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/habit_log_model.dart';
import '../../data/models/habit_model.dart';
import '../../data/repositories/habits_repository.dart';

sealed class HabitsState {}

final class HabitsInitial extends HabitsState {}

final class HabitsLoading extends HabitsState {}

final class HabitsLoaded extends HabitsState {
  HabitsLoaded({
    required this.positive,
    required this.shadow,
    this.selectedHabit,
    this.logs = const [],
  });

  final List<Habit> positive;
  final List<Habit> shadow;
  final Habit? selectedHabit;
  final List<HabitLog> logs;

  List<Habit> get all => [...positive, ...shadow];
}

final class HabitsError extends HabitsState {
  HabitsError(this.message);

  final String message;
}

class HabitsCubit extends Cubit<HabitsState> {
  HabitsCubit({HabitsRepository? repository})
    : _repository = repository ?? HabitsRepository(),
      super(HabitsInitial());

  final HabitsRepository _repository;

  Future<void> loadHabits() async {
    emit(HabitsLoading());
    try {
      final habits = await _repository.getAllHabits();
      emit(_loadedFrom(habits));
    } catch (e) {
      emit(HabitsError(e.toString()));
    }
  }

  Future<void> loadHabit(String habitId) async {
    emit(HabitsLoading());
    try {
      final habits = await _repository.getAllHabits();
      final selectedHabit = await _repository.getHabit(habitId);
      if (selectedHabit == null) {
        emit(HabitsError('Habit not found'));
        return;
      }
      final logs = await _repository.getLogsForHabit(habitId);
      emit(_loadedFrom(habits, selectedHabit: selectedHabit, logs: logs));
    } catch (e) {
      emit(HabitsError(e.toString()));
    }
  }

  Future<void> createHabit({
    required String name,
    required HabitType type,
    required HabitFrequency frequency,
    required int targetCount,
  }) async {
    emit(HabitsLoading());
    try {
      await _repository.createHabit(
        name: name,
        type: type,
        frequency: frequency,
        targetCount: targetCount,
      );
      final habits = await _repository.getAllHabits();
      emit(_loadedFrom(habits));
    } catch (e) {
      emit(HabitsError(e.toString()));
    }
  }

  Future<void> updateHabit(Habit habit) async {
    emit(HabitsLoading());
    try {
      await _repository.updateHabit(habit);
      await loadHabit(habit.id);
    } catch (e) {
      emit(HabitsError(e.toString()));
    }
  }

  Future<void> deleteHabit(String habitId) async {
    emit(HabitsLoading());
    try {
      await _repository.deleteHabit(habitId);
      final habits = await _repository.getAllHabits();
      emit(_loadedFrom(habits));
    } catch (e) {
      emit(HabitsError(e.toString()));
    }
  }

  Future<void> checkIn({required String habitId, String? note}) async {
    emit(HabitsLoading());
    try {
      await _repository.createHabitLog(habitId: habitId, note: note);
      await loadHabit(habitId);
    } catch (e) {
      emit(HabitsError(e.toString()));
    }
  }

  HabitsLoaded _loadedFrom(
    List<Habit> habits, {
    Habit? selectedHabit,
    List<HabitLog> logs = const [],
  }) {
    return HabitsLoaded(
      positive: habits
          .where((habit) => habit.type == HabitType.positive)
          .toList(),
      shadow: habits.where((habit) => habit.type == HabitType.shadow).toList(),
      selectedHabit: selectedHabit,
      logs: logs,
    );
  }
}
