// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WorkoutSessionImpl _$$WorkoutSessionImplFromJson(Map<String, dynamic> json) =>
    _$WorkoutSessionImpl(
      id: json['id'] as String,
      uid: json['uid'] as String,
      title: json['title'] as String,
      goal: json['goal'] as String,
      totalEstimatedMinutes: (json['totalEstimatedMinutes'] as num).toInt(),
      generatedAt: json['generatedAt'] == null
          ? null
          : DateTime.parse(json['generatedAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      generatedBy: json['generatedBy'] as String? ?? 'ai',
      exercises:
          (json['exercises'] as List<dynamic>?)
              ?.map((e) => WorkoutExercise.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$WorkoutSessionImplToJson(
  _$WorkoutSessionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'uid': instance.uid,
  'title': instance.title,
  'goal': instance.goal,
  'totalEstimatedMinutes': instance.totalEstimatedMinutes,
  'generatedAt': instance.generatedAt?.toIso8601String(),
  'completedAt': instance.completedAt?.toIso8601String(),
  'generatedBy': instance.generatedBy,
  'exercises': instance.exercises,
};

_$WorkoutExerciseImpl _$$WorkoutExerciseImplFromJson(
  Map<String, dynamic> json,
) => _$WorkoutExerciseImpl(
  name: json['name'] as String,
  phase: json['phase'] as String,
  sets: (json['sets'] as num?)?.toInt(),
  reps: (json['reps'] as num?)?.toInt(),
  durationSeconds: (json['durationSeconds'] as num?)?.toInt(),
  restSeconds: (json['restSeconds'] as num?)?.toInt(),
);

Map<String, dynamic> _$$WorkoutExerciseImplToJson(
  _$WorkoutExerciseImpl instance,
) => <String, dynamic>{
  'name': instance.name,
  'phase': instance.phase,
  'sets': instance.sets,
  'reps': instance.reps,
  'durationSeconds': instance.durationSeconds,
  'restSeconds': instance.restSeconds,
};
