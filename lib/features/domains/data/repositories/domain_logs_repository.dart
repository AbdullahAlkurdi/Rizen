import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/interfaces/domain_service_interface.dart';

class DomainLogsRepository implements DomainServiceInterface {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  DomainLogsRepository({FirebaseFirestore? firestore, FirebaseAuth? auth})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  CollectionReference<Map<String, dynamic>> get _logsRef =>
      _firestore.collection('domain_logs');

  String? get _uid => _auth.currentUser?.uid;

  @override
  Future<Map<String, double>> getTodayDomainScores() async {
    final summary = await getWeeklySummary();
    return summary;
  }

  @override
  Future<List<DomainLog>> getLogsByDomain(String domainId) async {
    final uid = _uid;
    if (uid == null) throw Exception('User not authenticated');

    final snapshot = await _logsRef
        .where('uid', isEqualTo: uid)
        .where('domainId', isEqualTo: domainId)
        .orderBy('loggedAt', descending: true)
        .get();

    return snapshot.docs.map((doc) => DomainLog.fromFirestore(doc)).toList();
  }

  @override
  Future<void> addLog({
    required String domainId,
    required int duration,
    String? notes,
    int intensity = 5,
    String? metricLabel,
    double? metricValue,
    DateTime? loggedAt,
  }) async {
    await addLogAndGetId(
      domainId: domainId,
      duration: duration,
      notes: notes,
      intensity: intensity,
      metricLabel: metricLabel,
      metricValue: metricValue,
      loggedAt: loggedAt,
    );
  }

  Future<String> addLogAndGetId({
    required String domainId,
    required int duration,
    String? notes,
    int intensity = 5,
    String? metricLabel,
    double? metricValue,
    DateTime? loggedAt,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final ref = _logsRef.doc();
    final logId = ref.id;
    final ts = loggedAt ?? DateTime.now();

    await ref.set({
      'id': ref.id,
      'logId': ref.id,
      'uid': user.uid,
      'domainId': domainId,
      'domain': domainId,
      'duration': duration,
      'durationMinutes': duration,
      'intensity': intensity,
      'loggedAt': Timestamp.fromDate(ts),
      'timestamp': Timestamp.fromDate(ts),
      'notes': notes,
      'note': notes,
      'metricLabel': metricLabel,
      'metricValue': metricValue,
      'createdAt': FieldValue.serverTimestamp(),
    });
    return logId;
  }

  Future<List<DomainLog>> getLogsByDomainRange(
    String domainId,
    DateTime start,
    DateTime end,
  ) async {
    final uid = _uid;
    if (uid == null) throw Exception('User not authenticated');

    final snapshot = await _logsRef
        .where('uid', isEqualTo: uid)
        .where('domainId', isEqualTo: domainId)
        .where('loggedAt', isGreaterThanOrEqualTo: start)
        .where('loggedAt', isLessThanOrEqualTo: end)
        .orderBy('loggedAt', descending: true)
        .get();

    return snapshot.docs.map((doc) => DomainLog.fromFirestore(doc)).toList();
  }

  Future<List<DomainLog>> getTodayLogs() async {
    final uid = _uid;
    if (uid == null) throw Exception('User not authenticated');

    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    final end = start.add(const Duration(days: 1));

    final snapshot = await _logsRef
        .where('uid', isEqualTo: uid)
        .where('loggedAt', isGreaterThanOrEqualTo: start)
        .where('loggedAt', isLessThan: end)
        .get();

    return snapshot.docs.map((doc) => DomainLog.fromFirestore(doc)).toList();
  }

  Future<Map<String, double>> getWeeklySummary() async {
    final uid = _uid;
    if (uid == null) throw Exception('User not authenticated');

    final now = DateTime.now();
    final weekStart = DateTime(now.year, now.month, now.day - now.weekday + 1);
    final start = DateTime(weekStart.year, weekStart.month, weekStart.day);
    final end = start.add(const Duration(days: 7));

    final snapshot = await _logsRef
        .where('uid', isEqualTo: uid)
        .where('loggedAt', isGreaterThanOrEqualTo: start)
        .where('loggedAt', isLessThan: end)
        .get();

    final logs = snapshot.docs.map((doc) => DomainLog.fromFirestore(doc)).toList();
    final summary = <String, double>{};
    for (final log in logs) {
      summary[log.domainId] = (summary[log.domainId] ?? 0) + log.duration / 60.0;
    }
    return summary;
  }

  Future<int> getDomainStreak(String domainId) async {
    final uid = _uid;
    if (uid == null) throw Exception('User not authenticated');

    final snapshot = await _logsRef
        .where('uid', isEqualTo: uid)
        .where('domainId', isEqualTo: domainId)
        .orderBy('loggedAt', descending: true)
        .get();

    final logs = snapshot.docs.map((doc) => DomainLog.fromFirestore(doc)).toList();
    if (logs.isEmpty) return 0;

    int streak = 0;
    DateTime checkDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    for (final log in logs) {
      final logDay = DateTime(log.loggedAt.year, log.loggedAt.month, log.loggedAt.day);
      final diff = checkDate.difference(logDay).inDays;
      if (diff == 0 || (diff == 1 && checkDate != logDay)) {
        streak++;
        checkDate = logDay;
      } else if (diff > 1) {
        break;
      }
    }
    return streak;
  }

  Stream<List<DomainLog>> watchLogsByDomain(String domainId) {
    final uid = _uid;
    if (uid == null) return const Stream.empty();

    return _logsRef
        .where('uid', isEqualTo: uid)
        .where('domainId', isEqualTo: domainId)
        .orderBy('loggedAt', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => DomainLog.fromFirestore(doc)).toList(),
        );
  }

  Future<void> addLogFromModel(DomainLog log) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final ref = _logsRef.doc(log.id);
    await ref.set({
      'id': log.id,
      'logId': log.id,
      'uid': log.uid.isEmpty ? user.uid : log.uid,
      'domainId': log.domainId,
      'domain': log.domainId,
      'duration': log.duration,
      'durationMinutes': log.duration,
      'intensity': log.intensity,
      'loggedAt': Timestamp.fromDate(log.loggedAt),
      'timestamp': Timestamp.fromDate(log.loggedAt),
      'notes': log.notes,
      'note': log.notes,
      'metricLabel': log.metricLabel,
      'metricValue': log.metricValue,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateLog(DomainLog log) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final doc = await _logsRef.doc(log.id).get();
    if (!doc.exists) throw Exception('Log not found');
    final data = doc.data() as Map<String, dynamic>;
    if (data['uid'] != user.uid) throw Exception('Unauthorized');

    await _logsRef.doc(log.id).update({
      'domainId': log.domainId,
      'domain': log.domainId,
      'duration': log.duration,
      'durationMinutes': log.duration,
      'loggedAt': Timestamp.fromDate(log.loggedAt),
      'timestamp': Timestamp.fromDate(log.loggedAt),
      'notes': log.notes,
      'note': log.notes,
      'metricLabel': log.metricLabel,
      'metricValue': log.metricValue,
    });
  }

  Future<void> deleteLog(String logId) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final doc = await _logsRef.doc(logId).get();
    if (!doc.exists) return;
    final data = doc.data() as Map<String, dynamic>;
    if (data['uid'] != user.uid) return;

    await _logsRef.doc(logId).delete();
  }
}