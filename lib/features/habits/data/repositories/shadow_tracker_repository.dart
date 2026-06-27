import '../models/habit_model.dart';
import '../models/shadow_habit_model.dart';
import 'habits_repository.dart';

class ShadowTrackerRepository {
  final HabitsRepository _habitsRepository;

  ShadowTrackerRepository({HabitsRepository? habitsRepository})
      : _habitsRepository = habitsRepository ?? HabitsRepository();

  Future<void> addShadowLog(String habitId, int minutes) async {
    await _habitsRepository.createHabitLog(habitId: habitId, note: 'Shadow');
  }

  Future<int> getTodayShadowScore() async {
    final habits = await _habitsRepository.getAllHabits();
    final shadowHabits =
        habits.where((h) => h.type == HabitType.shadow).toList();

    if (shadowHabits.isEmpty) return 0;

    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    int score = 0;
    for (final habit in shadowHabits) {
      final logs = await _habitsRepository.getLogsForHabit(habit.id);
      final todayLogs = logs.where((log) {
        return log.completedAt.isAfter(startOfDay) &&
            log.completedAt.isBefore(endOfDay);
      }).toList();
      score += todayLogs.length;
    }
    return score;
  }

  Future<List<int>> getWeeklyShadowScore() async {
    final habits = await _habitsRepository.getAllHabits();
    final shadowHabits =
        habits.where((h) => h.type == HabitType.shadow).toList();

    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final startOfWeek = DateTime(weekStart.year, weekStart.month, weekStart.day);

    final weeklyScores = <int>[];
    for (int i = 0; i < 7; i++) {
      final day = startOfWeek.add(Duration(days: i));
      final nextDay = day.add(const Duration(days: 1));

      int dayScore = 0;
      for (final habit in shadowHabits) {
        final logs = await _habitsRepository.getLogsForHabit(habit.id);
        final dayLogs = logs.where((log) {
          return log.completedAt.isAfter(day) &&
              log.completedAt.isBefore(nextDay);
        }).toList();
        dayScore += dayLogs.length;
      }
      weeklyScores.add(dayScore);
    }
    return weeklyScores;
  }

  Future<List<ShadowHabit>> getTopShadows() async {
    final habits = await _habitsRepository.getAllHabits();
    final shadowHabits =
        habits.where((h) => h.type == HabitType.shadow).toList();

    final result = <ShadowHabit>[];
    for (final habit in shadowHabits) {
      final logs = await _habitsRepository.getLogsForHabit(habit.id);
      final now = DateTime.now();
      final weekStart = now.subtract(Duration(days: now.weekday - 1));
      final startOfWeek = DateTime(weekStart.year, weekStart.month, weekStart.day);

      final weekLogs = logs.where((l) => l.completedAt.isAfter(startOfWeek)).toList();

      result.add(ShadowHabit(
        id: habit.id,
        name: habit.name,
        category: 'shadow',
        timeWasted: weekLogs.length * 15,
        frequency: habit.frequency == HabitFrequency.daily
            ? ShadowFrequency.daily
            : ShadowFrequency.weekly,
        loggedAt: weekLogs.isNotEmpty
            ? weekLogs.first.completedAt
            : now,
      ));
    }

    result.sort((a, b) => b.timeWasted.compareTo(a.timeWasted));
    return result;
  }
}
