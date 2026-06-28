import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/habit_model.dart';
import 'habits_repository.dart';
import '../../domain/repositories/shadow_tracker_repository_interface.dart';

class ShadowTrackerRepository implements ShadowTrackerRepositoryInterface {
  final HabitsRepository _habitsRepository;

  ShadowTrackerRepository({
    HabitsRepository? habitsRepository,
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _habitsRepository = habitsRepository ?? HabitsRepository(),
        _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  String get _uid {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');
    return user.uid;
  }

  CollectionReference get _shadowLogsCollection =>
      _firestore.collection('users').doc(_uid).collection('shadow_logs');

  @override
  Future<void> addShadowLog(String habitId, int minutes) async {
    await _habitsRepository.createHabitLog(habitId: habitId, note: 'Shadow');
  }

  @override
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

  @override
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

  @override
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
        frequency: habit.frequency == HabitFrequency.daily ? 'daily' : 'weekly',
        loggedAt: weekLogs.isNotEmpty
            ? weekLogs.first.completedAt
            : now,
      ));
    }

    result.sort((a, b) => b.timeWasted.compareTo(a.timeWasted));
    return result;
  }

  @override
  Future<void> addTodoMissContribution({
    required String habitId,
    required String habitName,
    required List<String> missedRequiredItems,
    required double completionPct,
    required DateTime date,
  }) async {
    final shadowImpact = (1.0 - completionPct / 100) * missedRequiredItems.length;
    final dateStr = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    
    await _shadowLogsCollection.add({
      'source': 'todo_miss',
      'habit_id': habitId,
      'habit_name': habitName,
      'missed_items': missedRequiredItems,
      'completion_pct': completionPct,
      'shadow_impact': shadowImpact,
      'date': dateStr,
      'created_at': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<double> getTotalShadowImpact() async {
    final snapshot = await _shadowLogsCollection.get();
    double total = 0.0;
    for (final doc in snapshot.docs) {
      total += (doc.data() as Map<String, dynamic>?)?['shadow_impact'] as num? ?? 0.0;
    }
    return total;
  }

  @override
  Future<(List<ShadowLog>, DocumentSnapshot?)> getShadowLogs({
    int limit = 20,
    DocumentSnapshot? startAfter,
  }) async {
    Query query = _shadowLogsCollection.orderBy('created_at', descending: true);
    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }
    query = query.limit(limit);
    
    final snapshot = await query.get();
    final logs = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return ShadowLog(
        id: doc.id,
        source: data['source'] as String? ?? '',
        habitId: data['habit_id'] as String? ?? '',
        habitName: data['habit_name'] as String? ?? '',
        missedItems: List<String>.from(data['missed_items'] as List? ?? []),
        completionPct: (data['completion_pct'] as num?)?.toDouble() ?? 0.0,
        shadowImpact: (data['shadow_impact'] as num?)?.toDouble() ?? 0.0,
        date: DateTime.tryParse(data['date'] as String? ?? '') ?? DateTime.now(),
        createdAt: (data['created_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
      );
    }).toList();
    final lastDoc = snapshot.docs.isNotEmpty ? snapshot.docs.last : null;
    return (logs, lastDoc);
  }
}
