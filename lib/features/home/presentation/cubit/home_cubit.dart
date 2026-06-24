import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../routines/data/models/routine_model.dart';
import '../../../routines/data/repositories/routine_repository.dart';
import '../../../habits/data/models/habit_log_model.dart';
import '../../../habits/data/models/habit_model.dart';
import '../../../habits/data/repositories/habits_repository.dart';
import '../../../domains/data/domain_catalog.dart';
import '../../../domains/data/models/domain_log_model.dart';
import '../../../domains/data/repositories/domain_logs_repository.dart';
import '../../data/models/daily_score_model.dart';
import '../../data/models/sleep_log_model.dart';
import '../../data/repositories/sleep_log_repository.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  HomeLoaded({
    required this.dailyScore,
    required this.weeklyScores,
    required this.completedDays,
    required this.notifications,
    required this.todaySleepLog,
    required this.sleepWeekPattern,
  });

  final DailyScore dailyScore;
  final List<WeeklyScore> weeklyScores;
  final Set<int> completedDays;
  final List<NotificationItem> notifications;
  final SleepLog? todaySleepLog;
  final List<double> sleepWeekPattern;
}

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required this.routineRepository,
    required this.habitsRepository,
    required this.domainLogsRepository,
    required this.sleepLogRepository,
  }) : super(HomeInitial());

  final RoutineRepository routineRepository;
  final HabitsRepository habitsRepository;
  final DomainLogsRepository domainLogsRepository;
  final SleepLogRepository sleepLogRepository;

  Future<void> loadHome() async {
    emit(HomeLoading());
    try {
      final routines = await routineRepository.getAllRoutines();
      final enabledRoutines = routines.where((r) => r.isEnabled).toList();

      final allHabits = await habitsRepository.getAllHabits();
      final activeHabits = allHabits.where((h) => h.isActive).toList();
      final positiveHabits = activeHabits
          .where((h) => h.type == HabitType.positive)
          .toList();
      final shadowHabits = activeHabits
          .where((h) => h.type == HabitType.shadow)
          .toList();

      final allHabitLogs = await habitsRepository.getAllHabitLogs();
      final habitLogsToday = _filterToday(allHabitLogs, (l) => l.completedAt);

      final positiveLogsToday = habitLogsToday.where((l) {
        final habit = _findHabit(allHabits, l.habitId);
        return habit != null && habit.type == HabitType.positive;
      }).toList();

      final shadowLogsToday = habitLogsToday.where((l) {
        final habit = _findHabit(allHabits, l.habitId);
        return habit != null && habit.type == HabitType.shadow;
      }).toList();

      final allDomainLogsByDomain = <String, List<DomainLog>>{};
      for (final domain in DomainCatalog.all) {
        try {
          final logs = await domainLogsRepository.getLogsByDomain(
            domain.routeId,
          );
          allDomainLogsByDomain[domain.routeId] = logs;
        } catch (_) {
          allDomainLogsByDomain[domain.routeId] = [];
        }
      }
      final allDomainLogs = allDomainLogsByDomain.values
          .expand((e) => e)
          .toList();
      final domainLogsToday = allDomainLogs
          .where((l) => _isSameDay(l.loggedAt, DateTime.now()))
          .toList();

      SleepLog? todaySleepLog;
      try {
        todaySleepLog = await sleepLogRepository.getTodaySleepLog();
      } catch (_) {}

      int totalBlocksToday = 0;
      int completedBlocksToday = 0;
      for (final routine in enabledRoutines) {
        final blocks = await routineRepository.getTimeBlocks(routine.id);
        for (final block in blocks) {
          totalBlocksToday++;
          if (block.isCompleted) completedBlocksToday++;
        }
      }

      final routineCompletion = totalBlocksToday > 0
          ? (completedBlocksToday / totalBlocksToday * 100).round()
          : 0;
      final habitAdherence = positiveHabits.isNotEmpty
          ? (positiveLogsToday.length / positiveHabits.length * 100).round()
          : 0;
      final domainBalance = DomainCatalog.all.isNotEmpty
          ? (domainLogsToday.length / DomainCatalog.all.length * 100).round()
          : 0;

      double sleepDiscipline = 0;
      if (todaySleepLog != null) {
        if (todaySleepLog.bedResistanceMetric != null) {
          final metric = todaySleepLog.bedResistanceMetric as double;
          sleepDiscipline = (1 - metric).clamp(0.0, 1.0) * 100;
        } else if (todaySleepLog.wakeTimeTarget != null) {
          final target = todaySleepLog.wakeTimeTarget!;
          final end = todaySleepLog.sleepEnd;
          final delay = target.difference(end).inMinutes;
          if (delay <= 0) {
            sleepDiscipline = 100;
          } else if (delay <= 15) {
            sleepDiscipline = 80;
          } else if (delay <= 30) {
            sleepDiscipline = 60;
          } else if (delay <= 60) {
            sleepDiscipline = 40;
          } else {
            sleepDiscipline = 20;
          }
        }
      }

      double shadowResistance = 100;
      if (shadowHabits.isNotEmpty) {
        final shadowPercent =
            shadowLogsToday.length / shadowHabits.length * 100;
        shadowResistance = (100 - shadowPercent).clamp(0.0, 100.0);
      }

      final totalScore =
          ((routineCompletion +
                      habitAdherence +
                      domainBalance +
                      sleepDiscipline +
                      shadowResistance) /
                  5)
              .round();

      int streak = 0;
      var checkDate = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      );
      while (true) {
        final dayPositiveLogs = allHabitLogs.where((l) {
          return _isSameDay(l.completedAt, checkDate) &&
              _isPositiveHabit(allHabits, l.habitId);
        }).toList();
        if (dayPositiveLogs.length >= positiveHabits.length &&
            positiveHabits.isNotEmpty) {
          streak++;
          checkDate = checkDate.subtract(const Duration(days: 1));
        } else {
          break;
        }
      }

      final rewardPoints = allHabitLogs.length * 10;

      final dailyScore = DailyScore(
        routineCompletionPercent: routineCompletion,
        habitAdherencePercent: habitAdherence,
        domainBalancePercent: domainBalance,
        sleepDisciplinePercent: sleepDiscipline.round(),
        shadowResistancePercent: shadowResistance.round(),
        totalScore: totalScore,
        streak: streak,
        rewardPoints: rewardPoints,
      );

      final weeklyScores = <WeeklyScore>[];
      for (int i = 6; i >= 0; i--) {
        final date = DateTime.now().subtract(Duration(days: i));
        final score = _computeWeeklyScoreForDay(
          date: date,
          allHabits: allHabits,
          activeHabits: activeHabits,
          allHabitLogs: allHabitLogs,
          allDomainLogs: allDomainLogs,
          enabledRoutines: enabledRoutines,
        );
        weeklyScores.add(score);
      }

      final completedDays = _computeMonthlyCompletedDays(
        allHabitLogs: allHabitLogs,
        allDomainLogs: allDomainLogs,
        enabledRoutines: enabledRoutines,
      );

      final notifications = _generateNotifications(
        dailyScore: dailyScore,
        todaySleepLog: todaySleepLog,
        shadowLogsToday: shadowLogsToday,
        allHabits: allHabits,
      );

      final sleepLogs = await sleepLogRepository.getSleepLogs(limit: 7);
      final sleepWeekPattern = <double>[];
      for (int i = 6; i >= 0; i--) {
        final targetDate = DateTime.now().subtract(Duration(days: i));
        final sameDay = sleepLogs
            .where((l) => _isSameDay(l.sleepStart, targetDate))
            .toList();
        final dayLog = sameDay.isNotEmpty ? sameDay.first : null;
        if (dayLog != null) {
          final hours =
              dayLog.sleepEnd.difference(dayLog.sleepStart).inMinutes / 60.0;
          sleepWeekPattern.add(hours.clamp(0.0, 12.0) / 12.0);
        } else {
          sleepWeekPattern.add(0.0);
        }
      }

      emit(
        HomeLoaded(
          dailyScore: dailyScore,
          weeklyScores: weeklyScores,
          completedDays: completedDays,
          notifications: notifications,
          todaySleepLog: todaySleepLog,
          sleepWeekPattern: sleepWeekPattern,
        ),
      );
    } catch (e) {
      emit(HomeLoading());
    }
  }

  Future<void> confirmSleepLog(String logId, bool confirmed) async {
    try {
      await sleepLogRepository.confirmSleepLog(
        logId: logId,
        confirmed: confirmed,
      );
      await loadHome();
    } catch (_) {}
  }

  Habit? _findHabit(List<Habit> habits, String habitId) {
    for (final h in habits) {
      if (h.id == habitId) return h;
    }
    return null;
  }

  bool _isPositiveHabit(List<Habit> habits, String habitId) {
    final habit = _findHabit(habits, habitId);
    return habit != null && habit.type == HabitType.positive;
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  List<T> _filterToday<T>(List<T> items, DateTime Function(T) getDate) {
    final today = DateTime.now();
    return items.where((item) => _isSameDay(getDate(item), today)).toList();
  }

  WeeklyScore _computeWeeklyScoreForDay({
    required DateTime date,
    required List<Habit> allHabits,
    required List<Habit> activeHabits,
    required List<HabitLog> allHabitLogs,
    required List<DomainLog> allDomainLogs,
    required List<Routine> enabledRoutines,
  }) {
    final dayHabitLogs = allHabitLogs
        .where((l) => _isSameDay(l.completedAt, date))
        .toList();
    final positiveLogs = dayHabitLogs
        .where((l) => _isPositiveHabit(allHabits, l.habitId))
        .toList();
    final shadowLogs = dayHabitLogs.where((l) {
      final habit = _findHabit(allHabits, l.habitId);
      return habit != null && habit.type == HabitType.shadow;
    }).toList();

    final habitAdherence = activeHabits.isNotEmpty
        ? (positiveLogs.length / activeHabits.length * 100).round()
        : 0;

    final domainActivities = allDomainLogs
        .where((l) => _isSameDay(l.loggedAt, date))
        .length;
    final domainBalance = DomainCatalog.all.isNotEmpty
        ? (domainActivities / DomainCatalog.all.length * 100).round()
        : 0;

    int sleepHours = 0;
    int routineCompleted = 0;
    int longestStreak = 0;
    for (final routine in enabledRoutines) {
      if (routine.streak > longestStreak) longestStreak = routine.streak;
    }
    final daysDiff = DateTime.now().difference(date).inDays;
    if (daysDiff < longestStreak) {
      routineCompleted = 100;
    }

    double shadowResistance = 100;
    final currentShadowHabits = activeHabits
        .where((h) => h.type == HabitType.shadow)
        .toList();
    if (currentShadowHabits.isNotEmpty) {
      final shadowPercent =
          shadowLogs.length / currentShadowHabits.length * 100;
      shadowResistance = (100 - shadowPercent).clamp(0.0, 100.0);
    }

    double sleepDiscipline = 0;

    final totalScore =
        ((routineCompleted +
                    habitAdherence +
                    domainBalance +
                    sleepDiscipline +
                    shadowResistance) /
                5)
            .round();

    return WeeklyScore(
      date: date,
      score: totalScore,
      routineCompleted: routineCompleted,
      habitsChecked: positiveLogs.length,
      domainActivities: domainActivities,
      sleepHours: sleepHours,
    );
  }

  Set<int> _computeMonthlyCompletedDays({
    required List<HabitLog> allHabitLogs,
    required List<DomainLog> allDomainLogs,
    required List<Routine> enabledRoutines,
  }) {
    final now = DateTime.now();
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    final completedDays = <int>{};

    for (int day = 1; day <= daysInMonth; day++) {
      final dayDate = DateTime(now.year, now.month, day);

      final hasHabits = allHabitLogs.any(
        (l) => _isSameDay(l.completedAt, dayDate),
      );
      final hasDomains = allDomainLogs.any(
        (l) => _isSameDay(l.loggedAt, dayDate),
      );
      final hasSleep = false;

      if (hasHabits || hasDomains || hasSleep) {
        completedDays.add(day);
      }
    }

    return completedDays;
  }

  List<NotificationItem> _generateNotifications({
    required DailyScore dailyScore,
    required SleepLog? todaySleepLog,
    required List<HabitLog> shadowLogsToday,
    required List<Habit> allHabits,
  }) {
    final notifications = <NotificationItem>[];
    final now = DateTime.now();

    if (todaySleepLog != null &&
        todaySleepLog.bedResistanceMetric != null &&
        todaySleepLog.bedResistanceMetric! > 0.5) {
      notifications.add(
        NotificationItem(
          id: 'burnout-risk-${now.millisecondsSinceEpoch}',
          title: 'Burnout risk detected',
          body: 'Sleep drift + habit deceleration over recent days.',
          timestamp: now.subtract(const Duration(hours: 5)),
          isImportant: true,
          category: NotificationCategory.system,
        ),
      );
    }

    if (shadowLogsToday.isNotEmpty) {
      final shadowHabit = _findHabit(allHabits, shadowLogsToday.first.habitId);
      notifications.add(
        NotificationItem(
          id: 'shadow-warning-${now.millisecondsSinceEpoch}',
          title: 'Shadow habit warning',
          body: shadowHabit != null
              ? '${shadowHabit.name} exceeded threshold today.'
              : 'A shadow habit was logged today.',
          timestamp: now.subtract(const Duration(days: 1)),
          isImportant: false,
          category: NotificationCategory.habit,
        ),
      );
    }

    if (dailyScore.totalScore >= 70) {
      notifications.add(
        NotificationItem(
          id: 'morning-briefing-${now.millisecondsSinceEpoch}',
          title: 'Morning briefing ready',
          body: 'Your AI Coach prepared today\'s adaptive roadmap.',
          timestamp: now.subtract(const Duration(hours: 8)),
          isImportant: false,
          category: NotificationCategory.aiCoach,
        ),
      );
    }

    if (notifications.isEmpty) {
      notifications.add(
        NotificationItem(
          id: 'system-ok-${now.millisecondsSinceEpoch}',
          title: 'System healthy',
          body: 'All systems operating normally.',
          timestamp: now,
          isImportant: false,
          category: NotificationCategory.system,
        ),
      );
    }

    return notifications;
  }
}
