import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/habit_log_model.dart';
import '../models/habit_model.dart';

class HabitsRepository {
  HabitsRepository({FirebaseFirestore? firestore, FirebaseAuth? auth})
    : _firestore = firestore ?? FirebaseFirestore.instance,
      _auth = auth ?? FirebaseAuth.instance;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  CollectionReference get _habitsCollection => _firestore.collection('habits');
  CollectionReference get _logsCollection =>
      _firestore.collection('habit_logs');

  String get _uid {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');
    return user.uid;
  }

  Future<Habit?> getHabit(String habitId) async {
    final uid = _uid;
    final doc = await _habitsCollection.doc(habitId).get();
    if (!doc.exists) return null;

    final habit = Habit.fromFirestore(doc);
    if (habit.uid != uid) throw Exception('Unauthorized');
    return habit;
  }

  Future<List<Habit>> getAllHabits() async {
    final uid = _uid;
    final snapshot = await _habitsCollection
        .where('uid', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs.map(Habit.fromFirestore).toList();
  }

  Future<Habit> createHabit({
    required String name,
    required HabitType type,
    required HabitFrequency frequency,
    int targetCount = 1,
  }) async {
    final uid = _uid;
    final ref = _habitsCollection.doc();
    final habit = Habit(
      id: ref.id,
      uid: uid,
      name: name,
      type: type,
      frequency: frequency,
      targetCount: targetCount,
      currentStreak: 0,
      longestStreak: 0,
      isActive: true,
      createdAt: DateTime.now(),
    );

    await ref.set({
      ...habit.toFirestore(),
      'createdAt': FieldValue.serverTimestamp(),
    });
    return habit;
  }

  Future<void> updateHabit(Habit habit) async {
    final uid = _uid;
    final existing = await getHabit(habit.id);
    if (existing == null) throw Exception('Habit not found');
    if (existing.uid != uid || habit.uid != uid) {
      throw Exception('Unauthorized');
    }

    await _habitsCollection.doc(habit.id).update(habit.toFirestore());
  }

  Future<void> deleteHabit(String habitId) async {
    final habit = await getHabit(habitId);
    if (habit == null) return;

    final logs = await getLogsForHabit(habitId);
    final batch = _firestore.batch();
    for (final log in logs) {
      batch.delete(_logsCollection.doc(log.id));
    }
    batch.delete(_habitsCollection.doc(habitId));
    await batch.commit();
  }

  Future<HabitLog?> getHabitLog(String logId) async {
    final uid = _uid;
    final doc = await _logsCollection.doc(logId).get();
    if (!doc.exists) return null;

    final log = HabitLog.fromFirestore(doc);
    if (log.uid != uid) throw Exception('Unauthorized');
    return log;
  }

  Future<List<HabitLog>> getLogsForHabit(String habitId) async {
    final uid = _uid;
    final snapshot = await _logsCollection
        .where('uid', isEqualTo: uid)
        .where('habitId', isEqualTo: habitId)
        .orderBy('completedAt', descending: true)
        .get();

    return snapshot.docs.map(HabitLog.fromFirestore).toList();
  }

  Future<List<HabitLog>> getAllHabitLogs() async {
    final uid = _uid;
    final snapshot = await _logsCollection
        .where('uid', isEqualTo: uid)
        .orderBy('completedAt', descending: true)
        .get();

    return snapshot.docs.map(HabitLog.fromFirestore).toList();
  }

  Future<HabitLog> createHabitLog({
    required String habitId,
    DateTime? completedAt,
    String? note,
  }) async {
    final uid = _uid;
    final habit = await getHabit(habitId);
    if (habit == null) throw Exception('Habit not found');

    final ref = _logsCollection.doc();
    final log = HabitLog(
      id: ref.id,
      uid: uid,
      habitId: habitId,
      completedAt: completedAt ?? DateTime.now(),
      note: note,
    );

    await ref.set({
      ...log.toFirestore(),
      'completedAt': FieldValue.serverTimestamp(),
    });
    await _recalculateStreak(habitId);
    return log;
  }

  Future<void> updateHabitLog(HabitLog log) async {
    final uid = _uid;
    final existing = await getHabitLog(log.id);
    if (existing == null) throw Exception('Habit log not found');
    if (existing.uid != uid || log.uid != uid) throw Exception('Unauthorized');

    await _logsCollection.doc(log.id).update(log.toFirestore());
    await _recalculateStreak(log.habitId);
  }

  Future<void> deleteHabitLog(String logId) async {
    final log = await getHabitLog(logId);
    if (log == null) return;

    await _logsCollection.doc(logId).delete();
    await _recalculateStreak(log.habitId);
  }

  Future<void> _recalculateStreak(String habitId) async {
    final habit = await getHabit(habitId);
    if (habit == null) return;

    final logs = await getLogsForHabit(habitId);
    final completedDays = logs
        .map(
          (log) => DateTime(
            log.completedAt.year,
            log.completedAt.month,
            log.completedAt.day,
          ),
        )
        .toSet();

    var current = 0;
    var cursor = DateTime.now();
    while (completedDays.contains(
      DateTime(cursor.year, cursor.month, cursor.day),
    )) {
      current += 1;
      cursor = cursor.subtract(const Duration(days: 1));
    }

    var longest = 0;
    var running = 0;
    final sorted = completedDays.toList()..sort();
    DateTime? previous;
    for (final day in sorted) {
      if (previous == null || day.difference(previous).inDays == 1) {
        running += 1;
      } else {
        running = 1;
      }
      if (running > longest) longest = running;
      previous = day;
    }

    await _habitsCollection.doc(habitId).update({
      'currentStreak': current,
      'longestStreak': longest,
    });
  }
}
