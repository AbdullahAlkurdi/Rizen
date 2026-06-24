// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_score_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DailyScoreImpl _$$DailyScoreImplFromJson(
  Map<String, dynamic> json,
) => _$DailyScoreImpl(
  routineCompletionPercent:
      (json['routineCompletionPercent'] as num?)?.toInt() ?? 0,
  habitAdherencePercent: (json['habitAdherencePercent'] as num?)?.toInt() ?? 0,
  domainBalancePercent: (json['domainBalancePercent'] as num?)?.toInt() ?? 0,
  sleepDisciplinePercent:
      (json['sleepDisciplinePercent'] as num?)?.toInt() ?? 0,
  shadowResistancePercent:
      (json['shadowResistancePercent'] as num?)?.toInt() ?? 0,
  totalScore: (json['totalScore'] as num?)?.toInt() ?? 0,
  streak: (json['streak'] as num?)?.toInt() ?? 0,
  rewardPoints: (json['rewardPoints'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$DailyScoreImplToJson(_$DailyScoreImpl instance) =>
    <String, dynamic>{
      'routineCompletionPercent': instance.routineCompletionPercent,
      'habitAdherencePercent': instance.habitAdherencePercent,
      'domainBalancePercent': instance.domainBalancePercent,
      'sleepDisciplinePercent': instance.sleepDisciplinePercent,
      'shadowResistancePercent': instance.shadowResistancePercent,
      'totalScore': instance.totalScore,
      'streak': instance.streak,
      'rewardPoints': instance.rewardPoints,
    };

_$WeeklyScoreImpl _$$WeeklyScoreImplFromJson(Map<String, dynamic> json) =>
    _$WeeklyScoreImpl(
      date: DateTime.parse(json['date'] as String),
      score: (json['score'] as num?)?.toInt() ?? 0,
      routineCompleted: (json['routineCompleted'] as num?)?.toInt() ?? 0,
      habitsChecked: (json['habitsChecked'] as num?)?.toInt() ?? 0,
      domainActivities: (json['domainActivities'] as num?)?.toInt() ?? 0,
      sleepHours: (json['sleepHours'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$WeeklyScoreImplToJson(_$WeeklyScoreImpl instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'score': instance.score,
      'routineCompleted': instance.routineCompleted,
      'habitsChecked': instance.habitsChecked,
      'domainActivities': instance.domainActivities,
      'sleepHours': instance.sleepHours,
    };

_$NotificationItemImpl _$$NotificationItemImplFromJson(
  Map<String, dynamic> json,
) => _$NotificationItemImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  body: json['body'] as String,
  timestamp: DateTime.parse(json['timestamp'] as String),
  isImportant: json['isImportant'] as bool? ?? false,
  category:
      $enumDecodeNullable(_$NotificationCategoryEnumMap, json['category']) ??
      NotificationCategory.system,
);

Map<String, dynamic> _$$NotificationItemImplToJson(
  _$NotificationItemImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'body': instance.body,
  'timestamp': instance.timestamp.toIso8601String(),
  'isImportant': instance.isImportant,
  'category': _$NotificationCategoryEnumMap[instance.category]!,
};

const _$NotificationCategoryEnumMap = {
  NotificationCategory.system: 'system',
  NotificationCategory.aiCoach: 'aiCoach',
  NotificationCategory.spiritual: 'spiritual',
  NotificationCategory.habit: 'habit',
};
