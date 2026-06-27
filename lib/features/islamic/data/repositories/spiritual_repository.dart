import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:rizen/core/errors/failures.dart';

import '../models/adhkar_session.dart';
import '../models/dua_item_model.dart';
import '../models/quran_log_model.dart';

class SpiritualRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  SpiritualRepository({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  FirebaseFirestore get firestore => _firestore;
  FirebaseAuth get auth => _auth;
  String get userId => _userId;

  String get _userId {
    final user = _auth.currentUser;
    if (user == null) throw AuthFailure('User not authenticated');
    return user.uid;
  }

  Future<void> logQuranPages({required int pages}) async {
    final today = DateTime.now();

    final logsQuery = await _firestore
        .collection('quran_logs')
        .where('uid', isEqualTo: _userId)
        .where('loggedAt', isGreaterThanOrEqualTo: _startOfDay(today))
        .limit(1)
        .get();

    if (logsQuery.docs.isNotEmpty) {
      await _firestore
          .collection('quran_logs')
          .doc(logsQuery.docs.first.id)
          .update({
        'pagesRead': FieldValue.increment(pages),
      });
      return;
    }

    await _firestore.collection('quran_logs').add({
      'uid': _userId,
      'pagesRead': pages,
      'loggedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<QuranLog?> getTodayQuranLog() async {
    final today = DateTime.now();
    final logsQuery = await _firestore
        .collection('quran_logs')
        .where('uid', isEqualTo: _userId)
        .where('loggedAt', isGreaterThanOrEqualTo: _startOfDay(today))
        .limit(1)
        .get();

    if (logsQuery.docs.isEmpty) return null;
    return QuranLog.fromFirestore(logsQuery.docs.first);
  }

  Future<void> logAdhkarCompletion({
    required AdhkarSession session,
    required List<String> completedIds,
  }) async {
    final today = DateTime.now();

    final logsQuery = await _firestore
        .collection('adhkar_logs')
        .where('uid', isEqualTo: _userId)
        .where('session', isEqualTo: session.name)
        .where('loggedAt', isGreaterThanOrEqualTo: _startOfDay(today))
        .limit(1)
        .get();

    if (logsQuery.docs.isNotEmpty) {
      await _firestore
          .collection('adhkar_logs')
          .doc(logsQuery.docs.first.id)
          .update({
        'completedItemIds': FieldValue.arrayUnion(completedIds),
        'completedAt': FieldValue.serverTimestamp(),
      });
      return;
    }

    await _firestore.collection('adhkar_logs').add({
      'uid': _userId,
      'session': session.name,
      'completedItemIds': completedIds,
      'completedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<List<String>?> getTodayAdhkarLog(AdhkarSession session) async {
    final today = DateTime.now();
    final logsQuery = await _firestore
        .collection('adhkar_logs')
        .where('uid', isEqualTo: _userId)
        .where('session', isEqualTo: session.name)
        .where('loggedAt', isGreaterThanOrEqualTo: _startOfDay(today))
        .limit(1)
        .get();

    if (logsQuery.docs.isEmpty) return null;
    final data = logsQuery.docs.first.data();
    return (data['completedItemIds'] as List<dynamic>?)?.cast<String>() ?? [];
  }

  Future<List<DuaItem>> getDuaLibrary({String? occasionFilter}) async {
    final jsonString = await rootBundle.loadString('assets/data/dua_library.json');
    final Map<String, dynamic> json = jsonDecode(jsonString);
    final List<dynamic> duas = json['duas'];
    List<DuaItem> items =
        duas.map((e) => DuaItem.fromJson(e as Map<String, dynamic>)).toList();

    if (occasionFilter != null && occasionFilter.isNotEmpty) {
      items =
          items.where((d) => d.occasions.contains(occasionFilter)).toList();
    }
    return items;
  }

  Future<List<String>> getFavoriteIds() async {
    try {
      final doc = await _firestore
          .collection('dua_favorites')
          .doc(_userId)
          .get();
      if (!doc.exists) return [];
      final data = doc.data()!;
      return (data['favoriteIds'] as List<dynamic>?)?.cast<String>() ?? [];
    } catch (_) {
      return [];
    }
  }

  Future<void> toggleDuaFavorite(String duaId) async {
    final favorites = await getFavoriteIds();
    final newFavorites = favorites.contains(duaId)
        ? favorites.where((id) => id != duaId).toList()
        : [...favorites, duaId];

    await _firestore.collection('dua_favorites').doc(_userId).set({
      'favoriteIds': newFavorites,
    }, SetOptions(merge: true));
  }

  DateTime _startOfDay(DateTime day) {
    return DateTime(day.year, day.month, day.day);
  }
}
