import 'dart:ui';

import '../../data/models/analytics_period.dart';
import '../../data/models/correlation_insight.dart';
import '../../data/models/domain_score_point.dart';
import '../../data/models/growth_index.dart';
import '../../data/models/habit_trend_point.dart';

sealed class AnalyticsState {
  const AnalyticsState();
}

final class AnalyticsInitial extends AnalyticsState {
  const AnalyticsInitial();
}

final class AnalyticsLoading extends AnalyticsState {
  const AnalyticsLoading();
}

final class AnalyticsLoaded extends AnalyticsState {
  const AnalyticsLoaded({
    required this.domainScores,
    required this.habitTrends,
    required this.growthIndex,
    required this.correlations,
    required this.selectedPeriod,
  });

  final List<DomainScorePoint> domainScores;
  final List<HabitTrendPoint> habitTrends;
  final GrowthIndex growthIndex;
  final List<CorrelationInsight> correlations;
  final AnalyticsPeriod selectedPeriod;
}

final class AnalyticsError extends AnalyticsState {
  const AnalyticsError(this.message, this.retry);

  final String message;
  final VoidCallback retry;
}
