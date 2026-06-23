import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/routine_model.dart';

class RoutineRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  RoutineRepository({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  String get _userId {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');
    return user.uid;
  }

  Future<List<Routine>> getAllRoutines() async {
    final snapshot = await _firestore
        .collection('users')
        .doc(_userId)
        .collection('routines')
        .orderBy('createdAt', descending: true)
        .get();
    return snapshot.docs.map((doc) => Routine.fromFirestore(doc)).toList();
  }

  Stream<List<Routine>> watchAllRoutines() {
    return _firestore
        .collection('users')
        .doc(_userId)
        .collection('routines')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => 
            snapshot.docs.map((doc) => Routine.fromFirestore(doc)).toList());
  }

  Future<Routine> getRoutineById(String routineId) async {
    final doc = await _firestore
        .collection('users')
        .doc(_userId)
        .collection('routines')
        .doc(routineId)
        .get();
    if (!doc.exists) throw Exception('Routine not found');
    return Routine.fromFirestore(doc);
  }

  Future<String> createRoutine({
    required String title,
    required String description,
    String frequency = 'daily',
  }) async {
    final ref = _firestore
        .collection('users')
        .doc(_userId)
        .collection('routines')
        .doc();
    await ref.set({
      'title': title,
      'description': description,
      'isEnabled': true,
      'timeBlockIds': [],
      'frequency': frequency,
      'streak': 0,
      'createdAt': FieldValue.serverTimestamp(),
    });
    return ref.id;
  }

  Future<void> updateRoutine({
    required String routineId,
    required Map<String, dynamic> updates,
  }) async {
    await _firestore
        .collection('users')
        .doc(_userId)
        .collection('routines')
        .doc(routineId)
        .update({...updates, 'updatedAt': FieldValue.serverTimestamp()});
  }

  Future<void> deleteRoutine(String routineId) async {
    await _firestore
        .collection('users')
        .doc(_userId)
        .collection('routines')
        .doc(routineId)
        .delete();
  }

  Future<List<TimeBlock>> getTimeBlocks(String routineId) async {
    final snapshot = await _firestore
        .collection('users')
        .doc(_userId)
        .collection('routines')
        .doc(routineId)
        .collection('time_blocks')
        .orderBy('startTime')
        .get();
    return snapshot.docs.map((doc) => TimeBlock.fromFirestore(doc)).toList();
  }

  Stream<List<TimeBlock>> watchTimeBlocks(String routineId) {
    return _firestore
        .collection('users')
        .doc(_userId)
        .collection('routines')
        .doc(routineId)
        .collection('time_blocks')
        .orderBy('startTime')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => TimeBlock.fromFirestore(doc)).toList());
  }

  Future<String> createTimeBlock({
    required String routineId,
    required String title,
    required String domainId,
    required int startTime,
    required int endTime,
    required TimeBlockAnchor anchor,
    String? description,
  }) async {
    final ref = _firestore
        .collection('users')
        .doc(_userId)
        .collection('routines')
        .doc(routineId)
        .collection('time_blocks')
        .doc();
    await ref.set({
      'title': title,
      'domainId': domainId,
      'startTime': startTime,
      'endTime': endTime,
      'anchor': anchor.name,
      'durationMinutes': endTime - startTime,
      'description': description,
      'isCompleted': false,
      'linkedHabitIds': [],
    });
    return ref.id;
  }

  Future<void> updateTimeBlock({
    required String routineId,
    required String blockId,
    required Map<String, dynamic> updates,
  }) async {
    await _firestore
        .collection('users')
        .doc(_userId)
        .collection('routines')
        .doc(routineId)
        .collection('time_blocks')
        .doc(blockId)
        .update(updates);
  }

  Future<void> deleteTimeBlock({
    required String routineId,
    required String blockId,
  }) async {
    await _firestore
        .collection('users')
        .doc(_userId)
        .collection('routines')
        .doc(routineId)
        .collection('time_blocks')
        .doc(blockId)
        .delete();
  }

  Future<ScheduleAnchor> getUserScheduleAnchor() async {
    final doc = await _firestore
        .collection('users')
        .doc(_userId)
        .collection('settings')
        .doc('schedule_anchor')
        .get();
    if (!doc.exists) {
      return const ScheduleAnchor(
        id: 'default',
        type: 'prayer',
        prayerTimesEnabled: true,
      );
    }
    return ScheduleAnchor.fromFirestore(doc);
  }

  Future<void> updateUserScheduleAnchor({
    required bool prayerTimesEnabled,
    String? wakeTime,
    String? calculationMethod,
    double? latitude,
    double? longitude,
  }) async {
    await _firestore
        .collection('users')
        .doc(_userId)
        .collection('settings')
        .doc('schedule_anchor')
        .set({
      'type': prayerTimesEnabled ? 'prayer' : 'wake_time',
      'wakeTime': wakeTime,
      'prayerTimesEnabled': prayerTimesEnabled,
      'calculationMethod': calculationMethod,
      'latitude': latitude,
      'longitude': longitude,
    }, SetOptions(merge: true));
  }
}