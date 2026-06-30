// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shadow_habit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShadowHabitImpl _$$ShadowHabitImplFromJson(Map<String, dynamic> json) =>
    _$ShadowHabitImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      timeWasted: (json['timeWasted'] as num?)?.toInt() ?? 0,
      frequency: $enumDecode(_$ShadowFrequencyEnumMap, json['frequency']),
      loggedAt: DateTime.parse(json['loggedAt'] as String),
    );

Map<String, dynamic> _$$ShadowHabitImplToJson(_$ShadowHabitImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'timeWasted': instance.timeWasted,
      'frequency': _$ShadowFrequencyEnumMap[instance.frequency]!,
      'loggedAt': instance.loggedAt.toIso8601String(),
    };

const _$ShadowFrequencyEnumMap = {
  ShadowFrequency.daily: 'daily',
  ShadowFrequency.weekly: 'weekly',
};
