import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'workout_session_model.freezed.dart';
part 'workout_session_model.g.dart';

@freezed
class WorkoutSession with _$WorkoutSession {
  const factory WorkoutSession({
    required String id,
    required String uid,
    required String title,
    required String goal,
    required int totalEstimatedMinutes,
    DateTime? generatedAt,
    DateTime? completedAt,
    @Default('ai') String generatedBy,
    @Default([]) List<WorkoutExercise> exercises,
  }) = _WorkoutSession;

  factory WorkoutSession.fromJson(Map<String, dynamic> json) =>
      _$WorkoutSessionFromJson(json);

  factory WorkoutSession.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return WorkoutSession(
      id: doc.id,
      uid: data['uid'] as String? ?? '',
      title: data['title'] as String? ?? '',
      goal: data['goal'] as String? ?? '',
      totalEstimatedMinutes:
          (data['totalEstimatedMinutes'] as num?)?.toInt() ?? 0,
      generatedAt: (data['generatedAt'] as Timestamp?)?.toDate(),
      completedAt: (data['completedAt'] as Timestamp?)?.toDate(),
      generatedBy: data['generatedBy'] as String? ?? 'ai',
      exercises: (data['exercises'] as List<dynamic>? ?? [])
          .map((e) => WorkoutExercise.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

@freezed
class WorkoutExercise with _$WorkoutExercise {
  const factory WorkoutExercise({
    required String name,
    required String phase,
    int? sets,
    int? reps,
    int? durationSeconds,
    int? restSeconds,
  }) = _WorkoutExercise;

  factory WorkoutExercise.fromJson(Map<String, dynamic> json) =>
      _$WorkoutExerciseFromJson(json);
}
