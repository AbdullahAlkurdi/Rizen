import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'habit_log_model.freezed.dart';
part 'habit_log_model.g.dart';

// ignore_for_file: invalid_annotation_target

DateTime _dateTimeFromJson(Object? value) {
  if (value is Timestamp) return value.toDate();
  if (value is DateTime) return value;
  if (value is String) return DateTime.parse(value);
  return DateTime.now();
}

String _dateTimeToJson(DateTime value) => value.toIso8601String();

@freezed
class HabitLog with _$HabitLog {
  const HabitLog._();

  const factory HabitLog({
    required String id,
    required String uid,
    required String habitId,
    @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
    required DateTime completedAt,
    String? note,
  }) = _HabitLog;

  factory HabitLog.fromJson(Map<String, dynamic> json) =>
      _$HabitLogFromJson(json);

  factory HabitLog.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return HabitLog.fromJson({
      'id': doc.id,
      'uid': data['uid'] as String? ?? '',
      'habitId': data['habitId'] as String? ?? '',
      'completedAt': data['completedAt'],
      'note': data['note'] as String?,
    });
  }

  Map<String, dynamic> toFirestore() => {
    'uid': uid,
    'habitId': habitId,
    'completedAt': Timestamp.fromDate(completedAt),
    'note': note,
  };
}
