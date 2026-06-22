// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'domain_log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DomainLogImpl _$$DomainLogImplFromJson(Map<String, dynamic> json) =>
    _$DomainLogImpl(
      id: json['id'] as String,
      domainId: json['domainId'] as String,
      duration: (json['duration'] as num).toInt(),
      notes: json['notes'] as String?,
      loggedAt: DateTime.parse(json['loggedAt'] as String),
      metricLabel: json['metricLabel'] as String?,
      metricValue: (json['metricValue'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$DomainLogImplToJson(_$DomainLogImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'domainId': instance.domainId,
      'duration': instance.duration,
      'notes': instance.notes,
      'loggedAt': instance.loggedAt.toIso8601String(),
      'metricLabel': instance.metricLabel,
      'metricValue': instance.metricValue,
    };
