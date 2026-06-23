import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'habit_model.freezed.dart';
part 'habit_model.g.dart';

// ignore_for_file: invalid_annotation_target

enum HabitType { positive, shadow }

enum HabitFrequency { daily, weekly }

DateTime _dateTimeFromJson(Object? value) {
  if (value is Timestamp) return value.toDate();
  if (value is DateTime) return value;
  if (value is String) return DateTime.parse(value);
  return DateTime.now();
}

String _dateTimeToJson(DateTime value) => value.toIso8601String();

@freezed
class Habit with _$Habit {
  const Habit._();

  const factory Habit({
    required String id,
    required String uid,
    required String name,
    required HabitType type,
    required HabitFrequency frequency,
    required int targetCount,
    required int currentStreak,
    required int longestStreak,
    required bool isActive,
    @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
    required DateTime createdAt,
  }) = _Habit;

  factory Habit.fromJson(Map<String, dynamic> json) => _$HabitFromJson(json);

  factory Habit.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Habit.fromJson({
      'id': doc.id,
      'uid': data['uid'] as String? ?? '',
      'name': data['name'] as String? ?? '',
      'type': data['type'] as String? ?? HabitType.positive.name,
      'frequency': data['frequency'] as String? ?? HabitFrequency.daily.name,
      'targetCount': data['targetCount'] as int? ?? 1,
      'currentStreak': data['currentStreak'] as int? ?? 0,
      'longestStreak': data['longestStreak'] as int? ?? 0,
      'isActive': data['isActive'] as bool? ?? true,
      'createdAt': data['createdAt'],
    });
  }

  Map<String, dynamic> toFirestore() => {
    'uid': uid,
    'name': name,
    'type': type.name,
    'frequency': frequency.name,
    'targetCount': targetCount,
    'currentStreak': currentStreak,
    'longestStreak': longestStreak,
    'isActive': isActive,
    'createdAt': Timestamp.fromDate(createdAt),
  };
}
