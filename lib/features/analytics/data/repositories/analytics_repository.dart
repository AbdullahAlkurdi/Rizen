import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../habits/data/models/habit_model.dart';
import '../../../habits/data/models/habit_log_model.dart';
import '../../../notes/data/models/note_model.dart';
import '../../../todo/data/models/todo_list_model.dart';
import '../models/analytics_period.dart';
import '../models/correlation_insight.dart';
import '../models/domain_score_point.dart';
import '../models/growth_index.dart';
import '../models/habit_trend_point.dart';
import '../models/notes_analytics_summary.dart';
import '../../../notes/domain/entities/note_category.dart';

class AnalyticsRepository {
  AnalyticsRepository({
    required this.firestore,
    required this.uid,
  });

  final FirebaseFirestore firestore;
  final String uid;

  CollectionReference<Map<String, dynamic>> get _domainLogsRef =>
      firestore.collection('domain_logs');

  CollectionReference<Map<String, dynamic>> get _habitLogsRef =>
      firestore.collection('habit_logs');

  CollectionReference<Map<String, dynamic>> get _habitsRef =>
      firestore.collection('habits');

  CollectionReference<Map<String, dynamic>> get _todoListsRef =>
      firestore.collection('users').doc(uid).collection('todo_lists');

  CollectionReference<Map<String, dynamic>> get _shadowLogsRef =>
      firestore.collection('users').doc(uid).collection('shadow_logs');

  CollectionReference<Map<String, dynamic>> get _notesRef =>
      firestore.collection('notes');

  Future<NotesAnalyticsSummary> getNotesAnalytics() async {
    final now = DateTime.now();
    final thirtyDaysAgo = now.subtract(const Duration(days: 30));
    final sevenDaysAgo = now.subtract(const Duration(days: 7));

    final notesSnapshot = await _notesRef
        .where('uid', isEqualTo: uid)
        .where('loggedAt', isGreaterThanOrEqualTo: thirtyDaysAgo)
        .get();

    final notes = notesSnapshot.docs.map((doc) => Note.fromFirestore(doc)).toList();

    final totalNotes = notes.length;
    final notesThisWeek = notes.where((n) => n.loggedAt.isAfter(sevenDaysAgo)).length;

    final notesByCategory = <NoteCategory, int>{};
    for (final note in notes) {
      final cat = note.category ?? NoteCategory.custom;
      notesByCategory[cat] = (notesByCategory[cat] ?? 0) + 1;
    }

    final tagCounts = <String, int>{};
    for (final note in notes) {
      for (final tag in note.tags) {
        tagCounts[tag] = (tagCounts[tag] ?? 0) + 1;
      }
    }
    final topTags = Map.fromEntries(
        tagCounts.entries.toList()..sort((a, b) => b.value.compareTo(a.value)));

    final notesByDay = <DateTime, int>{};
    for (final note in notes) {
      final day = DateTime(note.loggedAt.year, note.loggedAt.month, note.loggedAt.day);
      notesByDay[day] = (notesByDay[day] ?? 0) + 1;
    }

    final totalLength = notes.fold<int>(0, (acc, n) => acc + n.content.length);
    final averageNoteLength = notes.isEmpty ? 0.0 : totalLength / notes.length;

    final streakDates = <DateTime>{};
    for (final note in notes) {
      final day = DateTime(note.loggedAt.year, note.loggedAt.month, note.loggedAt.day);
      streakDates.add(day);
    }

    return NotesAnalyticsSummary(
      totalNotes: totalNotes,
      notesThisWeek: notesThisWeek,
      notesByCategory: notesByCategory,
      topTags: topTags,
      notesByDay: notesByDay,
      averageNoteLength: averageNoteLength,
      streakDates: streakDates.toList()..sort(),
    );
  }

