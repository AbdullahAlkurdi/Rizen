import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/sleep_log_model.dart';
import 'sleep_log_repository.dart';

class HomeRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final SleepLogRepository _sleepLogRepository;

  HomeRepository({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
    SleepLogRepository? sleepLogRepository,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance,
        _sleepLogRepository = sleepLogRepository ?? SleepLogRepository();

  String get _userId {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');
    return user.uid;
  }

  Future<DateTime?> getTargetWakeTime() async {
    final doc = await _firestore
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
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day).subtract(Duration(days: lastNDays - 1));

    final snapshot = await _firestore
        .collection('sleep_logs')
        .where('uid', isEqualTo: _userId)
        .where('sleepStart', isGreaterThanOrEqualTo: start)
        .orderBy('sleepStart', descending: true)
        .limit(lastNDays)
        .get();

    return snapshot.docs.map((doc) => SleepLog.fromFirestore(doc)).toList();
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

  Future<SleepLog?> getTodaySleepLog() {
    return _sleepLogRepository.getTodaySleepLog();
  }
}