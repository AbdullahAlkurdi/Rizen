import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/analytics_repository.dart';
import '../../../habits/data/repositories/habits_repository.dart';
import '../../../finance/data/repositories/finance_repository.dart';
import '../../../domains/data/repositories/domain_logs_repository.dart';
import '../../../home/data/models/daily_score_model.dart';

sealed class AnalyticsState {}

final class AnalyticsInitial extends AnalyticsState {}

final class AnalyticsLoading extends AnalyticsState {}

final class AnalyticsLoaded extends AnalyticsState {
  AnalyticsLoaded({
    required this.weeklyScore,
    required this.habitCompletionRate,
    required this.totalFinanceSpent,
    required this.domainHoursThisWeek,
    required this.quranPagesThisWeek,
    required this.streakDays,
    this.trendData = const [],
  });

  final double weeklyScore;
  final double habitCompletionRate;
  final double totalFinanceSpent;
  final Map<String, double> domainHoursThisWeek;
  final int quranPagesThisWeek;
  final int streakDays;
  final List<DailyScore> trendData;
}

final class AnalyticsError extends AnalyticsState {
  AnalyticsError(this.message);
  final String message;
}

class AnalyticsCubit extends Cubit<AnalyticsState> {
  AnalyticsCubit({AnalyticsRepository? repository})
      : _repository = repository ?? AnalyticsRepository(
          habitsRepository: HabitsRepository(),
          financeRepository: FinanceRepository(),
          domainLogsRepository: DomainLogsRepository(),
        ),
        super(AnalyticsInitial());

  final AnalyticsRepository _repository;

  Future<void> loadWeeklySummary() async {
    emit(AnalyticsLoading());
    try {
      final summary = await _repository.getWeeklySummary();
      emit(AnalyticsLoaded(
        weeklyScore: summary.weeklyScore,
        habitCompletionRate: summary.habitCompletionRate,
        totalFinanceSpent: summary.totalFinanceSpent,
        domainHoursThisWeek: summary.domainHoursThisWeek,
        quranPagesThisWeek: summary.quranPagesThisWeek,
        streakDays: summary.streakDays,
      ));
    } catch (e) {
      emit(AnalyticsError(e.toString()));
    }
  }

  Future<void> loadTrendData() async {
    try {
      final trendData = await _repository.getTrendData();
      final current = state;
      if (current is AnalyticsLoaded) {
        emit(AnalyticsLoaded(
          weeklyScore: current.weeklyScore,
          habitCompletionRate: current.habitCompletionRate,
          totalFinanceSpent: current.totalFinanceSpent,
          domainHoursThisWeek: current.domainHoursThisWeek,
          quranPagesThisWeek: current.quranPagesThisWeek,
          streakDays: current.streakDays,
          trendData: trendData,
        ));
      } else {
        emit(AnalyticsLoaded(
          weeklyScore: 0,
          habitCompletionRate: 0,
          totalFinanceSpent: 0,
          domainHoursThisWeek: const {},
          quranPagesThisWeek: 0,
          streakDays: 0,
          trendData: trendData,
        ));
      }
    } catch (e) {
      emit(AnalyticsError(e.toString()));
    }
  }

  Future<void> loadAll() async {
    emit(AnalyticsLoading());
    try {
      final summary = await _repository.getWeeklySummary();
      final trendData = await _repository.getTrendData();
      emit(AnalyticsLoaded(
        weeklyScore: summary.weeklyScore,
        habitCompletionRate: summary.habitCompletionRate,
        totalFinanceSpent: summary.totalFinanceSpent,
        domainHoursThisWeek: summary.domainHoursThisWeek,
        quranPagesThisWeek: summary.quranPagesThisWeek,
        streakDays: summary.streakDays,
        trendData: trendData,
      ));
    } catch (e) {
      emit(AnalyticsError(e.toString()));
    }
  }
}