  Future<List<DomainScorePoint>> getDomainScores(AnalyticsPeriod period) async {
    final now = DateTime.now();
    final range = _periodRange(period, now);
    final start = range.$1;
    final end = range.$2;

    final snapshot = await _domainLogsRef
        .where('uid', isEqualTo: uid)
        .where('loggedAt', isGreaterThanOrEqualTo: start)
        .where('loggedAt', isLessThanOrEqualTo: end)
        .get();

    final logs = snapshot.docs
        .map((doc) => DomainLog.fromFirestore(doc))
        .toList();

    final grouped = <String, Map<DateTime, List<DomainLog>>>{};
    for (final log in logs) {
      final day = DateTime(log.loggedAt.year, log.loggedAt.month, log.loggedAt.day);
      grouped.putIfAbsent(log.domainId, () => {})[day] ??= [];
      grouped[log.domainId]![day]!.add(log);
    }

    final result = <DomainScorePoint>[];
    for (final entry in grouped.entries) {
      final dayEntries = entry.value.entries.toList()
        ..sort((a, b) => a.key.compareTo(b.key));
      for (final dayEntry in dayEntries) {
        final dayLogs = dayEntry.value;
        final totalSessions = dayLogs.length;
        final totalMinutes = dayLogs.fold<int>(0, (acc, l) => acc + l.duration);
        final avgPct = dayLogs
            .map((l) => l.completionPct)
            .reduce((a, b) => a + b) /
            dayLogs.length;
        final score = avgPct.clamp(0.0, 100.0);

        result.add(DomainScorePoint(
          domain: entry.key,
          date: dayEntry.key,
          score: score,
          totalSessions: totalSessions,
          totalMinutes: totalMinutes,
        ));
      }
    }

    result.sort((a, b) => a.date.compareTo(b.date));
    return result;
  }

  Future<List<HabitTrendPoint>> getHabitTrends(AnalyticsPeriod period) async {
    final now = DateTime.now();
    final range = _periodRange(period, now);
    final start = range.$1;
    final end = range.$2;

    final logsSnapshot = await _habitLogsRef
        .where('uid', isEqualTo: uid)
        .where('completedAt', isGreaterThanOrEqualTo: start)
        .where('completedAt', isLessThanOrEqualTo: end)
        .get();

    final habitsSnapshot = await _habitsRef
        .where('uid', isEqualTo: uid)
        .get();

    final habitMap = <String, Habit>{};
    for (final doc in habitsSnapshot.docs) {
      final habit = Habit.fromFirestore(doc);
      habitMap[habit.id] = habit;
    }

    final logs = logsSnapshot.docs
        .map((doc) => HabitLog.fromFirestore(doc))
        .toList();

    final grouped = <String, Map<DateTime, List<HabitLog>>>{};
    for (final log in logs) {
      final day = DateTime(log.completedAt.year, log.completedAt.month, log.completedAt.day);
      grouped.putIfAbsent(log.habitId, () => {})[day] ??= [];
      grouped[log.habitId]![day]!.add(log);
    }

    final result = <HabitTrendPoint>[];
    for (final entry in grouped.entries) {
      final habit = habitMap[entry.key];
      final habitName = habit?.name ?? 'Unknown';
      final streakActive = habit != null && habit.currentStreak > 0;
      final currentStreak = habit?.currentStreak ?? 0;

      final dayEntries = entry.value.entries.toList()
        ..sort((a, b) => a.key.compareTo(b.key));
      for (final dayEntry in dayEntries) {
        final dayLogs = dayEntry.value;
        final avgPct = dayLogs
            .map((l) => l.completionPct)
            .reduce((a, b) => a + b) /
            dayLogs.length;

        result.add(HabitTrendPoint(
          habitId: entry.key,
          habitName: habitName,
          date: dayEntry.key,
          completionPct: avgPct.clamp(0.0, 100.0),
          streakActive: streakActive,
          currentStreak: currentStreak,
        ));
      }
    }

    result.sort((a, b) => a.date.compareTo(b.date));
    return result;
  }

