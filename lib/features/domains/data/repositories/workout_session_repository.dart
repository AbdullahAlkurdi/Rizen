import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/workout_session_model.dart';

class WorkoutSessionRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  WorkoutSessionRepository({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  String get _userId {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');
    return user.uid;
  }

  Future<List<WorkoutSession>> getUserWorkouts() async {
    final snapshot = await _firestore
        .collection('workout_sessions')
        .where('uid', isEqualTo: _userId)
        .orderBy('generatedAt', descending: true)
        .get();
    return snapshot.docs.map((doc) => WorkoutSession.fromFirestore(doc)).toList();
  }

  Stream<List<WorkoutSession>> watchUserWorkouts() {
    return _firestore
        .collection('workout_sessions')
        .where('uid', isEqualTo: _userId)
        .orderBy('generatedAt', descending: true)
        .snapshots()
        .map((snapshot) => 
            snapshot.docs.map((doc) => WorkoutSession.fromFirestore(doc)).toList());
  }

  Future<String> createWorkout({
    required String title,
    required String goal,
    required int durationMinutes,
    required List<WorkoutExercise> exercises,
    String generatedBy = 'ai',
  }) async {
    final ref = _firestore.collection('workout_sessions').doc();
    await ref.set({
      'uid': _userId,
      'title': title,
      'goal': goal,
      'totalEstimatedMinutes': durationMinutes,
      'generatedAt': FieldValue.serverTimestamp(),
      'generatedBy': generatedBy,
      'exercises': exercises.map((e) => e.toJson()).toList(),
    });
    return ref.id;
  }

  Future<void> completeWorkout(String sessionId) async {
    await _firestore.collection('workout_sessions').doc(sessionId).update({
      'completedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteWorkout(String sessionId) async {
    await _firestore.collection('workout_sessions').doc(sessionId).delete();
  }
}