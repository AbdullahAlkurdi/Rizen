import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ShadowTrackerRepositoryInterface {
  Future<void> addShadowLog(String habitId, int minutes);
  Future<int> getTodayShadowScore();
  Future<List<int>> getWeeklyShadowScore();
  Future<List<ShadowHabit>> getTopShadows();
  Future<void> addTodoMissContribution({
    required String habitId,
    required String habitName,
    required List<String> missedRequiredItems,
    required double completionPct,
    required DateTime date,
  });
  Future<double> getTotalShadowImpact();
  Future<(List<ShadowLog>, DocumentSnapshot?)> getShadowLogs({
    int limit = 20,
    DocumentSnapshot? startAfter,
  });
}

class ShadowHabit {
  final String id;
  final String name;
  final String category;
  final int timeWasted;
  final String frequency;
  final DateTime loggedAt;

  ShadowHabit({
    required this.id,
    required this.name,
    required this.category,
    required this.timeWasted,
    required this.frequency,
    required this.loggedAt,
  });
}

class ShadowLog {
  final String id;
  final String source;
  final String habitId;
  final String habitName;
  final List<String> missedItems;
  final double completionPct;
  final double shadowImpact;
  final DateTime date;
  final DateTime createdAt;

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
}