  Future<GrowthIndex> getGrowthIndex() async {
    final now = DateTime.now();
    final thirtyDaysAgo = now.subtract(const Duration(days: 30));

    final habitLogsSnapshot = await _habitLogsRef
        .where('uid', isEqualTo: uid)
        .where('completedAt', isGreaterThanOrEqualTo: thirtyDaysAgo)
        .get();

    final domainLogsSnapshot = await _domainLogsRef
        .where('uid', isEqualTo: uid)
        .where('loggedAt', isGreaterThanOrEqualTo: thirtyDaysAgo)
        .get();

    final todoSnapshot = await _todoListsRef
        .where('date', isGreaterThanOrEqualTo: _dateStr(thirtyDaysAgo))
        .get();

    final shadowSnapshot = await _shadowLogsRef
        .where('date', isGreaterThanOrEqualTo: _dateStr(thirtyDaysAgo))
        .get();

    final notesSnapshot = await _notesRef
        .where('uid', isEqualTo: uid)
        .where('loggedAt', isGreaterThanOrEqualTo: thirtyDaysAgo)
        .get();

    final habitLogs = habitLogsSnapshot.docs
        .map((doc) => HabitLog.fromFirestore(doc))
        .toList();
    final domainLogs = domainLogsSnapshot.docs
        .map((doc) => DomainLog.fromFirestore(doc))
        .toList();
    final todoLists = todoSnapshot.docs
        .map((doc) => TodoListModel.fromFirestore(doc))
        .toList();
    final shadowLogs = shadowSnapshot.docs
        .map((doc) => ShadowLog.fromJson(doc.data()))
        .toList();
    final notes = notesSnapshot.docs.map((doc) => Note.fromFirestore(doc)).toList();

    final habitScore = habitLogs.isNotEmpty
        ? habitLogs.map((l) => l.completionPct).reduce((a, b) => a + b) /
            habitLogs.length
        : 0.0;

    final domainDays = <DateTime>{};
    for (final log in domainLogs) {
      domainDays.add(DateTime(log.loggedAt.year, log.loggedAt.month, log.loggedAt.day));
    }
    final domainScore = (domainDays.length / 30) * 100;

    final todoScore = todoLists.isNotEmpty
        ? todoLists.map((t) => t.completionPct).reduce((a, b) => a + b) /
            todoLists.length
        : 0.0;

    final notesThisWeek = notes.where((n) => n.loggedAt.isAfter(now.subtract(const Duration(days: 7)))).length;
    final notesScore = min((notesThisWeek / 7) * 100, 100.0);

    final totalShadow = shadowLogs.fold<double>(0.0, (acc, l) => acc + l.shadowImpact);
    final shadowPenalty = (totalShadow / 30 * 10).clamp(0.0, 20.0);

    final overallScore = ((habitScore * 0.30) +
            (domainScore * 0.25) +
            (todoScore * 0.20) +
            (notesScore * 0.15) -
            (shadowPenalty * 0.10))
        .clamp(0.0, 100.0);

    final dailyScores = <DateTime, double>{};
    for (int i = 6; i >= 0; i--) {
      final day = DateTime(now.year, now.month, now.day - i);
      final dayStart = DateTime(day.year, day.month, day.day);
      final dayEnd = dayStart.add(const Duration(days: 1));

      final dayHabitLogs = habitLogs.where((l) =>
          l.completedAt.isAfter(dayStart) && l.completedAt.isBefore(dayEnd)).toList();
      final dayDomainLogs = domainLogs.where((l) =>
          l.loggedAt.isAfter(dayStart) && l.loggedAt.isBefore(dayEnd)).toList();
      final dayTodoLists = todoLists.where((t) =>
          _dateFromStr(t.id).isAfter(dayStart) &&
          _dateFromStr(t.id).isBefore(dayEnd)).toList();
      final dayShadows = shadowLogs.where((l) =>
          l.date.isAfter(dayStart) && l.date.isBefore(dayEnd)).toList();
      final dayNotes = notes.where((n) =>
          n.loggedAt.isAfter(dayStart) && n.loggedAt.isBefore(dayEnd)).toList();

      final hScore = dayHabitLogs.isNotEmpty
          ? dayHabitLogs.map((l) => l.completionPct).reduce((a, b) => a + b) /
              dayHabitLogs.length
          : 0.0;
      final dScore = dayDomainLogs.isNotEmpty ? 100.0 : 0.0;
      final tScore = dayTodoLists.isNotEmpty
          ? dayTodoLists.map((t) => t.completionPct).reduce((a, b) => a + b) /
              dayTodoLists.length
          : 0.0;
      final sPenalty = dayShadows.isNotEmpty
          ? dayShadows.map((s) => s.shadowImpact).reduce((a, b) => a + b) * 10
          : 0.0;
      final nScore = min(dayNotes.length / 1 * 100, 100.0);

      dailyScores[dayStart] = ((hScore * 0.30) +
              (dScore * 0.25) +
              (tScore * 0.20) +
              (nScore * 0.15) -
              (sPenalty * 0.10))
          .clamp(0.0, 100.0);
    }

    int decliningDays = 0;
    final sortedDays = dailyScores.keys.toList()..sort();
    for (int i = 1; i < sortedDays.length; i++) {
      if (dailyScores[sortedDays[i]]! < dailyScores[sortedDays[i - 1]]!) {
        decliningDays++;
      }
    }

    BurnoutRisk risk;
    if (decliningDays >= 6 || overallScore < 30) {
      risk = BurnoutRisk.critical;
    } else if (decliningDays >= 4) {
      risk = BurnoutRisk.high;
    } else if (decliningDays >= 2) {
      risk = BurnoutRisk.moderate;
    } else {
      risk = BurnoutRisk.low;
    }

    final reason = _generateBurnoutReason(decliningDays, overallScore, shadowPenalty);

    return GrowthIndex(
      overallScore: overallScore,
      habitScore: habitScore,
      domainScore: domainScore,
      todoScore: todoScore,
      notesScore: notesScore,
      shadowPenalty: shadowPenalty,
      burnoutRisk: risk,
      burnoutReason: reason,
      calculatedAt: now,
    );
  }

