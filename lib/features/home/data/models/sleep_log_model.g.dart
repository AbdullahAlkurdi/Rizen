// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sleep_log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SleepLogImpl _$$SleepLogImplFromJson(Map<String, dynamic> json) =>
    _$SleepLogImpl(
      id: json['id'] as String,
      uid: json['uid'] as String,
      sleepStart: DateTime.parse(json['sleepStart'] as String),
      sleepEnd: DateTime.parse(json['sleepEnd'] as String),
      wakeTimeTarget: json['wakeTimeTarget'] == null
          ? null
          : DateTime.parse(json['wakeTimeTarget'] as String),
      confirmed: json['confirmed'] as bool?,
      confirmedAt: json['confirmedAt'] == null
          ? null
          : DateTime.parse(json['confirmedAt'] as String),
      bedResistanceMetric: (json['bedResistanceMetric'] as num?)?.toDouble(),
      source:
          $enumDecodeNullable(_$LogSourceEnumMap, json['source']) ??
          LogSource.detected,
      isAnalysisReady: json['isAnalysisReady'] as bool? ?? false,
      analysisNotes: json['analysisNotes'] as String?,
    );

Map<String, dynamic> _$$SleepLogImplToJson(_$SleepLogImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'sleepStart': instance.sleepStart.toIso8601String(),
      'sleepEnd': instance.sleepEnd.toIso8601String(),
      'wakeTimeTarget': instance.wakeTimeTarget?.toIso8601String(),
      'confirmed': instance.confirmed,
      'confirmedAt': instance.confirmedAt?.toIso8601String(),
      'bedResistanceMetric': instance.bedResistanceMetric,
      'source': _$LogSourceEnumMap[instance.source]!,
      'isAnalysisReady': instance.isAnalysisReady,
      'analysisNotes': instance.analysisNotes,
    };

const _$LogSourceEnumMap = {
  LogSource.detected: 'detected',
  LogSource.manual: 'manual',
  LogSource.corrected: 'corrected',
};
