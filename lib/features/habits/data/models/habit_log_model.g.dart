// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HabitLogImpl _$$HabitLogImplFromJson(Map<String, dynamic> json) =>
    _$HabitLogImpl(
      id: json['id'] as String,
      uid: json['uid'] as String,
      habitId: json['habitId'] as String,
      completedAt: _dateTimeFromJson(json['completedAt']),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$$HabitLogImplToJson(_$HabitLogImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'habitId': instance.habitId,
      'completedAt': _dateTimeToJson(instance.completedAt),
      'note': instance.note,
    };