  Future<List<CorrelationInsight>> getCorrelationInsights() async {
    final now = DateTime.now();
    final thirtyDaysAgo = now.subtract(const Duration(days: 30));

    final domainLogsSnapshot = await _domainLogsRef
        .where('uid', isEqualTo: uid)
        .where('loggedAt', isGreaterThanOrEqualTo: thirtyDaysAgo)
        .get();

    final domainLogs = domainLogsSnapshot.docs
        .map((doc) => DomainLog.fromFirestore(doc))
        .toList();

    final domainIds = domainLogs.map((l) => l.domainId).toSet().toList();
    final pairs = <(String, String)>[];
    for (int i = 0; i < domainIds.length; i++) {
      for (int j = i + 1; j < domainIds.length; j++) {
        pairs.add((domainIds[i], domainIds[j]));
      }
    }

    final correlations = <CorrelationInsight>[];
    for (final pair in pairs) {
      final aLogs = domainLogs.where((l) => l.domainId == pair.$1).toList();
      final bLogs = domainLogs.where((l) => l.domainId == pair.$2).toList();

      final aByDay = <DateTime, double>{};
      for (final log in aLogs) {
        final day = DateTime(log.loggedAt.year, log.loggedAt.month, log.loggedAt.day);
        aByDay[day] = (aByDay[day] ?? 0) + log.completionPct;
      }

      final bByDay = <DateTime, double>{};
      for (final log in bLogs) {
        final day = DateTime(log.loggedAt.year, log.loggedAt.month, log.loggedAt.day);
        bByDay[day] = (bByDay[day] ?? 0) + log.completionPct;
      }

      final commonDays = aByDay.keys.toSet().intersection(bByDay.keys.toSet()).toList();
      if (commonDays.length < 3) continue;

      final xs = commonDays.map((d) => aByDay[d]!).toList();
      final ys = commonDays.map((d) => bByDay[d]!).toList();

      final corr = _pearsonCorrelation(xs, ys);
      if (corr.abs() > 0.3) {
        final insight = _generateInsight(pair.$1, pair.$2, corr);
        correlations.add(CorrelationInsight(
          domainA: pair.$1,
          domainB: pair.$2,
          correlationScore: corr,
          insight: insight,
          isPositive: corr > 0,
        ));
      }
    }

    correlations.sort((a, b) => b.correlationScore.abs().compareTo(a.correlationScore.abs()));
    return correlations.take(5).toList();
  }

