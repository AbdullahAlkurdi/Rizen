import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/sleep_log_model.dart';

class SleepLogRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  SleepLogRepository({FirebaseFirestore? firestore, FirebaseAuth? auth})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  String get _userId {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');
    return user.uid;
  }

  Future<List<SleepLog>> getSleepLogs({int limit = 30}) async {
    final snapshot = await _firestore
        .collection('sleep_logs')
        .where('uid', isEqualTo: _userId)
        .orderBy('sleepStart', descending: true)
        .limit(limit)
        .get();
    return snapshot.docs.map((doc) => SleepLog.fromFirestore(doc)).toList();
  }

  Stream<List<SleepLog>> watchSleepLogs({int limit = 30}) {
    return _firestore
        .collection('sleep_logs')
        .where('uid', isEqualTo: _userId)
        .orderBy('sleepStart', descending: true)
        .limit(limit)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => SleepLog.fromFirestore(doc)).toList(),
        );
  }

  Future<SleepLog?> getTodaySleepLog() async {
    final startOfDay = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    final startOfNextDay = startOfDay.add(const Duration(days: 1));

    final snapshot = await _firestore
        .collection('sleep_logs')
        .where('uid', isEqualTo: _userId)
        .where('sleepStart', isGreaterThanOrEqualTo: startOfDay)
        .where('sleepStart', isLessThan: startOfNextDay)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) return null;
    return SleepLog.fromFirestore(snapshot.docs.first);
  }

  Future<SleepLog?> getLastSleepLog() async {
    final snapshot = await _firestore
        .collection('sleep_logs')
        .where('uid', isEqualTo: _userId)
        .orderBy('sleepStart', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) return null;
    return SleepLog.fromFirestore(snapshot.docs.first);
  }

  Stream<SleepLog> listenForWakeEvent() {
    return _firestore
        .collection('sleep_logs')
        .where('uid', isEqualTo: _userId)
        .orderBy('sleepStart', descending: true)
        .limit(1)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) {
        throw Exception('No sleep logs found');
      }
      return SleepLog.fromFirestore(snapshot.docs.first);
    });
  }

  Future<String> logBedtime(DateTime bedtime) async {
    final now = DateTime.now();
    final ref = _firestore.collection('sleep_logs').doc();
    await ref.set({
      'uid': _userId,
      'sleepStart': Timestamp.fromDate(bedtime),
      'sleepEnd': null,
      'wakeTimeTarget': null,
      'confirmed': null,
      'confirmedAt': null,
      'bedResistanceMetric': null,
      'source': 'detected',
      'isAnalysisReady': false,
      'analysisNotes': null,
      'bedtime': Timestamp.fromDate(bedtime),
      'wakeTime': null,
      'sleepMinutes': null,
      'sleepQuality': null,
      'notes': null,
      'createdAt': Timestamp.fromDate(now),
      'updatedAt': Timestamp.fromDate(now),
    });
    return ref.id;
  }

  Future<void> logWakeTime(DateTime wakeTime) async {
    final lastLog = await getLastSleepLog();
    if (lastLog == null) {
      throw Exception('No bedtime logged. Please log bedtime first.');
    }

    final bedtime = lastLog.bedtime ?? lastLog.sleepStart;
    final wakeTimeTarget = lastLog.wakeTimeTarget;

    final sleepMinutes = wakeTime.difference(bedtime).inMinutes;
    final timeToFallAsleep = wakeTimeTarget != null
        ? wakeTimeTarget.difference(wakeTime).inMinutes
        : 30;

    final rawMetric = ((timeToFallAsleep / 60) * 100).clamp(0.0, 100.0);
    final bedResistanceMetric = (rawMetric / 100).clamp(0.0, 1.0);

    final now = DateTime.now();
    await _firestore.collection('sleep_logs').doc(lastLog.id).update({
      'sleepEnd': Timestamp.fromDate(wakeTime),
      'wakeTime': Timestamp.fromDate(wakeTime),
      'sleepMinutes': sleepMinutes,
      'bedResistanceMetric': bedResistanceMetric,
      'isAnalysisReady': true,
      'updatedAt': Timestamp.fromDate(now),
    });
  }

  Future<void> confirmSleepLog({
    required String logId,
    required bool confirmed,
  }) async {
    await _firestore.collection('sleep_logs').doc(logId).update({
      'confirmed': confirmed,
      'confirmedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateSleepLog({
    required String logId,
    required Map<String, dynamic> updates,
  }) async {
    await _firestore.collection('sleep_logs').doc(logId).update(updates);
  }

  Future<void> updateTodaySleepLog({
    DateTime? sleepStart,
    DateTime? sleepEnd,
    double? bedResistanceMetric,
    bool? isAnalysisReady,
  }) async {
    final todayLog = await getTodaySleepLog();
    if (todayLog == null) return;

    final updates = <String, dynamic>{};
    if (sleepStart != null) {
      updates['sleepStart'] = Timestamp.fromDate(sleepStart);
    }
    if (sleepEnd != null) {
      updates['sleepEnd'] = Timestamp.fromDate(sleepEnd);
    }
    if (bedResistanceMetric != null) {
      updates['bedResistanceMetric'] = bedResistanceMetric;
    }
    if (isAnalysisReady != null) {
      updates['isAnalysisReady'] = isAnalysisReady;
    }
    if (updates.isEmpty) return;

    await _firestore.collection('sleep_logs').doc(todayLog.id).update(updates);
  }

  Future<void> deleteSleepLog(String logId) async {
    await _firestore.collection('sleep_logs').doc(logId).delete();
  }
}
