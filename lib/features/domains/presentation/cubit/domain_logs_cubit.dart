import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/domain_log_model.dart';
import '../../data/repositories/domain_logs_repository.dart';

sealed class DomainLogsState {}

final class DomainLogsInitial extends DomainLogsState {}

final class DomainLogsLoading extends DomainLogsState {}

final class DomainLogsLoaded extends DomainLogsState {
  DomainLogsLoaded({
    required this.logs,
    required this.summary,
    this.todayLogs = const [],
    this.weeklySummary = const {},
  });

  final List<DomainLog> logs;
  final ({double weeklyHours, int streak, double progress}) summary;
  final List<DomainLog> todayLogs;
  final Map<String, double> weeklySummary;
}

final class DomainLogsError extends DomainLogsState {
  final String message;
  DomainLogsError(this.message);
}

class DomainLogsCubit extends Cubit<DomainLogsState> {
  DomainLogsCubit({DomainLogsRepository? repository})
    : _repository = repository ?? DomainLogsRepository(),
      super(DomainLogsInitial());

  final DomainLogsRepository _repository;

  Future<void> loadLogs(String domainId) async {
    emit(DomainLogsLoading());
    try {
      final logs = await _repository.getLogsByDomain(domainId);
      final summary = _computeSummary(logs);
      emit(DomainLogsLoaded(logs: logs, summary: summary));
    } catch (e) {
      emit(DomainLogsError(e.toString()));
    }
  }

  Future<void> loadTodayLogs() async {
    emit(DomainLogsLoading());
    try {
      final todayLogs = await _repository.getTodayLogs();
      final summary = _computeSummary(todayLogs);
      emit(DomainLogsLoaded(logs: todayLogs, summary: summary, todayLogs: todayLogs));
    } catch (e) {
      emit(DomainLogsError(e.toString()));
    }
  }

  Future<void> loadWeeklySummary() async {
    emit(DomainLogsLoading());
    try {
      final weeklySummary = await _repository.getWeeklySummary();
      final allLogs = await _repository.getTodayLogs();
      final summary = _computeSummary(allLogs);
      emit(DomainLogsLoaded(logs: allLogs, summary: summary, weeklySummary: weeklySummary));
    } catch (e) {
      emit(DomainLogsError(e.toString()));
    }
  }

  Future<void> addDomainLog(DomainLog log) async {
    emit(DomainLogsLoading());
    try {
      await _repository.addLogFromModel(log);
      await loadLogs(log.domainId);
    } catch (e) {
      emit(DomainLogsError(e.toString()));
    }
  }

  Future<String> addLog({
    required String domainId,
    required int duration,
    int intensity = 5,
    String? notes,
    String? metricLabel,
    double? metricValue,
  }) async {
    emit(DomainLogsLoading());
    try {
      final logId = await _repository.addLogAndGetId(
        domainId: domainId,
        duration: duration,
        intensity: intensity,
        notes: notes,
        metricLabel: metricLabel,
        metricValue: metricValue,
      );
      await loadLogs(domainId);
      return logId;
    } catch (e) {
      emit(DomainLogsError(e.toString()));
      rethrow;
    }
  }

  Future<void> updateLog(DomainLog log) async {
    emit(DomainLogsLoading());
    try {
      await _repository.updateLog(log);
      await loadLogs(log.domainId);
    } catch (e) {
      emit(DomainLogsError(e.toString()));
    }
  }

  Future<void> deleteLog(String logId, String domainId) async {
    emit(DomainLogsLoading());
    try {
      await _repository.deleteLog(logId);
      await loadLogs(domainId);
    } catch (e) {
      emit(DomainLogsError(e.toString()));
    }
  }

  Future<void> loadDomainSummary(String domainId) async {
    emit(DomainLogsLoading());
    try {
      final logs = await _repository.getLogsByDomain(domainId);
      final streak = await _repository.getDomainStreak(domainId);
      final summary = _computeSummary(logs);
      final updatedSummary = (weeklyHours: summary.weeklyHours, streak: streak, progress: summary.progress);
      emit(DomainLogsLoaded(logs: logs, summary: updatedSummary));
    } catch (e) {
      emit(DomainLogsError(e.toString()));
    }
  }

  ({double weeklyHours, int streak, double progress}) _computeSummary(
    List<DomainLog> logs,
  ) {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday));

    final weekLogs = logs
        .where((log) => log.loggedAt.isAfter(weekStart))
        .toList();
    final weeklyHours = weekLogs.fold<double>(
      0,
      (sum, log) => sum + log.duration / 60,
    );

    int streak = 0;
    var checkDate = DateTime(now.year, now.month, now.day);
    while (true) {
      final hasLog = logs.any(
        (log) =>
            log.loggedAt.year == checkDate.year &&
            log.loggedAt.month == checkDate.month &&
            log.loggedAt.day == checkDate.day,
      );
      if (!hasLog) break;
      streak++;
      checkDate = checkDate.subtract(const Duration(days: 1));
    }

    final progress = weeklyHours >= 10 ? 1.0 : weeklyHours / 10;

    return (weeklyHours: weeklyHours, streak: streak, progress: progress);
  }
}
