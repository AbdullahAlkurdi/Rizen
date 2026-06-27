// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AnalyticsSummaryImpl _$$AnalyticsSummaryImplFromJson(
  Map<String, dynamic> json,
) => _$AnalyticsSummaryImpl(
  weeklyScore: (json['weeklyScore'] as num).toDouble(),
  habitCompletionRate: (json['habitCompletionRate'] as num).toDouble(),
  totalFinanceSpent: (json['totalFinanceSpent'] as num).toDouble(),
  domainHoursThisWeek: (json['domainHoursThisWeek'] as Map<String, dynamic>)
      .map((k, e) => MapEntry(k, (e as num).toDouble())),
  quranPagesThisWeek: (json['quranPagesThisWeek'] as num).toInt(),
  streakDays: (json['streakDays'] as num).toInt(),
);

Map<String, dynamic> _$$AnalyticsSummaryImplToJson(
  _$AnalyticsSummaryImpl instance,
) => <String, dynamic>{
  'weeklyScore': instance.weeklyScore,
  'habitCompletionRate': instance.habitCompletionRate,
  'totalFinanceSpent': instance.totalFinanceSpent,
  'domainHoursThisWeek': instance.domainHoursThisWeek,
  'quranPagesThisWeek': instance.quranPagesThisWeek,
  'streakDays': instance.streakDays,
};
