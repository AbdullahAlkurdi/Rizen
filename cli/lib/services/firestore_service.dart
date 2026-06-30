import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _uid => _auth.currentUser?.uid;

  Future<QuerySnapshot> getHabits() async {
    if (_uid == null) throw Exception('Not authenticated');
    return _db.collection('users').doc(_uid).collection('habits').get();
  }

  Future<void> checkHabit(String habitId) async {
    if (_uid == null) throw Exception('Not authenticated');
    await _db.collection('users').doc(_uid).collection('habits').doc(habitId).update({
      'lastCompleted': FieldValue.serverTimestamp(),
      'streak': FieldValue.increment(1),
    });
  }

  Future<QuerySnapshot> getTodos(String habitId) async {
    if (_uid == null) throw Exception('Not authenticated');
    return _db.collection('users').doc(_uid).collection('habits').doc(habitId).collection('todos').get();
  }

  Future<void> checkTodo(String habitId, String todoId) async {
    if (_uid == null) throw Exception('Not authenticated');
    await _db.collection('users').doc(_uid).collection('habits').doc(habitId).collection('todos').doc(todoId).update({
      'done': true,
      'completedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<QuerySnapshot> getRoutines(DateTime date) async {
    if (_uid == null) throw Exception('Not authenticated');
    final day = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    return _db.collection('users').doc(_uid).collection('routines').where('date', isEqualTo: day).get();
  }
}
