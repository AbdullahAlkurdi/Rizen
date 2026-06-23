import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/sleep_log_model.dart';

class SleepLogRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  SleepLogRepository({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
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
        .map((snapshot) =>
            snapshot.docs.map((doc) => SleepLog.fromFirestore(doc)).toList());
  }

  Future<SleepLog?> getTodaySleepLog() async {
    final startOfDay = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
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

  Future<String> createSleepLog({
    required DateTime sleepStart,
    DateTime? sleepEnd,
    DateTime? wakeTimeTarget,
  }) async {
    final ref = _firestore.collection('sleep_logs').doc();
    await ref.set({
      'uid': _userId,
      'sleepStart': Timestamp.fromDate(sleepStart),
      'sleepEnd': sleepEnd != null ? Timestamp.fromDate(sleepEnd) : null,
      'wakeTimeTarget': wakeTimeTarget != null ? Timestamp.fromDate(wakeTimeTarget) : null,
      'source': 'detected',
      'isAnalysisReady': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
    return ref.id;
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

  Future<void> calculateBedResistanceMetric(String logId) async {
    final log = await _firestore.collection('sleep_logs').doc(logId).get();
    if (!log.exists) return;

    final data = log.data() as Map<String, dynamic>;
    final sleepEnd = (data['sleepEnd'] as Timestamp?)?.toDate();
    final wakeTimeTarget = (data['wakeTimeTarget'] as Timestamp?)?.toDate();

    if (sleepEnd != null && wakeTimeTarget != null) {
      final delayMinutes = wakeTimeTarget.difference(sleepEnd).inMinutes;
      final metric = delayMinutes > 0 ? (delayMinutes / 120).clamp(0.0, 1.0) : 0.0;
      
      await _firestore.collection('sleep_logs').doc(logId).update({
        'bedResistanceMetric': metric,
        'isAnalysisReady': true,
        'analysisNotes': metric > 0.5 
            ? 'Rizen downgraded today\'s payload to prevent cognitive fatigue.'
            : 'On track with target wake time.',
      });
    }
  }

  Future<void> updateSleepLog({
    required String logId,
    required Map<String, dynamic> updates,
  }) async {
    await _firestore.collection('sleep_logs').doc(logId).update(updates);
  }

  Future<void> deleteSleepLog(String logId) async {
    await _firestore.collection('sleep_logs').doc(logId).delete();
  }
}