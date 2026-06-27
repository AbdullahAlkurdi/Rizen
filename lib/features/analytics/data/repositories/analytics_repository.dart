import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../habits/data/models/habit_log_model.dart';
import '../../../habits/data/models/habit_model.dart';
import '../../../habits/data/repositories/habits_repository.dart';
import '../../../finance/data/models/transaction_model.dart';
import '../../../finance/data/repositories/finance_repository.dart';
import '../../../domains/data/models/domain_log_model.dart';
import '../../../domains/data/repositories/domain_logs_repository.dart';
import '../../../domains/data/domain_catalog.dart';
import '../../../islamic/data/models/quran_log_model.dart';
import '../../../home/data/models/daily_score_model.dart';
import '../models/analytics_summary.dart';

class AnalyticsRepository {
  final HabitsRepository habitsRepository;
  final FinanceRepository financeRepository;
  final DomainLogsRepository domainLogsRepository;
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  AnalyticsRepository({
    required this.habitsRepository,
    required this.financeRepository,
    required this.domainLogsRepository,
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : firestore = firestore ?? FirebaseFirestore.instance,
        auth = auth ?? FirebaseAuth.instance;

  String get _uid => auth.currentUser?.uid ?? '';

  Future<AnalyticsSummary> getWeeklySummary() async {
    final now = DateTime.now();
    final weekStart = DateTime(now.year, now.month, now.day - now.weekday + 1);
    final startOfWeek = DateTime(weekStart.year, weekStart.month, weekStart.day);

    final allHabits = await habitsRepository.getAllHabits();
    final activeHabits = allHabits.where((h) => h.isActive).toList();
    final positiveHabits = activeHabits
        .where((h) => h.type == HabitType.positive)
        .toList();

    final allHabitLogs = await habitsRepository.getAllHabitLogs();
    final weekHabitLogs = allHabitLogs
        .where((l) => l.completedAt.isAfter(startOfWeek) ||
            l.completedAt.isAtSameMomentAs(startOfWeek))
        .toList();

    final positiveWeekLogs = weekHabitLogs.where((l) {
      final habit = _findHabit(allHabits, l.habitId);
      return habit != null && habit.type == HabitType.positive;
    }).toList();

    final habitCompletionRate = positiveHabits.isNotEmpty
        ? positiveWeekLogs.length / positiveHabits.length
        : 0.0;

    final transactions = await financeRepository.getTransactions();
    final weekTransactions = transactions.where((t) {
      final logged = t.loggedAt;
      return logged.isAfter(startOfWeek) ||
          logged.isAtSameMomentAs(startOfWeek);
    }).toList();

    final totalFinanceSpent = weekTransactions
        .where((t) => t.type == TransactionType.expense)
        .fold<double>(0, (total, t) => total + t.amount);

    final domainHoursThisWeek = <String, double>{};
    for (final domain in DomainCatalog.all) {
      final logs = await domainLogsRepository.getLogsByDomain(domain.routeId);
      final weekDomainLogs = logs.where((l) {
        return l.loggedAt.isAfter(startOfWeek) ||
            l.loggedAt.isAtSameMomentAs(startOfWeek);
      }).toList();
      final hours = weekDomainLogs.fold<double>(
        0,
        (total, l) => total + (l.duration / 60.0),
      );
      domainHoursThisWeek[domain.routeId] = hours;
    }

    final quranLogs = await _getWeekQuranLogs(startOfWeek);
    final quranPagesThisWeek =
        quranLogs.fold<int>(0, (total, l) => total + l.pagesRead);

    final streakDays = _calculateStreakDays(allHabits, allHabitLogs, positiveHabits);

    final weeklyScore = _calculateWeeklyScore(
      habitCompletionRate: habitCompletionRate,
      totalFinanceSpent: totalFinanceSpent,
      domainHoursThisWeek: domainHoursThisWeek,
      quranPagesThisWeek: quranPagesThisWeek,
      streakDays: streakDays,
    );

    return AnalyticsSummary(
      weeklyScore: weeklyScore,
      habitCompletionRate: habitCompletionRate,
      totalFinanceSpent: totalFinanceSpent,
      domainHoursThisWeek: domainHoursThisWeek,
      quranPagesThisWeek: quranPagesThisWeek,
      streakDays: streakDays,
    );
  }

  Future<List<DailyScore>> getTrendData() async {
    final now = DateTime.now();
    final results = <DailyScore>[];

    final allHabits = await habitsRepository.getAllHabits();
    final activeHabits = allHabits.where((h) => h.isActive).toList();
    final positiveHabits = activeHabits
        .where((h) => h.type == HabitType.positive)
        .toList();

    final allHabitLogs = await habitsRepository.getAllHabitLogs();
    final allDomainLogs = await _fetchAllDomainLogs();

    for (int i = 29; i >= 0; i--) {
      final date = DateTime(now.year, now.month, now.day - i);
      final dayStart = DateTime(date.year, date.month, date.day);
      final dayEnd = DateTime(date.year, date.month, date.day, 23, 59, 59);

      final dayHabitLogs = allHabitLogs.where((l) {
        return l.completedAt.isAfter(dayStart) &&
            l.completedAt.isBefore(dayEnd);
      }).toList();

      final positiveLogs = dayHabitLogs.where((l) {
        final habit = _findHabit(allHabits, l.habitId);
        return habit != null && habit.type == HabitType.positive;
      }).toList();

      final shadowLogs = dayHabitLogs.where((l) {
        final habit = _findHabit(allHabits, l.habitId);
        return habit != null && habit.type == HabitType.shadow;
      }).toList();

      final shadowHabits = activeHabits
          .where((h) => h.type == HabitType.shadow)
          .toList();

      final habitAdherence = positiveHabits.isNotEmpty
          ? (positiveLogs.length / positiveHabits.length * 100).round()
          : 0;

      final domainLogsToday = allDomainLogs.where((l) {
        return l.loggedAt.isAfter(dayStart) &&
            l.loggedAt.isBefore(dayEnd);
      }).toList();

      final domainBalance = DomainCatalog.all.isNotEmpty
          ? (domainLogsToday.length / DomainCatalog.all.length * 100).round()
          : 0;

      double shadowResistance = 100;
      if (shadowHabits.isNotEmpty) {
        final shadowPercent =
            shadowLogs.length / shadowHabits.length * 100;
        shadowResistance = (100 - shadowPercent).clamp(0.0, 100.0);
      }

      final totalScore =
          ((habitAdherence + domainBalance + shadowResistance) / 3).round();

      results.add(DailyScore(
        routineCompletionPercent: 0,
        habitAdherencePercent: habitAdherence,
        domainBalancePercent: domainBalance,
        sleepDisciplinePercent: 0,
        shadowResistancePercent: shadowResistance.round(),
        totalScore: totalScore,
        streak: 0,
        rewardPoints: dayHabitLogs.length * 10,
      ));
    }

    return results;
  }

  Habit? _findHabit(List<Habit> habits, String habitId) {
    for (final h in habits) {
      if (h.id == habitId) return h;
    }
    return null;
  }

  int _calculateStreakDays(
    List<Habit> allHabits,
    List<HabitLog> allHabitLogs,
    List<Habit> positiveHabits,
  ) {
    if (positiveHabits.isEmpty) return 0;

    final now = DateTime.now();
    int streak = 0;
    DateTime checkDate = DateTime(now.year, now.month, now.day);

    while (true) {
      final dayStart = DateTime(checkDate.year, checkDate.month, checkDate.day);
      final dayEnd = DateTime(checkDate.year, checkDate.month, checkDate.day, 23, 59, 59);

      final dayLogs = allHabitLogs.where((l) {
        return l.completedAt.isAfter(dayStart) &&
            l.completedAt.isBefore(dayEnd);
      }).toList();

      final positiveDayLogs = dayLogs.where((l) {
        final habit = _findHabit(allHabits, l.habitId);
        return habit != null && habit.type == HabitType.positive;
      }).toList();

      if (positiveDayLogs.length >= positiveHabits.length) {
        streak++;
        checkDate = checkDate.subtract(const Duration(days: 1));
      } else {
        break;
      }
    }

    return streak;
  }

  double _calculateWeeklyScore({
    required double habitCompletionRate,
    required double totalFinanceSpent,
    required Map<String, double> domainHoursThisWeek,
    required int quranPagesThisWeek,
    required int streakDays,
  }) {
    final habitScore = (habitCompletionRate * 100).clamp(0.0, 100.0);
    final financeScore = totalFinanceSpent > 0 ? 50.0 : 80.0;
    final domainScore = domainHoursThisWeek.values.isNotEmpty
        ? (domainHoursThisWeek.values.reduce((a, b) => a + b) /
                domainHoursThisWeek.length /
                10.0)
            .clamp(0.0, 100.0)
        : 0.0;
    final spiritualScore = (quranPagesThisWeek / 70.0 * 100).clamp(0.0, 100.0);
    final streakScore =
        (streakDays >= 7 ? 100.0 : streakDays / 7.0 * 100).clamp(0.0, 100.0);

    return (habitScore + financeScore + domainScore + spiritualScore + streakScore) / 5;
  }

  Future<List<QuranLog>> _getWeekQuranLogs(DateTime startOfWeek) async {
    final uid = _uid;
    if (uid.isEmpty) return [];

    final snapshot = await firestore
        .collection('quran_logs')
        .where('uid', isEqualTo: uid)
        .where('loggedAt', isGreaterThanOrEqualTo: startOfWeek)
        .get();

    return snapshot.docs.map((doc) => QuranLog.fromFirestore(doc)).toList();
  }

  Future<List<DomainLog>> _fetchAllDomainLogs() async {
    final uid = _uid;
    if (uid.isEmpty) return [];

    final snapshot = await firestore
        .collection('domain_logs')
        .where('uid', isEqualTo: uid)
        .get();

    return snapshot.docs.map((doc) => DomainLog.fromFirestore(doc)).toList();
  }
}
