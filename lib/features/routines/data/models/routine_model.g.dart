// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TimeBlockImpl _$$TimeBlockImplFromJson(Map<String, dynamic> json) =>
    _$TimeBlockImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      domainId: json['domainId'] as String,
      startTime: (json['startTime'] as num).toInt(),
      endTime: (json['endTime'] as num).toInt(),
      anchor: $enumDecode(_$TimeBlockAnchorEnumMap, json['anchor']),
      durationMinutes: (json['durationMinutes'] as num?)?.toInt(),
      description: json['description'] as String?,
      isCompleted: json['isCompleted'] as bool? ?? false,
      linkedHabitIds:
          (json['linkedHabitIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      hasTodoList: json['hasTodoList'] as bool? ?? false,
      completionThreshold: (json['completionThreshold'] as num?)?.toInt() ?? 70,
    );

Map<String, dynamic> _$$TimeBlockImplToJson(_$TimeBlockImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'domainId': instance.domainId,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'anchor': _$TimeBlockAnchorEnumMap[instance.anchor]!,
      'durationMinutes': instance.durationMinutes,
      'description': instance.description,
      'isCompleted': instance.isCompleted,
      'linkedHabitIds': instance.linkedHabitIds,
      'hasTodoList': instance.hasTodoList,
      'completionThreshold': instance.completionThreshold,
    };

const _$TimeBlockAnchorEnumMap = {
  TimeBlockAnchor.exact: 'exact',
  TimeBlockAnchor.prayerBefore: 'prayerBefore',
  TimeBlockAnchor.prayerAfter: 'prayerAfter',
  TimeBlockAnchor.wakeTimeAfter: 'wakeTimeAfter',
};

_$RoutineImpl _$$RoutineImplFromJson(Map<String, dynamic> json) =>
    _$RoutineImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      isEnabled: json['isEnabled'] as bool,
      timeBlockIds: (json['timeBlockIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      frequency: json['frequency'] as String? ?? 'daily',
      scheduleAnchorId: json['scheduleAnchorId'] as String?,
      nextScheduledAt: json['nextScheduledAt'] == null
          ? null
          : DateTime.parse(json['nextScheduledAt'] as String),
      streak: (json['streak'] as num?)?.toInt() ?? 0,
      lastCompletedAt: json['lastCompletedAt'] == null
          ? null
          : DateTime.parse(json['lastCompletedAt'] as String),
      hasTodoList: json['hasTodoList'] as bool? ?? false,
      completionThreshold: (json['completionThreshold'] as num?)?.toInt() ?? 70,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$RoutineImplToJson(_$RoutineImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'isEnabled': instance.isEnabled,
      'timeBlockIds': instance.timeBlockIds,
      'frequency': instance.frequency,
      'scheduleAnchorId': instance.scheduleAnchorId,
      'nextScheduledAt': instance.nextScheduledAt?.toIso8601String(),
      'streak': instance.streak,
      'lastCompletedAt': instance.lastCompletedAt?.toIso8601String(),
      'hasTodoList': instance.hasTodoList,
      'completionThreshold': instance.completionThreshold,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$ScheduleAnchorImpl _$$ScheduleAnchorImplFromJson(Map<String, dynamic> json) =>
    _$ScheduleAnchorImpl(
      id: json['id'] as String,
      type: json['type'] as String,
      wakeTime: json['wakeTime'] as String?,
      prayerTimesEnabled: json['prayerTimesEnabled'] as bool? ?? true,
      calculationMethod: json['calculationMethod'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$ScheduleAnchorImplToJson(
  _$ScheduleAnchorImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'wakeTime': instance.wakeTime,
  'prayerTimesEnabled': instance.prayerTimesEnabled,
  'calculationMethod': instance.calculationMethod,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
};
