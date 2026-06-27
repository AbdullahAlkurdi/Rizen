import 'package:freezed_annotation/freezed_annotation.dart';

part 'analytics_summary.freezed.dart';
part 'analytics_summary.g.dart';

@freezed
class AnalyticsSummary with _$AnalyticsSummary {
  const factory AnalyticsSummary({
    required double weeklyScore,
    required double habitCompletionRate,
    required double totalFinanceSpent,
    required Map<String, double> domainHoursThisWeek,
    required int quranPagesThisWeek,
    required int streakDays,
  }) = _AnalyticsSummary;

  factory AnalyticsSummary.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsSummaryFromJson(json);
}
