// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'domain_log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DomainLogImpl _$$DomainLogImplFromJson(Map<String, dynamic> json) =>
    _$DomainLogImpl(
      id: json['id'] as String,
      uid: json['uid'] as String,
      domainId: json['domainId'] as String,
      duration: (json['duration'] as num).toInt(),
      intensity: (json['intensity'] as num?)?.toInt() ?? 5,
      notes: json['notes'] as String?,
      loggedAt: DateTime.parse(json['loggedAt'] as String),
      metricLabel: json['metricLabel'] as String?,
      metricValue: (json['metricValue'] as num?)?.toDouble(),
      hasTodoList: json['hasTodoList'] as bool? ?? false,
      completionThreshold: (json['completionThreshold'] as num?)?.toInt() ?? 70,
      completionPct: (json['completionPct'] as num?)?.toDouble() ?? 100.0,
    );

Map<String, dynamic> _$$DomainLogImplToJson(_$DomainLogImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'domainId': instance.domainId,
      'duration': instance.duration,
      'intensity': instance.intensity,
      'notes': instance.notes,
      'loggedAt': instance.loggedAt.toIso8601String(),
      'metricLabel': instance.metricLabel,
      'metricValue': instance.metricValue,
      'hasTodoList': instance.hasTodoList,
      'completionThreshold': instance.completionThreshold,
      'completionPct': instance.completionPct,
    };
