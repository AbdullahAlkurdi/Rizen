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
      source: $enumDecodeNullable(_$LogSourceEnumMap, json['source']),
      isAnalysisReady: json['isAnalysisReady'] as bool? ?? false,
      analysisNotes: json['analysisNotes'] as String?,
      bedtime: json['bedtime'] == null
          ? null
          : DateTime.parse(json['bedtime'] as String),
      wakeTime: json['wakeTime'] == null
          ? null
          : DateTime.parse(json['wakeTime'] as String),
      sleepMinutes: (json['sleepMinutes'] as num?)?.toInt(),
      sleepQuality: json['sleepQuality'] as String?,
      notes: json['notes'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
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
      'source': _$LogSourceEnumMap[instance.source],
      'isAnalysisReady': instance.isAnalysisReady,
      'analysisNotes': instance.analysisNotes,
      'bedtime': instance.bedtime?.toIso8601String(),
      'wakeTime': instance.wakeTime?.toIso8601String(),
      'sleepMinutes': instance.sleepMinutes,
      'sleepQuality': instance.sleepQuality,
      'notes': instance.notes,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$LogSourceEnumMap = {
  LogSource.detected: 'detected',
  LogSource.manual: 'manual',
  LogSource.corrected: 'corrected',
};
