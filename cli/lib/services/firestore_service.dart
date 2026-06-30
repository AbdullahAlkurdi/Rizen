import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _uid => _auth.currentUser?.uid;

  Future<List<QueryDocumentSnapshot>> getTodayHabits() async {
    if (_uid == null) throw Exception('Not authenticated');
    final snapshot = await _db.collection('users').doc(_uid).collection('habits').get();
    return snapshot.docs;
  }

  Future<QueryDocumentSnapshot?> getTodayRoutine() async {
    if (_uid == null) throw Exception('Not authenticated');
    final now = DateTime.now();
    final day = '${now.year}-${now.month.toString().padLeft(2, "0")}-${now.day.toString().padLeft(2, "0")}';
    final snapshot = await _db.collection('users').doc(_uid).collection('routines').where('date', isEqualTo: day).limit(1).get();
    if (snapshot.docs.isEmpty) return null;
    return snapshot.docs.first;
  }

  Future<QueryDocumentSnapshot?> getLastSleepLog() async {
    if (_uid == null) throw Exception('Not authenticated');
    final snapshot = await _db.collection('users').doc(_uid).collection('sleep').orderBy('date', descending: true).limit(1).get();
    if (snapshot.docs.isEmpty) return null;
    return snapshot.docs.first;
  }

  Future<Map<String, dynamic>?> getGrowthIndex() async {
    if (_uid == null) throw Exception('Not authenticated');
    final snapshot = await _db.collection('users').doc(_uid).collection('analytics').doc('growth_index').get();
    if (!snapshot.exists) return null;
    return snapshot.data();
  }

  Future<void> logDomainSession(String domain, int minutes, String notes) async {
    if (_uid == null) throw Exception('Not authenticated');
    await _db.collection('users').doc(_uid).collection('domain_logs').add({
      'domain': domain,
      'minutes': minutes,
      'notes': notes,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<List<QueryDocumentSnapshot>> getTodoItems(String habitId) async {
    if (_uid == null) throw Exception('Not authenticated');
    final snapshot = await _db.collection('users').doc(_uid).collection('habits').doc(habitId).collection('todos').get();
    return snapshot.docs;
  }

  Future<Map<String, int>> getTodayDomainStats() async {
    if (_uid == null) throw Exception('Not authenticated');
    final now = DateTime.now();
    final day = '${now.year}-${now.month.toString().padLeft(2, "0")}-${now.day.toString().padLeft(2, "0")}';
    final snapshot = await _db.collection('users').doc(_uid).collection('domain_logs').where('timestamp', isGreaterThanOrEqualTo: DateTime(now.year, now.month, now.day)).get();
    final stats = <String, int>{};
    for (final doc in snapshot.docs) {
      final domain = doc.data()['domain'] ?? 'unknown';
      final minutes = doc.data()['minutes'] ?? 0;
      stats[domain] = (stats[domain] ?? 0) + minutes;
    }
    return stats;
  }

  Future<void> checkHabit(String habitId) async {
    if (_uid == null) throw Exception('Not authenticated');
    await _db.collection('users').doc(_uid).collection('habits').doc(habitId).update({
      'lastCompleted': FieldValue.serverTimestamp(),
      'streak': FieldValue.increment(1),
      'completedToday': true,
    });
  }

  Future<void> checkTodo(String habitId, String todoId) async {
    if (_uid == null) throw Exception('Not authenticated');
    await _db.collection('users').doc(_uid).collection('habits').doc(habitId).collection('todos').doc(todoId).update({
      'done': true,
      'completedAt': FieldValue.serverTimestamp(),
    });
  }
}
