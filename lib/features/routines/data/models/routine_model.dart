import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'routine_model.freezed.dart';
part 'routine_model.g.dart';

@freezed
class TimeBlock with _$TimeBlock {
  const factory TimeBlock({
    required String id,
    required String title,
    required String domainId,
    required int startTime,
    required int endTime,
    required TimeBlockAnchor anchor,
    int? durationMinutes,
    String? description,
    @Default(false) bool isCompleted,
    @Default([]) List<String> linkedHabitIds,
  }) = _TimeBlock;

  factory TimeBlock.fromJson(Map<String, dynamic> json) =>
      _$TimeBlockFromJson(json);

  factory TimeBlock.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TimeBlock.fromJson({
      'id': doc.id,
      'title': data['title'] as String? ?? '',
      'domainId': data['domainId'] as String? ?? '',
      'startTime': (data['startTime'] as num?)?.toInt() ?? 0,
      'endTime': (data['endTime'] as num?)?.toInt() ?? 0,
      'anchor': TimeBlockAnchor.values.firstWhere(
        (e) => e.name == (data['anchor'] as String? ?? 'exact'),
        orElse: () => TimeBlockAnchor.exact,
      ),
      'durationMinutes': (data['durationMinutes'] as num?)?.toInt(),
      'description': data['description'] as String?,
      'isCompleted': data['isCompleted'] as bool? ?? false,
      'linkedHabitIds':
          (data['linkedHabitIds'] as List<dynamic>?)?.cast<String>() ?? [],
    });
  }
}

enum TimeBlockAnchor { exact, prayerBefore, prayerAfter, wakeTimeAfter }

extension TimeBlockAnchorX on TimeBlockAnchor {
  String get label {
    switch (this) {
      case TimeBlockAnchor.exact:
        return 'Exact Time';
      case TimeBlockAnchor.prayerBefore:
        return 'Before Prayer';
      case TimeBlockAnchor.prayerAfter:
        return 'After Prayer';
      case TimeBlockAnchor.wakeTimeAfter:
        return 'After Wake Time';
    }
  }
}

@freezed
class Routine with _$Routine {
  const factory Routine({
    required String id,
    required String title,
    required String description,
    required bool isEnabled,
    required List<String> timeBlockIds,
    @Default('daily') String frequency,
    String? scheduleAnchorId,
    DateTime? nextScheduledAt,
    @Default(0) int streak,
    DateTime? lastCompletedAt,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _Routine;

  factory Routine.fromJson(Map<String, dynamic> json) =>
      _$RoutineFromJson(json);

  factory Routine.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Routine.fromJson({
      'id': doc.id,
      'title': data['title'] as String? ?? '',
      'description': data['description'] as String? ?? '',
      'isEnabled': data['isEnabled'] as bool? ?? true,
      'timeBlockIds':
          (data['timeBlockIds'] as List<dynamic>?)?.cast<String>() ?? [],
      'frequency': data['frequency'] as String? ?? 'daily',
      'scheduleAnchorId': data['scheduleAnchorId'] as String?,
      'nextScheduledAt': (data['nextScheduledAt'] as Timestamp?)?.toDate(),
      'streak': (data['streak'] as num?)?.toInt() ?? 0,
      'lastCompletedAt': (data['lastCompletedAt'] as Timestamp?)?.toDate(),
      'createdAt':
          (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      'updatedAt': (data['updatedAt'] as Timestamp?)?.toDate(),
    });
  }
}

@freezed
class ScheduleAnchor with _$ScheduleAnchor {
  const factory ScheduleAnchor({
    required String id,
    required String type,
    String? wakeTime,
    @Default(true) bool prayerTimesEnabled,
    String? calculationMethod,
    double? latitude,
    double? longitude,
  }) = _ScheduleAnchor;

  factory ScheduleAnchor.fromJson(Map<String, dynamic> json) =>
      _$ScheduleAnchorFromJson(json);

  factory ScheduleAnchor.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ScheduleAnchor.fromJson({
      'id': doc.id,
      'type': data['type'] as String? ?? 'prayer',
      'wakeTime': data['wakeTime'] as String?,
      'prayerTimesEnabled': data['prayerTimesEnabled'] as bool? ?? true,
      'calculationMethod': data['calculationMethod'] as String?,
      'latitude': (data['latitude'] as num?)?.toDouble(),
      'longitude': (data['longitude'] as num?)?.toDouble(),
    });
  }
}