  Future<String> exportData(String format) async {
    final now = DateTime.now();
    final ninetyDaysAgo = now.subtract(const Duration(days: 90));

    final habitLogsSnapshot = await _habitLogsRef
        .where('uid', isEqualTo: uid)
        .where('completedAt', isGreaterThanOrEqualTo: ninetyDaysAgo)
        .get();

    final domainLogsSnapshot = await _domainLogsRef
        .where('uid', isEqualTo: uid)
        .where('loggedAt', isGreaterThanOrEqualTo: ninetyDaysAgo)
        .get();

    final todoSnapshot = await _todoListsRef
        .where('date', isGreaterThanOrEqualTo: _dateStr(ninetyDaysAgo))
        .get();

    final shadowSnapshot = await _shadowLogsRef
        .where('date', isGreaterThanOrEqualTo: _dateStr(ninetyDaysAgo))
        .get();

    final habitLogs = habitLogsSnapshot.docs
        .map((doc) => HabitLog.fromFirestore(doc))
        .toList();
    final domainLogs = domainLogsSnapshot.docs
        .map((doc) => DomainLog.fromFirestore(doc))
        .toList();
    final todoLists = todoSnapshot.docs
        .map((doc) => TodoListModel.fromFirestore(doc))
        .toList();
    final shadowLogs = shadowSnapshot.docs
        .map((doc) => ShadowLog.fromJson(doc.data()))
        .toList();

    if (format == 'csv') {
      final buffer = StringBuffer();
      buffer.writeln('type,id,date,data');
      for (final log in habitLogs) {
        buffer.writeln(
            'habit_log,${log.id},${log.completedAt.toIso8601String()},${jsonEncode(log.toFirestore())}');
      }
      for (final log in domainLogs) {
        buffer.writeln(
            'domain_log,${log.id},${log.loggedAt.toIso8601String()},${jsonEncode(log.toFirestore())}');
      }
      for (final todo in todoLists) {
        buffer.writeln(
            'todo_list,${todo.id},${_dateFromStr(todo.id).toIso8601String()},${jsonEncode(todo.toFirestore())}');
      }
      for (final shadow in shadowLogs) {
        buffer.writeln(
            'shadow_log,${shadow.id},${shadow.date.toIso8601String()},${jsonEncode(shadow.toJson())}');
      }
      return buffer.toString();
    }

    final data = {
      'exportedAt': now.toIso8601String(),
      'habitLogs': habitLogs.map((l) => l.toFirestore()).toList(),
      'domainLogs': domainLogs.map((l) => l.toFirestore()).toList(),
      'todoLists': todoLists.map((t) => t.toFirestore()).toList(),
      'shadowLogs': shadowLogs.map((s) => s.toJson()).toList(),
    };
    return const JsonEncoder.withIndent('  ').convert(data);
  }

  (DateTime, DateTime) _periodRange(AnalyticsPeriod period, DateTime now) {
    switch (period) {
      case AnalyticsPeriod.week:
        final start = DateTime(now.year, now.month, now.day - 6);
        return (DateTime(start.year, start.month, start.day), now);
      case AnalyticsPeriod.month:
        final start = DateTime(now.year, now.month, now.day - 29);
        return (DateTime(start.year, start.month, start.day), now);
      case AnalyticsPeriod.quarter:
        final start = DateTime(now.year, now.month, now.day - 89);
        return (DateTime(start.year, start.month, start.day), now);
    }
  }

  String _dateStr(DateTime date) =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

  DateTime _dateFromStr(String id) {
    final parts = id.split('-');
    if (parts.length >= 3) {
      return DateTime(int.tryParse(parts[0]) ?? 2000, int.tryParse(parts[1]) ?? 1, int.tryParse(parts[2]) ?? 1);
    }
    return DateTime.now();
  }

  double _pearsonCorrelation(List<double> xs, List<double> ys) {
    final n = xs.length;
    if (n == 0) return 0.0;

    final sumX = xs.fold(0.0, (a, b) => a + b);
    final sumY = ys.fold(0.0, (a, b) => a + b);
    final sumXY = List.generate(n, (i) => xs[i] * ys[i]).fold(0.0, (a, b) => a + b);
    final sumX2 = xs.map((x) => x * x).fold(0.0, (a, b) => a + b);
    final sumY2 = ys.map((y) => y * y).fold(0.0, (a, b) => a + b);

    final numerator = n * sumXY - sumX * sumY;
    final denominator = sqrt((n * sumX2 - sumX * sumX) * (n * sumY2 - sumY * sumY));

    if (denominator == 0) return 0.0;
    return numerator / denominator;
  }

