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
    this.shadowScore = 0,
  });

  final List<Habit> positive;
  final List<Habit> shadow;
  final Habit? selectedHabit;
  final List<HabitLog> logs;
  final int shadowScore;

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

  Future<void> checkInWithTodo({
    required String habitId,
    String? note,
  }) async {
    emit(HabitsLoading());
    try {
      await _repository.createHabitLog(habitId: habitId, note: note);
      await loadHabit(habitId);
    } catch (e) {
      emit(HabitsError(e.toString()));
    }
  }

  Future<void> loadHabits() async {
    emit(HabitsLoading());
    try {
      final habits = await _repository.getAllHabits();
      final shadowScore = await _calculateShadowScore(habits);
      emit(_loadedFrom(habits, shadowScore: shadowScore));
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
      final shadowScore = await _calculateShadowScore(habits);
      emit(_loadedFrom(habits,
          selectedHabit: selectedHabit, logs: logs, shadowScore: shadowScore));
    } catch (e) {
      emit(HabitsError(e.toString()));
    }
  }

  Future<Habit?> createHabit({
    required String name,
    required HabitType type,
    required HabitFrequency frequency,
    required int targetCount,
    bool hasTodoList = false,
    int completionThreshold = 70,
  }) async {
    emit(HabitsLoading());
    try {
      final habit = await _repository.createHabit(
        name: name,
        type: type,
        frequency: frequency,
        targetCount: targetCount,
        hasTodoList: hasTodoList,
        completionThreshold: completionThreshold,
      );
      final habits = await _repository.getAllHabits();
      final shadowScore = await _calculateShadowScore(habits);
      emit(_loadedFrom(habits, shadowScore: shadowScore));
      return habit;
    } catch (e) {
      emit(HabitsError(e.toString()));
      return null;
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
      final shadowScore = await _calculateShadowScore(habits);
      emit(_loadedFrom(habits, shadowScore: shadowScore));
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

  Future<int> _calculateShadowScore(List<Habit> habits) async {
    final shadowHabits = habits.where((h) => h.type == HabitType.shadow).toList();
    if (shadowHabits.isEmpty) return 0;

    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    int score = 0;
    for (final habit in shadowHabits) {
      final logs = await _repository.getLogsForHabit(habit.id);
      final todayLogs = logs.where((log) {
        return log.completedAt.isAfter(startOfDay) &&
            log.completedAt.isBefore(endOfDay);
      }).toList();
      score += todayLogs.length;
    }
    return score;
  }

  HabitsLoaded _loadedFrom(
    List<Habit> habits, {
    Habit? selectedHabit,
    List<HabitLog> logs = const [],
    int shadowScore = 0,
  }) {
    return HabitsLoaded(
      positive: habits
          .where((habit) => habit.type == HabitType.positive)
          .toList(),
      shadow: habits.where((habit) => habit.type == HabitType.shadow).toList(),
      selectedHabit: selectedHabit,
      logs: logs,
      shadowScore: shadowScore,
    );
  }
}