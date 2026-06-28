import '../../features/habits/data/models/habit_model.dart';
import '../../features/habits/data/models/habit_log_model.dart';

export '../../features/habits/data/models/habit_model.dart';
export '../../features/habits/data/models/habit_log_model.dart';

abstract class HabitServiceInterface {
  Future<List<Habit>> getTodayHabits();
  Future<int> getStreak();
  Future<List<Habit>> getAllHabits();
  Future<List<HabitLog>> getAllHabitLogs();
  Future<HabitLog> createHabitLog({
    required String habitId,
    DateTime? completedAt,
    String? note,
  });
}