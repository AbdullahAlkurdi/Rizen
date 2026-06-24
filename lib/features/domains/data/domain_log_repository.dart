import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DomainLogRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  DomainLogRepository({FirebaseFirestore? firestore, FirebaseAuth? auth})
    : _firestore = firestore ?? FirebaseFirestore.instance,
      _auth = auth ?? FirebaseAuth.instance;

  Future<void> addLog({
    required String domain,
    required int durationMinutes,
    required String metricLabel,
    required num metricValue,
    String? note,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final ref = _firestore.collection('domain_logs').doc();

    await ref.set({
      'logId': ref.id,
      'uid': user.uid,
      'domain': domain,
      'timestamp': FieldValue.serverTimestamp(),
      'durationMinutes': durationMinutes,
      'metricLabel': metricLabel,
      'metricValue': metricValue,
      'note': note,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
