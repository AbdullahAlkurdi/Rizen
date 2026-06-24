import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_score_model.freezed.dart';
part 'daily_score_model.g.dart';

@freezed
class DailyScore with _$DailyScore {
  const factory DailyScore({
    @Default(0) int routineCompletionPercent,
    @Default(0) int habitAdherencePercent,
    @Default(0) int domainBalancePercent,
    @Default(0) int sleepDisciplinePercent,
    @Default(0) int shadowResistancePercent,
    @Default(0) int totalScore,
    @Default(0) int streak,
    @Default(0) int rewardPoints,
  }) = _DailyScore;

  factory DailyScore.fromJson(Map<String, dynamic> json) =>
      _$DailyScoreFromJson(json);
}

@freezed
class WeeklyScore with _$WeeklyScore {
  const factory WeeklyScore({
    required DateTime date,
    @Default(0) int score,
    @Default(0) int routineCompleted,
    @Default(0) int habitsChecked,
    @Default(0) int domainActivities,
    @Default(0) int sleepHours,
  }) = _WeeklyScore;

  factory WeeklyScore.fromJson(Map<String, dynamic> json) =>
      _$WeeklyScoreFromJson(json);
}

@freezed
class NotificationItem with _$NotificationItem {
  const factory NotificationItem({
    required String id,
    required String title,
    required String body,
    required DateTime timestamp,
    @Default(false) bool isImportant,
    @Default(NotificationCategory.system) NotificationCategory category,
  }) = _NotificationItem;

  factory NotificationItem.fromJson(Map<String, dynamic> json) =>
      _$NotificationItemFromJson(json);
}

enum NotificationCategory { system, aiCoach, spiritual, habit }

extension NotificationCategoryX on NotificationCategory {
  String get label {
    switch (this) {
      case NotificationCategory.system:
        return 'System';
      case NotificationCategory.aiCoach:
        return 'AI Coach';
      case NotificationCategory.spiritual:
        return 'Spiritual';
      case NotificationCategory.habit:
        return 'Habit';
    }
  }
}
