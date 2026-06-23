// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HabitImpl _$$HabitImplFromJson(Map<String, dynamic> json) => _$HabitImpl(
  id: json['id'] as String,
  uid: json['uid'] as String,
  name: json['name'] as String,
  type: $enumDecode(_$HabitTypeEnumMap, json['type']),
  frequency: $enumDecode(_$HabitFrequencyEnumMap, json['frequency']),
  targetCount: (json['targetCount'] as num).toInt(),
  currentStreak: (json['currentStreak'] as num).toInt(),
  longestStreak: (json['longestStreak'] as num).toInt(),
  isActive: json['isActive'] as bool,
  createdAt: _dateTimeFromJson(json['createdAt']),
);

Map<String, dynamic> _$$HabitImplToJson(_$HabitImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'name': instance.name,
      'type': _$HabitTypeEnumMap[instance.type]!,
      'frequency': _$HabitFrequencyEnumMap[instance.frequency]!,
      'targetCount': instance.targetCount,
      'currentStreak': instance.currentStreak,
      'longestStreak': instance.longestStreak,
      'isActive': instance.isActive,
      'createdAt': _dateTimeToJson(instance.createdAt),
    };

const _$HabitTypeEnumMap = {
  HabitType.positive: 'positive',
  HabitType.shadow: 'shadow',
};

const _$HabitFrequencyEnumMap = {
  HabitFrequency.daily: 'daily',
  HabitFrequency.weekly: 'weekly',
};
