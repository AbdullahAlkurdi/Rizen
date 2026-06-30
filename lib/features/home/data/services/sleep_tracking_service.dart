import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/sleep_log_model.dart';
import '../repositories/sleep_log_repository.dart';

class SleepTrackingService {
  SleepTrackingService({
    required this.firestore,
    required this.firebaseAuth,
    required SleepLogRepository repository,
  }) : _repository = repository;

  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;
  final SleepLogRepository _repository;

  String get _userId {
    final user = firebaseAuth.currentUser;
    if (user == null) throw Exception('User not authenticated');
    return user.uid;
  }

  Future<void> recordWakeIfNeeded() async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final startOfNextDay = startOfDay.add(const Duration(days: 1));

    final existing = await firestore
        .collection('sleep_logs')
        .where('uid', isEqualTo: _userId)
        .where('sleepStart', isGreaterThanOrEqualTo: startOfDay)
        .where('sleepStart', isLessThan: startOfNextDay)
        .limit(1)
        .get();

    if (existing.docs.isNotEmpty) return;

    await firestore
        .collection('sleep_logs')
        .add({
      'uid': _userId,
      'sleepStart': Timestamp.fromDate(now),
      'sleepEnd': Timestamp.fromDate(now),
      'bedResistanceMetric': null,
      'source': 'detected',
      'isAnalysisReady': false,
      'createdAt': Timestamp.fromDate(now),
      'updatedAt': Timestamp.fromDate(now),
    });
  }

  Future<SleepLog?> computeBedResistance({
    required DateTime wakeTimestamp,
    DateTime? targetWakeTime,
  }) async {
    if (targetWakeTime == null) return null;

    final delayMinutes = wakeTimestamp.difference(targetWakeTime).inMinutes;
    double bedResistanceScore;

    if (delayMinutes <= 0) {
      bedResistanceScore = 0.0;
    } else if (delayMinutes <= 15) {
      bedResistanceScore = delayMinutes * 1.0;
    } else if (delayMinutes <= 60) {
      bedResistanceScore = 15.0 + (delayMinutes - 15) * 1.5;
    } else {
      bedResistanceScore = (82.5 + (delayMinutes - 60) * 0.5).clamp(0.0, 100.0);
    }

    await _repository.updateTodaySleepLog(
      sleepEnd: wakeTimestamp,
      bedResistanceMetric: bedResistanceScore / 100.0,
      isAnalysisReady: true,
    );

    return _repository.getTodaySleepLog();
  }

  Future<DateTime?> getTargetWakeTime() async {
    final doc = await firestore
        .collection('users')
        .doc(_userId)
        .collection('settings')
        .doc('schedule_anchor')
        .get();

    if (!doc.exists) return null;

    final data = doc.data();
    final wakeTimeStr = data?['wakeTime'] as String?;

    if (wakeTimeStr == null) return null;

    final parts = wakeTimeStr.split(':');
    if (parts.length != 2) return null;

    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) return null;

    final today = DateTime.now();
    return DateTime(today.year, today.month, today.day, hour, minute);
  }

  Future<List<SleepLog>> getSleepHistory(int lastNDays) async {
    return _repository.getSleepLogs(limit: lastNDays);
  }

  Future<double> getAverageBedResistance(int lastNDays) async {
    final logs = await getSleepHistory(lastNDays);
    final scores = logs
        .where((log) => log.bedResistanceMetric != null)
        .map((log) => log.bedResistanceMetric!)
        .toList();

    if (scores.isEmpty) return 0.0;

    final sum = scores.reduce((a, b) => a + b);
    return (sum / scores.length) * 100;
  }

  Future<SleepLog?> getTodaySleepLog() async {
    return _repository.getTodaySleepLog();
  }
}