  String _generateInsight(String domainA, String domainB, double corr) {
    final pct = (corr.abs() * 100).round();
    final direction = corr > 0 ? 'stronger' : 'weaker';
    final days = corr > 0 ? 'higher' : 'lower';
    return 'On days you log activity in $domainA, your $domainB score is $pct% $direction when both are recorded ($days correlation).';
  }

  String _generateBurnoutReason(int decliningDays, double overallScore, double shadowPenalty) {
    if (overallScore < 30) {
      return 'Your overall score is critically low at ${overallScore.toStringAsFixed(0)}%.';
    }
    if (decliningDays >= 6) {
      return 'Your scores have declined 6 days in a row. Activate Recovery Mode immediately.';
    }
    if (decliningDays >= 4) {
      return 'Your scores have declined 4 days in a row. Consider activating Recovery Mode.';
    }
    if (decliningDays >= 2) {
      return 'Your habit completion dropped $decliningDays days in a row and your shadow score is rising. Consider activating Recovery Mode.';
    }
    if (shadowPenalty > 5) {
      return 'Shadow impact is elevated. Review your distraction patterns to protect your growth trajectory.';
    }
    return 'Your patterns are stable. Maintain your current routine to keep burnout risk low.';
  }
}

class DomainLog {
  DomainLog({required this.id, required this.domainId, required this.duration, required this.intensity, required this.notes, required this.loggedAt, required this.completionPct});

  final String id;
  final String domainId;
  final int duration;
  final int intensity;
  final String? notes;
  final DateTime loggedAt;
  final double completionPct;

  factory DomainLog.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return DomainLog(
      id: doc.id,
      domainId: data['domainId'] as String? ?? data['domain'] as String? ?? '',
      duration: data['duration'] as int? ?? data['durationMinutes'] as int? ?? 0,
      intensity: data['intensity'] as int? ?? 5,
      notes: data['notes'] as String? ?? data['note'] as String?,
      loggedAt: (data['loggedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      completionPct: (data['completionPct'] as num?)?.toDouble() ?? 100.0,
    );
  }

  Map<String, dynamic> toFirestore() => {
    'domainId': domainId,
    'domain': domainId,
    'duration': duration,
    'durationMinutes': duration,
    'intensity': intensity,
    'loggedAt': loggedAt,
    'notes': notes,
    'note': notes,
    'completionPct': completionPct,
  };
}

class ShadowLog {
  ShadowLog({
    required this.id,
    required this.source,
    required this.habitId,
    required this.habitName,
    required this.missedItems,
    required this.completionPct,
    required this.shadowImpact,
    required this.date,
    required this.createdAt,
  });

  final String id;
  final String source;
  final String habitId;
  final String habitName;
  final List<String> missedItems;
  final double completionPct;
  final double shadowImpact;
  final DateTime date;
  final DateTime createdAt;

  factory ShadowLog.fromJson(Map<String, dynamic> json) => ShadowLog(
    id: json['id'] as String? ?? '',
    source: json['source'] as String? ?? '',
    habitId: json['habit_id'] as String? ?? '',
    habitName: json['habit_name'] as String? ?? '',
    missedItems: List<String>.from(json['missed_items'] as List? ?? []),
    completionPct: (json['completion_pct'] as num?)?.toDouble() ?? 0.0,
    shadowImpact: (json['shadow_impact'] as num?)?.toDouble() ?? 0.0,
    date: DateTime.tryParse(json['date'] as String? ?? '') ?? DateTime.now(),
    createdAt: (json['created_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'source': source,
    'habit_id': habitId,
    'habit_name': habitName,
    'missed_items': missedItems,
    'completion_pct': completionPct,
    'shadow_impact': shadowImpact,
    'date': date.toIso8601String(),
    'created_at': createdAt,
  };
}
