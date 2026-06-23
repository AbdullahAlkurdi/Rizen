// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer_times_cache_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HijriDateImpl _$$HijriDateImplFromJson(Map<String, dynamic> json) =>
    _$HijriDateImpl(
      day: (json['day'] as num).toInt(),
      month: (json['month'] as num).toInt(),
      year: (json['year'] as num).toInt(),
      monthNameAr: json['monthNameAr'] as String,
      monthNameEn: json['monthNameEn'] as String,
    );

Map<String, dynamic> _$$HijriDateImplToJson(_$HijriDateImpl instance) =>
    <String, dynamic>{
      'day': instance.day,
      'month': instance.month,
      'year': instance.year,
      'monthNameAr': instance.monthNameAr,
      'monthNameEn': instance.monthNameEn,
    };

_$TimingsImpl _$$TimingsImplFromJson(Map<String, dynamic> json) =>
    _$TimingsImpl(
      Fajr: json['Fajr'] as String,
      Sunrise: json['Sunrise'] as String,
      Dhuhr: json['Dhuhr'] as String,
      Asr: json['Asr'] as String,
      Maghrib: json['Maghrib'] as String,
      Isha: json['Isha'] as String,
    );

Map<String, dynamic> _$$TimingsImplToJson(_$TimingsImpl instance) =>
    <String, dynamic>{
      'Fajr': instance.Fajr,
      'Sunrise': instance.Sunrise,
      'Dhuhr': instance.Dhuhr,
      'Asr': instance.Asr,
      'Maghrib': instance.Maghrib,
      'Isha': instance.Isha,
    };

_$PrayerTimesCacheImpl _$$PrayerTimesCacheImplFromJson(
  Map<String, dynamic> json,
) => _$PrayerTimesCacheImpl(
  uid: json['uid'] as String,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  calculationMethod: json['calculationMethod'] as String,
  timings: Timings.fromJson(json['timings'] as Map<String, dynamic>),
  hijriDate: HijriDate.fromJson(json['hijriDate'] as Map<String, dynamic>),
  fetchedAt: DateTime.parse(json['fetchedAt'] as String),
  validForDate: json['validForDate'] as String,
);

Map<String, dynamic> _$$PrayerTimesCacheImplToJson(
  _$PrayerTimesCacheImpl instance,
) => <String, dynamic>{
  'uid': instance.uid,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'calculationMethod': instance.calculationMethod,
  'timings': instance.timings,
  'hijriDate': instance.hijriDate,
  'fetchedAt': instance.fetchedAt.toIso8601String(),
  'validForDate': instance.validForDate,
};
