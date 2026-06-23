import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'prayer_times_cache_model.freezed.dart';
part 'prayer_times_cache_model.g.dart';

// ignore_for_file: non_constant_identifier_names

@freezed
class HijriDate with _$HijriDate {
  const factory HijriDate({
    required int day,
    required int month,
    required int year,
    required String monthNameAr,
    required String monthNameEn,
  }) = _HijriDate;

  factory HijriDate.fromJson(Map<String, dynamic> json) =>
      _$HijriDateFromJson(json);
}

@freezed
class Timings with _$Timings {
  const factory Timings({
    required String Fajr,
    required String Sunrise,
    required String Dhuhr,
    required String Asr,
    required String Maghrib,
    required String Isha,
  }) = _Timings;

  factory Timings.fromJson(Map<String, dynamic> json) =>
      _$TimingsFromJson(json);
}

@freezed
class PrayerTimesCache with _$PrayerTimesCache {
  const factory PrayerTimesCache({
    required String uid,
    required double latitude,
    required double longitude,
    required String calculationMethod,
    required Timings timings,
    required HijriDate hijriDate,
    required DateTime fetchedAt,
    required String validForDate,
  }) = _PrayerTimesCache;

  factory PrayerTimesCache.fromJson(Map<String, dynamic> json) =>
      _$PrayerTimesCacheFromJson(json);

  factory PrayerTimesCache.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PrayerTimesCache(
      uid: data['uid'] as String? ?? '',
      latitude: (data['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (data['longitude'] as num?)?.toDouble() ?? 0.0,
      calculationMethod:
          data['calculationMethod'] as String? ?? 'Muslim_World_League',
      timings: Timings.fromJson(data['timings'] as Map<String, dynamic>? ?? {}),
      hijriDate: HijriDate.fromJson(
        data['hijriDate'] as Map<String, dynamic>? ?? {},
      ),
      fetchedAt: (data['fetchedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      validForDate: data['validForDate'] as String? ?? '',
    );
  }
}
