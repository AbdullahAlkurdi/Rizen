import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/interfaces/islamic_service_interface.dart';
import '../models/prayer_times_cache_model.dart';

class PrayerTimesRepository implements IslamicServiceInterface {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final Dio _dio;

  static const _aladhanBaseUrl = 'http://api.aladhan.com/v1';
  static const _kaabaLat = 21.4225;
  static const _kaabaLng = 39.8262;

  PrayerTimesRepository({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
    Dio? dio,
  }) : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance,
        _dio = dio ?? Dio();

  String get _userId {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');
    return user.uid;
  }

  @override
  Future<PrayerStatus> getTodayPrayerStatus() async {
    try {
      final cache = await getTodayPrayerTimes(
        lat: _kaabaLat,
        lng: _kaabaLng,
      );
      return PrayerStatus(
        isAvailable: true,
        validForDate: cache.validForDate,
        timings: cache.timings,
      );
    } catch (e) {
      return PrayerStatus(
        isAvailable: false,
        validForDate: null,
        timings: null,
      );
    }
  }

  @override
  Future<QuranProgress> getQuranProgress() async {
    try {
      int pagesReadToday = 0;
      int currentStreak = 0;
      int weeklyTotal = 0;
      
      final today = DateTime.now();
      final todayStart = DateTime(today.year, today.month, today.day);
      
      final todayLogs = await _firestore
          .collection('quran_logs')
          .where('uid', isEqualTo: _userId)
          .where('loggedAt', isGreaterThanOrEqualTo: Timestamp.fromDate(todayStart))
          .get();
      
      pagesReadToday = todayLogs.docs.fold<int>(0, (total, doc) {
        final data = doc.data();
        return total + (data['pagesRead'] as int? ?? 0);
      });
      
      final weekStart = DateTime(today.year, today.month, today.day - today.weekday + 1);
      final weekLogs = await _firestore
          .collection('quran_logs')
          .where('uid', isEqualTo: _userId)
          .where('loggedAt', isGreaterThanOrEqualTo: Timestamp.fromDate(weekStart))
          .get();
      
      weeklyTotal = weekLogs.docs.fold<int>(0, (total, doc) {
        final data = doc.data();
        return total + (data['pagesRead'] as int? ?? 0);
      });
      
      return QuranProgress(
        pagesReadToday: pagesReadToday,
        currentStreak: currentStreak,
        weeklyTotal: weeklyTotal,
      );
    } catch (e) {
      return QuranProgress(
        pagesReadToday: 0,
        currentStreak: 0,
        weeklyTotal: 0,
      );
    }
  }

  @override
  Future<PrayerTimesCache> getTodayPrayerTimes({
    required double lat,
    required double lng,
    String method = '3',
  }) async {
    final today = DateTime.now();
    final todayStr =
        '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';

    try {
      final response = await _dio.get(
        '$_aladhanBaseUrl/timings/${today.millisecondsSinceEpoch ~/ 1000}',
        queryParameters: {'latitude': lat, 'longitude': lng, 'method': method},
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];
        final timingsData = data['timings'] as Map<String, dynamic>;
        final hijriData = data['date']['hijri'] as Map<String, dynamic>;

        final cache = PrayerTimesCache(
          uid: _userId,
          latitude: lat,
          longitude: lng,
          calculationMethod: method,
          timings: Timings.fromJson(timingsData),
          hijriDate: HijriDate.fromJson(hijriData),
          fetchedAt: DateTime.now(),
          validForDate: todayStr,
        );

        await _cachePrayerTimes(cache);
        return cache;
      }
    } catch (e) {
      // Fallback to cache on network error
    }

    // Try to get from cache
    final cached = await _getCachedPrayerTimes();
    if (cached != null) return cached;

    throw Exception('Unable to fetch prayer times and no cache available');
  }

  Future<PrayerTimesCache> getPrayerTimesByCity({
    required String city,
    required String country,
    String method = '3',
  }) async {
    final today = DateTime.now();
    final todayStr =
        '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';

    try {
      final response = await _dio.get(
        '$_aladhanBaseUrl/timingsByCity',
        queryParameters: {'city': city, 'country': country, 'method': method},
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];
        final timingsData = data['timings'] as Map<String, dynamic>;
        final hijriData = data['date']['hijri'] as Map<String, dynamic>;
        final lat = (data['meta']['latitude'] as num?)?.toDouble() ?? 0.0;
        final lng = (data['meta']['longitude'] as num?)?.toDouble() ?? 0.0;

        final cache = PrayerTimesCache(
          uid: _userId,
          latitude: lat,
          longitude: lng,
          calculationMethod: method,
          timings: Timings.fromJson(timingsData),
          hijriDate: HijriDate.fromJson(hijriData),
          fetchedAt: DateTime.now(),
          validForDate: todayStr,
        );

        await _cachePrayerTimes(cache);
        return cache;
      }
    } catch (e) {
      final cached = await _getCachedPrayerTimes();
      if (cached != null) return cached;
    }

    throw Exception('Unable to fetch prayer times by city');
  }

  Future<double> getQiblaBearing({
    required double lat,
    required double lng,
  }) async {
    final response = await _dio.get(
      '$_aladhanBaseUrl/qibla/{lat,lng}',
      queryParameters: {'latitude': lat, 'longitude': lng},
    );

    if (response.statusCode == 200) {
      return (response.data['data']['direction'] as num?)?.toDouble() ??
          _calculateQiblaBearing(lat, lng);
    }

    return _calculateQiblaBearing(lat, lng);
  }

  double _calculateQiblaBearing(double lat, double lng) {
    final lat1 = lat * pi / 180;
    final lng1 = lng * pi / 180;
    final lat2 = _kaabaLat * pi / 180;
    final lng2 = _kaabaLng * pi / 180;

    final y = sin(lng2 - lng1);
    final x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(lng2 - lng1);
    final bearing = atan2(y, x) * 180 / pi;

    return (bearing + 360) % 360;
  }

  Future<void> updateCalculationMethod(String method) async {
    await _firestore.collection('users').doc(_userId).update({
      'islamicSettings.calculationMethod': method,
    });
  }

  Future<void> updatePrayerNotificationSettings(
    Map<String, bool> settings,
  ) async {
    await _firestore.collection('users').doc(_userId).update({
      'islamicSettings.prayerNotifications': settings,
      'islamicSettings.showHijriOnDashboard': true,
    });
  }

  Future<void> _cachePrayerTimes(PrayerTimesCache cache) async {
    await _firestore.collection('prayer_times_cache').doc(_userId).set({
      ...cache.toJson(),
      'uid': _userId,
    }, SetOptions(merge: true));
  }

  Future<PrayerTimesCache?> _getCachedPrayerTimes() async {
    final doc = await _firestore
        .collection('prayer_times_cache')
        .doc(_userId)
        .get();
    if (!doc.exists) return null;
    final cache = PrayerTimesCache.fromFirestore(doc);
    final today = DateTime.now();
    final todayStr =
        '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';
    if (cache.validForDate != todayStr) return null;
    return cache;
  }
}
