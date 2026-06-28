import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_coach_summary.freezed.dart';

@freezed
class TodoCoachSummary with _$TodoCoachSummary {
  const factory TodoCoachSummary({
    @Default(0) int totalItems,
    @Default(0) int completedItems,
    @Default(0) int missedRequiredItems,
    @Default(0.0) double averageCompletionPct,
    @Default([]) List<String> chronicallyMissed,
    @Default([]) List<String> perfectHabits,
  }) = _TodoCoachSummary;
}