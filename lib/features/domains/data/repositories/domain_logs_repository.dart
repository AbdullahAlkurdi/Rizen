import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/domain_log_model.dart';

class DomainLogsRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  DomainLogsRepository({FirebaseFirestore? firestore, FirebaseAuth? auth})
    : _firestore = firestore ?? FirebaseFirestore.instance,
      _auth = auth ?? FirebaseAuth.instance;

  CollectionReference<Map<String, dynamic>> get _logsRef =>
      _firestore.collection('domain_logs');

  String? get _uid => _auth.currentUser?.uid;

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

  Future<void> addLog({
    required String domainId,
    required int duration,
    String? notes,
    String? metricLabel,
    double? metricValue,
    DateTime? loggedAt,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final ref = _logsRef.doc();
    final ts = loggedAt ?? DateTime.now();

    await ref.set({
      'id': ref.id,
      'logId': ref.id,
      'uid': user.uid,
      'domainId': domainId,
      'domain': domainId,
      'duration': duration,
      'durationMinutes': duration,
      'loggedAt': Timestamp.fromDate(ts),
      'timestamp': Timestamp.fromDate(ts),
      'notes': notes,
      'note': notes,
      'metricLabel': metricLabel,
      'metricValue': metricValue,
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
